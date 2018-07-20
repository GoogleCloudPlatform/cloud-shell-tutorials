# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## บทนำ

บทแนะนำนี้จะแนะนำเกี่ยวกับแอปพลิเคชัน Vision API พื้นฐานโดยใช้คำขอ
`LABEL_DETECTION` ซึ่งคำขอ `LABEL_DETECTION` จะอธิบายรูปภาพด้วยป้ายกำกับ (หรือ
"แท็ก") ที่เลือกตามเนื้อหารูปภาพ เช่น ภาพโรงนาอาจสร้างป้ายกำกับ "โรงนา" "ฟาร์ม"
หรือคำอธิบายอื่นที่คล้ายคลึงกัน

ขั้นตอนต่างๆ ที่คุณจะใช้มีดังนี้

*   **เรียกใช้แอปตรวจจับป้ายกำกับ** คุณจะได้ดูวิธีเรียกใช้แอปโดยใช้ Google Cloud
    Shell จากในเบราว์เซอร์โดยตรง
*   **หลังจากที่แอปทำงาน...** แอปจะใช้ได้จริงและคุณจะทดสอบแอป
    หรือนำแอปออกและเริ่มต้นใหม่ได้

["Python" และโลโก้ Python เป็นเครื่องหมายการค้าหรือเครื่องหมายการค้าจดทะเบียนของ
Python Software Foundation](walkthrough://footnote)

# การตั้งค่าโครงการ

คุณจะต้องเปิดใช้ Cloud Vision API ผ่านโครงการ

Google Cloud Platform จะจัดทรัพยากรลงในโครงการต่างๆ
ซึ่งช่วยให้คุณรวบรวมทรัพยากรที่เกี่ยวข้องทั้งหมดของแอปพลิเคชันหนึ่งไว้ในที่เดียวได้

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## เปิดใช้ Vision API

โครงการต้องเปิดใช้ Vision API เพื่อยอมรับคำขอ

### ไปที่ตัวจัดการ API

ตัวจัดการ API จะตั้งค่าว่า API ใดที่จะเปิดใช้งานสำหรับโครงการ

เปิด ["เมนู](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)
ที่ด้านซ้ายของคอนโซล

จากนั้นเลือกหัวข้อ **API และบริการ**

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### ดู API ที่ใช้ได้

หากต้องการเปิดใช้ API ให้คลิกปุ่ม
[เปิดใช้ API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button)

### เลือก Vision API

คลิกลิงก์ [Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com)

### เปิดใช้ Vision API

หากต้องการเปิดใช้ Vision API ให้คลิกปุ่ม[เปิดใช้](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com)
คุณจะสร้างข้อมูลรับรองสำหรับโครงการต่อไปในบทแนะนำนี้

## การใช้ Google Cloud Shell

Cloud Shell เป็นเครื่องมือบรรทัดคำสั่งในตัวสำหรับคอนโซล คุณจะใช้ Cloud Shell
เพื่อเรียกใช้แอป

### เปิด Google Cloud Shell

เปิด Cloud Shell
โดยคลิกที่<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[ไอคอน](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
ในแถบนำทางด้านบนของคอนโซล

### โคลนโค้ดตัวอย่าง

ใช้ Cloud Shell เพื่อโคลนและไปที่โค้ด "Hello World"
ระบบจะจำลองโค้ดตัวอย่างจากที่เก็บโครงการและส่งไปยัง Cloud Shell

หมายเหตุ: หากมีไดเรกทอรีอยู่แล้ว ให้นำไฟล์ก่อนหน้าออกก่อนการโคลน

```bash
rm -rf {{repo-name}}
```

โคลนที่เก็บตัวอย่าง

```bash
git clone {{repo-url}}
```

จากนั้น ให้สลับไปที่ไดเรกทอรีบทแนะนำ

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## การกำหนดค่าการทำให้ใช้งานได้

ตอนนี้คุณอยู่ในไดเรกทอรีหลักของโค้ดตัวอย่างแล้ว
คุณจะดูไฟล์ที่กำหนดค่าแอปพลิเคชัน

### การสำรวจแอปพลิเคชัน

ป้อนคำสั่งต่อไปนี้เพื่อดูโค้ดของแอปพลิเคชัน

```bash
cat quickstart.py
```

ไฟล์ `quickstart.py` จะจัดรูปแบบข้อมูลคำขอ เช่น ประเภทคำขอและเนื้อหา
ขยายแต่ละหัวข้อด้านล่างเพื่อดูข้อมูลเกี่ยวกับรายละเอียด

ระบบจะส่งคำขอเป็นวัตถุ JSON ไปยัง Vision API ดู[ข้อมูลอ้างอิง Vision
API][vision-request-doc]
สำหรับข้อมูลทั้งหมดเกี่ยวกับโครงสร้างเฉพาะของคำขอดังกล่าว โดยระบบจะส่งคำขอ JSON
เมื่อเรียกใช้ `execute` เท่านั้น
รูปแบบนี้จะช่วยให้คุณส่งต่อคำขอดังกล่าวและเรียกใช้ `execute` เมื่อต้องการ

## การทดสอบแอปพลิเคชัน

คุณจำเป็นต้องตั้งค่าข้อมูลรับรองเพื่อใช้ API หากต้องการใช้ Cloud API
คุณจะต้องตั้งค่า[ข้อมูลรับรอง][auth-doc]ที่เหมาะสมสำหรับแอปพลิเคชัน
ซึ่งจะช่วยให้แอปพลิเคชันตรวจสอบสิทธิ์ข้อมูลประจำตัวของตนเองกับบริการได้
และรับสิทธิ์ในการดำเนินงานต่างๆ ได้ จากนั้นคุณจะทดสอบ API ด้วยรูปภาพตัวอย่าง

### สร้างบัญชีบริการ

คุณต้องสร้างบัญชีบริการเพื่อตรวจสอบสิทธิ์คำขอ API หากสร้างบัญชีบริการไว้อยู่แล้ว
ระบบจะนำบัญชีนั้นมาใช้ซ้ำ

```bash
gcloud iam service-accounts create vision-quickstart
```

### สร้างข้อมูลรับรอง

จากนั้นให้สร้างคีย์บัญชีบริการและตั้งค่าเป็นข้อมูลรับรองเริ่มต้น

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### ทดสอบแอป

ทดสอบแอปกับรูปภาพตัวอย่างได้โดยการป้อน

```bash
python quickstart.py
```

มีการระบุทรัพยากรรูปภาพ `resources/wakeupcat.jpg` ไว้ในแหล่งที่มา
([ดูรูปภาพ][cat-picture])

## บทสรุป

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

ขอแสดงความยินดี คุณพร้อมใช้งาน Cloud Vision API แล้ว

สิ่งที่คุณทำต่อไปได้มีดังนี้

*   ทำตามบทแนะนำ[การตรวจจับใบหน้า][face-tutorial]
*   ลองใช้บทแนะนำ[ข้อความในเอกสาร][document-text-tutorial]
*   ดู[แอปพลิเคชันตัวอย่าง][vision-samples]
*   ดาวน์โหลด [Google Cloud SDK][get-cloud-sdk] เพื่อเรียกใช้บนเครื่องภายใน

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
