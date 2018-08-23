# เริ่มต้น App Engine อย่างรวดเร็ว

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## บทนำ

บทแนะนำนี้จะแสดงวิธีทำให้แอปพลิเคชัน [Python](https://python.org/)
ตัวอย่างใช้งานได้ใน Google App Engine ด้วยคำสั่ง `gcloud`

ต่อไปนี้เป็นขั้นตอนต่างๆ ที่คุณจะต้องทำ

  *  **สร้างโปรเจ็กต์**

     โปรเจ็กต์จะรวมโค้ด, VM และทรัพยากรอื่นๆ ไว้ด้วยกันเพื่อการพัฒนาและการตรวจสอบที่ง่ายขึ้น

  *  **สร้างและเรียกใช้แอป "Hello, world!" **

     คุณจะได้เรียนรู้วิธีเรียกใช้แอปโดยใช้ Google Cloud Shell จากในเบราว์เซอร์ ในตอนท้ายสุดคุณจะได้ปรับใช้แอปบนเว็บโดยใช้คำสั่ง `gcloud`

  *  **หลังจากบทแนะนำ...**

     แอปของคุณจะใช้ได้จริงและจะคุณจะทดสอบแอปหลังปรับใช้ หรือนำแอปออกแล้วเริ่มต้นใหม่ได้

["Python" และโลโก้ Python เป็นเครื่องหมายการค้าหรือเครื่องหมายการค้าจดทะเบียนของ
Python Software Foundation](walkthrough://footnote)

## ตั้งค่าโครงการ

คุณต้องสร้างโครงการก่อน จึงจะทำให้แอปพลิเคชันใช้งานได้

Google Cloud Platform จะจัดทรัพยากรลงในโครงการต่างๆ ซึ่งช่วยให้คุณรวบรวมทรัพยากรที่เกี่ยวข้องทั้งหมดของแอปพลิเคชันหนึ่งไว้ในที่เดียวได้

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## การใช้ Google Cloud Shell

Cloud Shell เป็นเครื่องมือบรรทัดคำสั่งในตัวสำหรับคอนโซล เราจะใช้ Cloud Shell ในการทำให้ใช้งานได้แอป

### เปิด Google Cloud Shell

เปิด Cloud Shell โดยคลิกที่ไอคอน
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[][spotlight-open-devshell]ในแถบนำทางด้านบนของคอนโซล

### โคลนโค้ดตัวอย่าง

ใช้ Cloud Shell เพื่อโคลนและไปที่โค้ด "Hello World" ระบบจะจำลองโค้ดตัวอย่างจากที่เก็บโครงการและส่งไปยัง Cloud Shell

หมายเหตุ: หากมีไดเรกทอรีอยู่แล้ว ให้นำไฟล์ก่อนหน้าออกก่อนการโคลน.

ใน Cloud Shell ให้ป้อน:

```bash
git clone {{repo-url}}
```

จากนั้น ให้สลับไปที่ไดเรกทอรีบทแนะนำ

```bash
cd {{repo-dir}}
```

## การกำหนดค่าการทำให้ใช้งานได้

ตอนนี้คุณอยู่ในไดเรกทอรีหลักของโค้ดตัวอย่างแล้ว เราจะดูไฟล์ที่กำหนดค่าแอปพลิเคชัน

### สำรวจแอปพลิเคชัน

ป้อนคำสั่งต่อไปนี้เพื่อดูโค้ดของแอปพลิเคชัน

```bash
cat main.py
```

แอปพลิเคชันนี้เป็นแอปพลิเคชัน Python ที่เรียบง่ายซึ่งใช้เว็บเฟรมเวิร์ก [webapp2](https://webapp2.readthedocs.io/) สคริปต์ Python นี้ตอบสนองคำขอด้วยส่วนหัว HTTP และข้อความ `Hello, World!`

### สำรวจการกำหนดค่า

Google App Engine จะใช้ไฟล์ YAML เพื่อระบุการกำหนดค่าของการทำให้ใช้งานได้
ไฟล์ `app.yaml` มีข้อมูลเกี่ยวกับแอปพลิเคชันของคุณ เช่น สภาพแวดล้อมรันไทม์ เครื่องจัดการ URL และอื่นๆ อีกมากมาย

ป้อนคำสั่งต่อไปนี้เพื่อดูไฟล์การกำหนดค่า

```bash
cat app.yaml
```

ไฟล์การกำหนดค่าแสดงข้อมูลต่อไปนี้เกี่ยวกับแอปพลิเคชันเรียงจากบนลงล่าง

  *  โค้ดนี้ทำงานในสภาพแวดล้อมรันไทม์ของ `python`
  *  แอปพลิเคชันนี้คือ `threadsafe` ดังนั้นอินสแตนซ์เดียวกันจะจัดการคำขอหลายรายการพร้อมกันได้ Threadsafe เป็นฟีเจอร์ขั้นสูงและอาจทำให้การทำงานบกพร่องหากแอปพลิเคชันไม่ได้ออกแบบมาให้เป็น Threadsafe โดยเฉพาะ
  *  คุณควรกำหนดให้วัตถุของแอปในโมดูล `main` ของ Python จัดการคำขอทุกรายการที่ส่งไปยัง URL ซึ่งมีเส้นทางตรงกับนิพจน์ทั่วไป `/.*` (URL ทั้งหมด)

ไวยากรณ์ของไฟล์นี้คือ [YAML](http://www.yaml.org) สำหรับรายการตัวเลือกการกำหนดค่าทั้งหมด โปรดดูข้อมูลอ้างอิง [`app.yaml`][app-yaml-reference]

## การทดสอบแอปของคุณ

### ทดสอบแอปบน Cloud Shell

Cloud Shell ให้คุณทดสอบแอปก่อนการทำให้ใช้งานได้ เพื่อตรวจสอบว่าแอปทำงานตามวัตถุประสงค์ เช่นเดียวกับการแก้ไขข้อบกพร่องในเครื่องของคุณ

ในการทดสอบแอปของคุณ ให้ป้อน

```bash
dev_appserver.py $PWD
```

### ดูตัวอย่างแอปด้วย "แสดงตัวอย่างเว็บ"

แอปของคุณกำลังทำงานใน Cloud Shell คุณจะเข้าถึงแอปได้โดยใช้[แสดงตัวอย่างเว็บ][spotlight-web-preview]
<walkthrough-web-preview-icon></walkthrough-web-preview-icon> ในการเชื่อมต่อกับพอร์ต 8080

### การยุติการแสดงตัวอย่างอินสแตนซ์

ยุติอินสแตนซ์ของแอปพลิเคชันโดยการกด `Ctrl+C` ใน Cloud
Shell

## การทำให้ใช้งานได้กับ Google App Engine

### สร้างแอปพลิเคชัน

ในการทำให้แอปใช้งานได้ คุณจำเป็นต้องสร้างแอปในภูมิภาค

```bash
gcloud app create
```

หมายเหตุ: หากสร้างแอปไว้แล้ว คุณอาจข้ามขั้นตอนนี้ได้

### การทำให้ใช้งานได้ด้วย Cloud Shell

คุณใช้ Cloud Shell ในการทำให้แอปใช้งานได้ ในการทำให้แอปใช้งานได้ ให้ป้อน

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### ไปที่แอป

ยินดีด้วย! แอปของคุณใช้งานได้แล้ว URL เริ่มต้นของแอป คือ [{{project-gae-url}}](http://{{project-gae-url}}) คลิกที่ URL เพื่อเข้าชม

### ดูสถานะของแอป

คุณสามารถเช็คอินบนแอปของคุณได้โดยการตรวจสอบสถานะบนแดชบอร์ดของ App Engine

เปิด[เมนู][spotlight-console-menu]ทางด้านซ้ายของคอนโซล

จากนั้นเลือกส่วน **API Engine**

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## บทสรุป

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

คุณทำให้แอปพลิเคชัน App Engine ใช้งานได้เรียบร้อยแล้ว

ขั้นตอนถัดไปบางส่วนมีดังนี้

**ดาวน์โหลด Google Cloud SDK และพัฒนาในเครื่อง**

ติดตั้ง [Google Cloud SDK][cloud-sdk-installer] ในเครื่องภายใน

**สร้างแอปพลิเคชันถัดไป**

เรียนรู้วิธีใช้ App Engine กับผลิตภัณฑ์อื่นๆ ของ Google Cloud Platform:

<walkthrough-tutorial-card label="Django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **เรียกใช้ Django**
  พัฒนาแอป Django ที่ทำงานบน App Engine
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="พื้นที่เก็บข้อมูล" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **เรียนรู้วิธีใช้ Cloud Datastore**
  Cloud Datastore เป็นฐานข้อมูล NoSQL ที่รองรับการปรับขนาดสำหรับแอปพลิเคชัน
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
