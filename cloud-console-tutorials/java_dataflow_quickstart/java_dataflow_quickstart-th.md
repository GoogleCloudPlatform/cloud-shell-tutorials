# บทแนะนำเกี่ยวกับจำนวนคำของ Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## บทนำ

ในบทแนะนำนี้ คุณจะได้เรียนรู้พื้นฐานของบริการ Cloud Dataflow ด้วยการเรียกใช้ไปป์ไลน์ตัวอย่างง่ายๆ โดยใช้ Java

ไปป์ไลน์ Dataflow อาจเป็นไปป์ไลน์แบบ*กลุ่ม* (การประมวลผลอินพุตที่มีการควบคุม เช่น ไฟล์หรือตารางฐานข้อมูล) หรือแบบ*สตรีมมิง* (การประมวลผลอินพุตที่ไม่มีการควบคุมจากแหล่งที่มาเช่น Cloud Pub/Sub) ก็ได้ ตัวอย่างในบทแนะนำนี้คือไปป์ไลน์แบบกลุ่มที่นับจำนวนคำในชุดผลงานของเชกสเปียร์

ก่อนเริ่มต้น คุณจะต้องตรวจสอบข้อกำหนดเบื้องต้นในโครงการ Cloud Platform ของคุณ และตั้งค่าเริ่มต้น

## ตั้งค่าโครงการ

Google Cloud Platform จะจัดทรัพยากรลงในโครงการต่างๆ ซึ่งช่วยให้คุณรวบรวมทรัพยากรที่เกี่ยวข้องทั้งหมดของแอปพลิเคชันหนึ่งไว้ในที่เดียวได้

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## ตั้งค่า Cloud Dataflow

ในการใช้ Dataflow คุณต้องเปิด API ของ Cloud Dataflow และเปิด Cloud Shell

### เปิด API ของ Google Cloud

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### เปิด Cloud Shell

Cloud Shell เป็นเครื่องมือบรรทัดคำสั่งในตัวสำหรับคอนโซล คุณจะใช้ Cloud Shell เพื่อทำให้แอปใช้งานได้

เปิด Cloud Shell โดยการคลิก
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[ไอคอน][spotlight-open-devshell]ในแถบนำทางที่ด้านบนของคอนโซล

## ติดตั้งตัวอย่าง Cloud Dataflow บน Cloud Shell

ในการใช้ Cloud Dataflow SDK สำหรับ Java สภาพแวดล้อมการพัฒนาจะต้องใช้ Java, Google Cloud SDK, Cloud Dataflow SDK สำหรับ Java และ Apache Maven สำหรับการจัดการการอ้างอิงของ SDK บทแนะนำนี้ใช้ Cloud Shell ที่มีการติดตั้ง Java, Google Cloud SDK และ Maven ไว้แล้ว

หรือคุณอาจดำเนินบทแนะนำนี้[บนเครื่องภายในของคุณ][dataflow-java-tutorial]ก็ได้

### ดาวน์โหลดตัวอย่างและ Cloud Dataflow SDK สำหรับ Java โดยใช้คำสั่ง Maven

เมื่อคุณเรียกใช้คำสั่งนี้ Maven จะสร้างโครงสร้างโครงการและไฟล์การกำหนดค่าสำหรับการดาวน์โหลดเวอร์ชัน SDK ของ Cloud Dataflow ที่เหมาะสม

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{directory}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

  *  `archetypeArtifactId` และ `archetypeGroupId` จะใช้เพื่อกำหนดโครงสร้างของโครงการตัวอย่าง
  *  `groupId` คือคำนำหน้าชื่อแพ็กเกจ Java ขององค์กร ตัวอย่างเช่น `com.mycompany`
  *  `artifactId` จะตั้งชื่อของไฟล์ Jar ที่สร้างขึ้น ใช้ค่าเริ่มต้น ( `{{directory}}` ) เพื่อวัตถุประสงค์ของบทแนะนำนี้

เรียกใช้คำสั่ง Maven ใน Cloud Shell

### เปลี่ยนไดเรกทอรี

เปลี่ยนไดเรกทอรีการทำงานเป็น `{{directory}}`

```bash
cd {{directory}}
```

หากต้องการดูโค้ดสำหรับตัวอย่างนี้ คุณจะหาโค้ดดังกล่าวได้ในไดเรกทอรีย่อย `src` ในไดเรกทอรี `{{directory}}`

## ตั้งค่าที่เก็บข้อมูล Cloud Storage

Cloud Dataflow จะใช้ที่เก็บข้อมูล Cloud Storage ในการจัดเก็บข้อมูลเอาต์พุตและแคชโค้ดไปป์ไลน์ของคุณ

### เรียกใช้ gsutil mb

ใน Cloud Shell ให้ใช้คำสั่ง `gsutil mb` เพื่อสร้างที่เก็บข้อมูล Cloud Storage

```bash
gsutil mb gs://{{project-id-no-domain}}
```

สำหรับข้อมูลเพิ่มเติมเกี่ยวกับเครื่องมือ `gsutil` โปรดดู[เอกสารประกอบ][gsutil-docs]

## สร้างและเรียกใช้ไปป์ไลน์

ใน Cloud Dataflow งานการประมวลผลข้อมูลจะแสดงโดย*ไปป์ไลน์* ไปป์ไลน์จะอ่านข้อมูลอินพุต ดำเนินการเปลี่ยนรูปแบบข้อมูลดังกล่าว และสร้างข้อมูลเอาต์พุต การเปลี่ยนรูปแบบของไปป์ไลน์อาจรวมถึงการกรอง การจัดกลุ่ม การเปรียบเทียบ หรือการรวมข้อมูล

หากต้องการดูโค้ดสำหรับตัวอย่างนี้ คุณจะหาโค้ดดังกล่าวได้ในไดเรกทอรีย่อย `src` ในไดเรกทอรี `{{directory}}`

### เรียกใช้ไปป์ไลน์ของคุณบนบริการ Dataflow

ใช้คำสั่ง `mvn exec` ของ Apache Maven เพื่อเปิดใช้งานไปป์ไลน์ของคุณในบริการ
ไปป์ไลน์ที่กำลังทำงานอยู่จะเรียกว่า*งาน*

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation` คือพื้นที่เก็บข้อมูลที่ Cloud Dataflow จะใช้สำหรับไบนารีและข้อมูลอื่นๆ ในการเรียกใช้ไปป์ไลน์ ตำแหน่งที่ตั้งนี้แชร์กับหลายๆ งานได้
  *  `output` คือที่เก็บข้อมูลที่ใช้โดยตัวอย่าง WordCount เพื่อจัดเก็บผลการทำงาน

### งานกำลังทำงาน

ยินดีด้วย! ขณะนี้ไบนารีของคุณอยู่ในที่เก็บข้อมูลที่คุณสร้างขึ้นก่อนหน้านี้แล้ว และระบบกำลังสร้างอินสแตนซ์ของ Compute Engine จากนั้น Cloud Dataflow จะแยกไฟล์อินพุตเพื่อให้ข้อมูลของคุณประมวลผลโดยใช้หลายเครื่องพร้อมกันได้

หมายเหตุ: เมื่อคุณเห็นข้อความ "งานเสร็จแล้ว" คุณจะปิด Cloud Shell ได้

หากต้องการล้างโครงการ Maven ที่คุณได้สร้างขึ้น ให้เรียกใช้ `cd .. && rm -R {{directory}}` ใน Cloud Shell เพื่อลบไดเร็กทอรีนั้นๆ

## ตรวจสอบงาน

ตรวจสอบความคืบหน้าของไปป์ไลน์บนหน้า UI ของ Cloud Dataflow Monitoring

### ไปที่หน้า Cloud Dataflow

เปิด[เมนู][spotlight-console-menu]ทางด้านซ้ายของคอนโซล

จากนั้น เลือกหัวข้อ **Dataflow**

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### เลือกงาน

คลิกที่งานเพื่อดูรายละเอียด

### สำรวจรายละเอียดไปป์ไลน์และเมตริก

สำรวจไปป์ไลน์ทางด้านซ้ายและข้อมูลงานทางด้านขวา หากต้องการดูสถานะงานโดยละเอียด ให้คลิก[บันทึก][spotlight-job-logs] ลองคลิกที่ขั้นตอนหนึ่งๆ ในไปป์ไลน์เพื่อดูเมตริกของขั้นตอนนั้น

เมื่องานเสร็จสิ้น คุณจะเห็นว่าสถานะของงานเปลี่ยนไป และอินสแตนซ์ของ Compute Engine ที่งานนั้นใช้อยู่จะหยุดทำงานโดยอัตโนมัติ

## ดูเอาต์พุต

ขณะนี้งานของคุณได้ทำงานแล้ว คุณจะสำรวจไฟล์เอาต์พุตใน Cloud Storage ได้แล้ว

### ไปที่หน้า Cloud Storage

เปิด[เมนู][spotlight-console-menu]ทางด้านซ้ายของคอนโซล

จากนั้นเลือกส่วน**พื้นที่เก็บข้อมูล**

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### ไปยังที่เก็บข้อมูลของพื้นที่เก็บข้อมูล

ในรายการที่เก็บข้อมูล ให้เลือกที่เก็บข้อมูลที่คุณสร้างขึ้นก่อนหน้านี้ หากใช้ชื่อที่แนะนำ ที่เก็บข้อมูลนี้จะมีชื่อว่า `{{project-id}}`

ที่เก็บข้อมูลมีโฟลเดอร์สำหรับเก็บพักข้อมูลและโฟลเดอร์เอาต์พุต Dataflow จะบันทึกเอาต์พุตเป็นชาร์ด ดังนั้น ที่เก็บข้อมูลจะมีไฟล์เอาต์พุตหลายไฟล์

## ล้างข้อมูล

เพื่อป้องกันการถูกเรียกเก็บเงินจากการใช้งาน Cloud Storage โปรดลบที่เก็บข้อมูลที่คุณสร้างขึ้น

### กลับไปที่เบราว์เซอร์ของที่เก็บข้อมูล

คลิกลิงก์[ที่เก็บข้อมูล][spotlight-buckets-link]

### เลือกที่เก็บข้อมูล

ทำเครื่องหมายในช่องข้างที่เก็บข้อมูลที่คุณสร้างขึ้น

### ลบที่เก็บข้อมูล

คลิก[ลบ][spotlight-delete-bucket] และยืนยันการลบ

## บทสรุป

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

สิ่งที่คุณทำต่อไปได้มีดังนี้

  *  [อ่านเพิ่มเติมเกี่ยวกับตัวอย่างการนับจำนวนคำ][wordcount]
  *  [เรียนรู้เกี่ยวกับรูปแบบการเขียนโปรแกรมของ Cloud Dataflow][df-model]
  *  [สำรวจ Cloud Dataflow SDK บน GitHub][df-sdk]

ตั้งค่าสภาพแวดล้อมในเครื่องของคุณ:

  *  [ใช้ Eclipse เพื่อเรียกใช้ Dataflow][df-eclipse]
  *  [ใช้ Python เพื่อเรียกใช้ Dataflow][df-python]

[dataflow-java-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-model]: https://cloud.google.com/dataflow/model/programming-model-beam
[df-python]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-sdk]: https://github.com/apache/beam/tree/master/sdks/java
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
