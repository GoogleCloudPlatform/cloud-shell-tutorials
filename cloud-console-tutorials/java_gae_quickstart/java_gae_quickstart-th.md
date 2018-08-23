# การเริ่มต้น App Engine อย่างรวดเร็ว

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## บทนำ

บทแนะนำนี้จะแสดงวิธีทำให้แอปพลิเคชัน [Java][java] ตัวอย่างใช้งานได้บน Google App
Engine โดยใช้ปลั๊กอิน App Engine Maven

ขั้นตอนต่างๆ ที่คุณจะต้องทำตามมีดังนี้

*   **สร้างและเรียกใช้แอป "Hello, world!"**

    คุณจะได้เรียนรู้วิธีเรียกใช้แอปโดยใช้ Google Cloud Shell จากในเบราว์เซอร์
    และในขั้นตอนสุดท้ายคุณจะได้ทำให้แอปใช้งานได้บนเว็บโดยใช้ปลั๊กอิน App Engine
    Maven

*   **หลังจากทำให้แอปใช้งานได้...**

    แอปของคุณจะใช้งานได้จริงและคุณจะทดสอบแอปได้หลังจากทำให้ใช้งานได้แล้ว
    หรือคุณจะเลือกนำออกแล้วเปิดใช้ใหม่ตั้งแต่ต้นก็ได้เช่นกัน

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## การตั้งค่าโครงการ

คุณต้องสร้างโครงการก่อนเพื่อที่จะทำให้แอปพลิเคชันใช้งานได้

Google Cloud Platform จัดระเบียบทรัพยากรลงในโครงการต่างๆ
ซึ่งจะช่วยให้คุณเก็บรวบรวมทรัพยากรที่เกี่ยวข้องสำหรับแอปพลิเคชันเดียวได้ในที่เดียว

<walkthrough-project-setup/>

## การใช้ Google Cloud Shell

Cloud Shell คือเครื่องมือบรรทัดคำสั่งในตัวสำหรับคอนโซล ซึ่งเราจะใช้ Cloud Shell
ในการทำให้แอปใช้งานได้

### เปิด Google Cloud Shell

เปิด Cloud Shell โดยคลิกที่ <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
ในแถบนำทางที่ด้านบนของคอนโซล

### โคลนโค้ดตัวอย่าง

ใช้ Cloud Shell เพื่อโคลนและนำทางไปยังโค้ด "Hello World"
ระบบจะโคลนโค้ดตัวอย่างจากที่เก็บโครงการไปยัง Cloud Shell

หมายเหตุ: หากมีไดเรกทอรีอยู่แล้ว ให้นำไฟล์ก่อนหน้าออกก่อนที่จะทำการโคลนดังนี้

```bash
rm -rf {{repo-name}}
```

ป้อนข้อมูลต่อไปนี้ใน Cloud Shell

```bash
git clone {{repo-url}}
```

จากนั้นให้สลับไปยังไดเรกทอรีบทแนะนำดังนี้

```bash
cd {{repo-name}}
```

## การกำหนดค่าการทำให้ใช้งานได้

ขณะนี้คุณอยู่ในไดเรกทอรีหลักสำหรับโค้ดตัวอย่างแล้ว
มาลองดูไฟล์ที่ใช้กำหนดค่าแอปพลิเคชันกันเลย

### การสำรวจแอปพลิเคชัน

ป้อนคำสั่งดังต่อไปนี้เพื่อดูโค้ดของแอปพลิเคชัน

```bash
src/main/java/myapp/DemoServlet.java
```

เซิร์ฟเล็ตนี้ตอบสนองต่อทุกคำขอ โดยส่งการตอบสนองพร้อมข้อความ `Hello, world!`

### การสำรวจการกำหนดค่า

สำหรับ Java แล้ว Google App Engine ใช้ไฟล์ XML
เพื่อระบุการกำหนดค่าของการทำให้ใช้งานได้

ป้อนคำสั่งต่อไปนี้เพื่อดูไฟล์การกำหนดค่า

```bash
cat pom.xml
```

แอป `helloworld` ใช้ Maven ซึ่งหมายความว่าคุณต้องระบุโมเดลวัตถุของโครงการหรือ
POM ที่ประกอบไปด้วยข้อมูลเกี่ยวกับโครงการและรายละเอียดการกำหนดค่าที่ Maven
ใช้ในการสร้างโครงการ

## การทดสอบแอป

### ทดสอบแอปบน Cloud Shell

Cloud Shell
ช่วยให้คุณทดสอบแอปก่อนที่จะทำให้ใช้งานได้เพื่อให้มั่นใจว่าแอปนั้นทำงานได้ตามต้องการ
เช่นเดียวกับการแก้ไขข้อบกพร่องบนเครื่องภายใน

ในการทดสอบแอป ให้ป้อนคำสั่งดังนี้

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### แสดงตัวอย่างแอปด้วย "ตัวอย่างเว็บ"

ตอนนี้แอปทำงานใน Cloud Shell แล้ว คุณเข้าถึงแอปได้โดยใช้ "ตัวอย่างเว็บ"
<walkthrough-web-preview-icon/> เพื่อเชื่อมต่อไปยังพอร์ต 8080
[แสดงวิธีทำ](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### การยุติการแสดงตัวอย่างอินสแตนซ์

ยุติอินสแตนซ์ของแอปพลิเคชันได้โดยการกด `Ctrl+C` ใน Cloud Shell

## การทำให้ใช้งานได้ใน Google App Engine

### สร้างแอปพลิเคชัน

เราจำเป็นต้องสร้างแอปในภูมิภาค เพื่อทำให้แอปใช้งานได้ดังนี้

```bash
gcloud app create
```

หมายเหตุ: หากสร้างแอปไว้อยู่แล้ว คุณข้ามขั้นตอนนี้ได้เลย

### การทำให้ใช้งานได้ด้วย Cloud Shell

ตอนนี้คุณใช้ Cloud Shell เพื่อทำให้แอปใช้งานได้แล้ว ก่อนอื่น

ให้เลือกโครงการที่จะใช้ดังนี้

```bash
gcloud config set project {{project-id}}
```

จากนั้นจึงทำให้แอปใช้งานได้ดังนี้

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### ไปที่แอป

แอปของคุณใช้ได้งานแล้ว URL เริ่มต้นของแอปคือ
[{{project-gae-url}}](http://{{project-gae-url}}) ให้คลิกที่ URL เพื่อไปที่แอป

### ดูสถานะของแอป

คุณตรวจสอบในแอปได้ โดยการตรวจสอบสถานะบนหน้าแดชบอร์ดของ App Engine

เปิด ["เมนู](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)
ที่ด้านซ้ายของคอนโซล

จากนั้นจึงเลือกหัวข้อ **App Engine**

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## บทสรุป

<walkthrough-conclusion-trophy/>

ขอแสดงความยินดีด้วย คุณทำให้แอปพลิเคชัน App Engine ใช้งานได้สำเร็จแล้ว!
นี่คือขั้นตอนต่อไปอีกเล็กน้อย

**ดาวน์โหลด Google Cloud SDK แล้วพัฒนาภายใน**

[Google Cloud SDK][cloud-sdk-installer]

**สร้างแอปพลิเคชันถัดไป**

เรียนรู้วิธีใช้ App Engine กับผลิตภัณฑ์อื่นๆ ของ Google Cloud Platform ได้ดังนี้

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**เรียนรู้วิธีใช้ Cloud Datastore**
Cloud Datastore เป็นฐานข้อมูล NoSQL ที่รองรับการปรับขนาดสำหรับแอปพลิเคชันของคุณ
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**เรียนรู้วิธีใช้ Cloud Storage**
Cloud Storage เป็นบริการจัดเก็บวัตถุที่มีประสิทธิภาพและใช้งานง่าย
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
