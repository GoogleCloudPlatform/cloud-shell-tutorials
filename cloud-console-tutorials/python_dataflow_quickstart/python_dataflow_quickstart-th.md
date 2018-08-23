# บทแนะนำเกี่ยวกับจำนวนคำของ Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## บทนำ

ในบทแนะนำนี้ คุณจะได้เรียนรู้ข้อมูลพื้นฐานของบริการ Cloud Dataflow ด้วยการเรียกใช้ไปป์ไลน์ตัวอย่างง่ายๆ โดยใช้ Python

ไปป์ไลน์ Dataflow อาจเป็นไปป์ไลน์แบบ*กลุ่ม* (การประมวลผลอินพุตที่มีการควบคุม เช่น ไฟล์หรือตารางฐานข้อมูล) หรือแบบ*สตรีมมิง* (การประมวลผลอินพุตที่ไม่มีการควบคุมจากแหล่งที่มาเช่น Cloud Pub/Sub) ตัวอย่างในบทแนะนำนี้คือไปป์ไลน์แบบกลุ่มที่นับจำนวนคำในชุดผลงานของเชกสเปียร์

ก่อนเริ่มต้น คุณจะต้องตรวจสอบข้อกำหนดเบื้องต้นในโปรเจ็กต์ Cloud Platform และทำการตั้งค่าเริ่มต้น

## ตั้งค่าโปรเจ็กต์

Google Cloud Platform จะจัดทรัพยากรลงในโปรเจ็กต์ต่างๆ ซึ่งช่วยให้คุณรวบรวมทรัพยากรที่เกี่ยวข้องทั้งหมดของแอปพลิเคชันหนึ่งไว้ในที่เดียวได้

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

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ไอคอน][spotlight-open-devshell]ในแถบนำทางที่ด้านบนของคอนโซล

## ติดตั้งตัวอย่าง Cloud Dataflow บน Cloud Shell

Cloud Dataflow เวอร์ชัน Python จำเป็นต้องใช้สภาพแวดล้อมการพัฒนาที่มี Python, Google Cloud SDK และ Cloud Dataflow SDK สำหรับ Python
นอกจากนี้ Cloud Dataflow ยังใช้ PIP ซึ่งเป็นตัวจัดการแพ็กเกจของ Python เพื่อจัดการการอ้างอิงของ SDK อีกด้วย

บทแนะนำนี้จะใช้ Cloud Shell ที่มีการติดตั้ง Python และ PIP ไว้แล้ว ทั้งนี้คุณอาจดำเนินการบทแนะนำนี้[บนเครื่องภายในของคุณ][dataflow-python-tutorial]ได้ หากต้องการ

### ดาวน์โหลดตัวอย่างและ Cloud Dataflow SDK สำหรับ Python โดยใช้คำสั่ง PIP

เมื่อคุณเรียกใช้คำสั่งนี้ PIP จะดาวน์โหลดและติดตั้ง Cloud Dataflow SDK เวอร์ชันที่เหมาะสม

```bash
pip install --user google-cloud-dataflow
```

เรียกใช้คำสั่ง PIP ใน Cloud Shell

## ตั้งค่าที่เก็บข้อมูล Cloud Storage

Cloud Dataflow จะใช้ที่เก็บข้อมูล Cloud Storage ในการจัดเก็บข้อมูลเอาต์พุตและแคชโค้ดไปป์ไลน์

### เรียกใช้ gsutil mb

ใน Cloud Shell ให้ใช้คำสั่ง `gsutil mb` เพื่อสร้างที่เก็บข้อมูล Cloud Storage

```bash
gsutil mb gs://{{project-id-no-domain}}
```

โปรดดู[เอกสารประกอบ][gsutil-docs]เพื่อดูข้อมูลเพิ่มเติมเกี่ยวกับเครื่องมือ `gsutil`

## สร้างและเรียกใช้ไปป์ไลน์

ใน Cloud Dataflow งานการประมวลผลข้อมูลจะแสดงโดย*ไปป์ไลน์* ไปป์ไลน์จะอ่านข้อมูลอินพุต ดำเนินการเปลี่ยนรูปแบบข้อมูลดังกล่าวแล้วสร้างข้อมูลเอาต์พุต การเปลี่ยนรูปแบบของไปป์ไลน์อาจรวมถึงการกรอง การจัดกลุ่ม การเปรียบเทียบ หรือการรวมข้อมูล

### เรียกใช้ไปป์ไลน์ในบริการ Dataflow

ใช้ Python เพื่อเปิดใช้ไปป์ไลน์ในบริการ Cloud Dataflow ไปป์ไลน์ที่กำลังทำงานอยู่จะเรียกว่า*งาน*

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  `output` คือที่เก็บข้อมูลที่ใช้โดยตัวอย่าง WordCount เพื่อจัดเก็บผลการทำงาน

### งานกำลังทำงาน

ยินดีด้วย! ขณะนี้ไบนารีของคุณอยู่ในที่เก็บข้อมูลที่คุณสร้างขึ้นก่อนหน้านี้แล้ว และระบบกำลังสร้างอินสแตนซ์ของ Compute Engine จากนั้น Cloud Dataflow จะแยกไฟล์อินพุตเพื่อให้ข้อมูลของคุณสามารถประมวลผลโดยใช้หลายเครื่องพร้อมกันได้

หมายเหตุ: เมื่อเห็นข้อความ "JOB_STATE_DONE" คุณจะปิด Cloud Shell ได้

## ตรวจสอบงาน

ตรวจสอบความคืบหน้าของไปป์ไลน์ของคุณบนหน้า Cloud Dataflow

### ไปที่หน้า Cloud Dataflow Monitoring UI

หากยังไม่ได้ดำเนินการ โปรดไปที่หน้า UI ของ Cloud Dataflow Monitoring

เปิด[เมนู][spotlight-console-menu]ทางด้านซ้ายของคอนโซล

จากนั้น เลือกส่วน **Dataflow**

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### เลือกงาน

คลิกที่งานของคุณเพื่อดูรายละเอียด

### สำรวจรายละเอียดไปป์ไลน์และเมตริก

สำรวจไปป์ไลน์ทางด้านซ้ายและข้อมูลงานทางด้านขวา หากต้องการดูสถานะงานโดยละเอียด ให้คลิก[บันทึก][spotlight-job-logs] ลองคลิกที่ขั้นตอนในไปป์ไลน์เพื่อดูเมตริกของขั้นตอนนั้น

เมื่องานเสร็จสิ้น คุณจะเห็นว่าสถานะของงานเปลี่ยนไป และอินสแตนซ์ของ Compute Engine ที่งานนั้นใช้อยู่จะหยุดทำงานโดยอัตโนมัติ

## ดูเอาต์พุตของคุณ

ขณะนี้งานของคุณได้ทำงานแล้ว คุณสำรวจไฟล์เอาต์พุตใน Cloud Storage ได้

### ไปที่หน้า Cloud Storage

เปิด[เมนู][spotlight-console-menu]ทางด้านซ้ายของคอนโซล

จากนั้น เลือกส่วน **Compute Engine**

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### ไปยังที่เก็บข้อมูลของพื้นที่เก็บข้อมูล

ในรายการที่เก็บข้อมูล ให้เลือกที่เก็บข้อมูลที่คุณสร้างขึ้นก่อนหน้านี้ หากคุณใช้ชื่อที่แนะนำ ที่เก็บข้อมูลนี้จะมีชื่อว่า `{{project-id}}`

ที่เก็บข้อมูลมีโฟลเดอร์สำหรับเก็บพักข้อมูลและโฟลเดอร์เอาต์พุต Dataflow จะบันทึกเอาต์พุตเป็นชาร์ด ดังนั้นที่เก็บข้อมูลของคุณจะมีไฟล์เอาต์พุตหลายไฟล์

## ล้างข้อมูล

โปรดลบที่เก็บข้อมูลที่คุณสร้างขึ้นเพื่อป้องกันการถูกเรียกเก็บเงินจากการใช้งาน Cloud Storage

### กลับไปที่เบราว์เซอร์ของที่เก็บข้อมูล

คลิกลิงก์[ที่เก็บข้อมูล][spotlight-buckets-link]

### เลือกที่เก็บข้อมูล

ทำเครื่องหมายในช่องข้างที่เก็บข้อมูลที่คุณสร้างขึ้น

### ลบที่เก็บข้อมูล

คลิก[ลบ][spotlight-delete-bucket]และยืนยันการลบ

## บทสรุป

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

สิ่งที่คุณทำต่อไปได้มีดังนี้

  *  [อ่านเพิ่มเติมเกี่ยวกับตัวอย่างการนับจำนวนคำ][wordcount]
  *  [ดูข้อมูลเกี่ยวกับรูปแบบการเขียนโปรแกรมของ Cloud Dataflow][df-pipelines]
  *  [สำรวจ Apache Beam SDK บน GitHub][beam-sdk]

ตั้งค่าสภาพแวดล้อมในเครื่องของคุณ:

  *  [ใช้ Java และ Eclipse ในการเรียกใช้ Dataflow][df-eclipse]
  *  [ใช้ Java และ Maven ในการเรียกใช้ Dataflow][df-maven]

[beam-sdk]: https://github.com/apache/beam/tree/master/sdks/python
[dataflow-python-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-maven]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-pipelines]: https://cloud.google.com/dataflow/model/programming-model-beam
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
