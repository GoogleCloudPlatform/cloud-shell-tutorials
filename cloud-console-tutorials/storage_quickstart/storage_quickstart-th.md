# การเริ่มต้น Cloud Storage อย่างรวดเร็ว

## ขอต้อนรับสู่ Google Cloud Storage!

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage เป็นโซลูชันการจัดเก็บข้อมูลที่มีประสิทธิภาพและประหยัดค่าใช้จ่ายสำหรับออบเจ็กต์ที่ไม่มีโครงสร้าง ซึ่งเหมาะกับทุกอย่างตั้งแต่การโฮสต์เนื้อหาเว็บแบบสดไปจนถึงการจัดเก็บข้อมูลสำหรับการวิเคราะห์ในที่เก็บถาวรและข้อมูลสำรอง

ในบทแนะนำนี้ เราจะแสดงให้คุณเห็นว่าการเริ่มจัดเก็บออบเจ็กต์ใน Cloud Storage นั้นทำได้ง่ายเพียงใด สิ่งที่คุณจะต้องทำมีดังนี้

  *  **สร้างที่เก็บข้อมูล**

     ที่เก็บข้อมูลจะเก็บออบเจ็กต์ (ไฟล์ทุกประเภท) ที่คุณต้องการจัดเก็บใน Cloud Storage

  *  **อัปโหลดและแชร์ออบเจ็กต์**

     เริ่มใช้ที่เก็บข้อมูลโดยการอัปโหลดออบเจ็กต์และทำให้พร้อมใช้งานแบบสาธารณะ

  *  **ล้างข้อมูล**

     ในขั้นตอนสุดท้าย คุณจะลบที่เก็บข้อมูลและออบเจ็กต์ที่คุณสร้างขึ้นสำหรับบทแนะนำนี้

ไม่ต้องกังวลว่าจะมีการเรียกเก็บเงินสำหรับการลองใช้บทแนะนำนี้ เนื่องจากคุณจะต้องลบที่เก็บข้อมูลและออบเจ็กต์ในขั้นตอนสุดท้าย

## การตั้งค่าโครงการ

Cloud Storage ต้องการโครงการเพื่อสร้างทรัพยากร

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## สร้างที่เก็บข้อมูล

ใน Cloud Storage คุณจะต้องจัดเก็บออบเจ็กต์ไว้ในที่เก็บข้อมูล ในการสร้างที่เก็บข้อมูล ให้ไปที่เบราว์เซอร์ Cloud Storage

เปิด[เมนู][spotlight-menu]ทางด้านซ้ายของคอนโซล

แล้วเลือกหัวข้อ**พื้นที่เก็บข้อมูล**

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## สร้างที่เก็บข้อมูล

ก่อนที่คุณจะเริ่มอัปโหลดออบเจ็กต์ได้ คุณต้องสร้าง "ที่เก็บข้อมูล" เพื่อเก็บวัตถุ ที่เก็บข้อมูลจะช่วยคุณจัดระเบียบและควบคุมการเข้าถึงออบเจ็กต์เหล่านั้น

  1. คลิก[สร้างที่เก็บข้อมูล](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,)

  1. ในหน้าการสร้างที่เก็บข้อมูล ให้ระบุพร็อพเพอร์ตี้ของที่เก็บข้อมูล สิ่งสำคัญที่คุณควรทราบมีดังนี้

     *  **ชื่อ:** นึกถึงชื่อที่ไม่ซ้ำกัน คุณจะพบข้อผิดพลาดหากป้อนชื่อที่เหมือนกับชื่อของที่เก็บข้อมูลอื่นใน Cloud Storage
     *  **คลาสพื้นที่เก็บข้อมูลเริ่มต้น:** นี่เป็นคลาสพื้นที่เก็บข้อมูลที่กำหนดให้กับออบเจ็กต์ของที่เก็บข้อมูลตามค่าเริ่มต้น ทางเลือกของคุณโดยหลักแล้วจะขึ้นอยู่กับความถี่ที่คุณคาดว่าจะมีการเข้าถึงออบเจ็กต์ และเป็นการแสดงข้อมูลทั่วโลกหรือไม่ คลาสพื้นที่เก็บข้อมูลจะมีผลต่อค่าใช้จ่าย
     *  **ตำแหน่งที่ตั้ง:** เราขอแนะนำให้คุณเก็บข้อมูลไว้ใกล้กับแอปพลิเคชันและผู้ใช้ที่เข้าถึง ทางเลือกที่มีจะขึ้นอยู่กับการเลือกคลาสพื้นที่เก็บข้อมูลของคุณ

สำหรับการลองใช้งานนี้ คุณจะใช้คลาสพื้นที่เก็บข้อมูลและตำแหน่งที่ตั้งใดก็ได้ เนื่องจากเราจะลบที่เก็บข้อมูลกันในตอนท้าย

  1. คลิก[สร้าง][spotlight-create-button]

## อัปโหลดออบเจ็กต์แ

เมื่อมีที่เก็บข้อมูลแล้ว คุณจะเริ่มอัปโหลดออบเจ็กต์ได้

  1. ที่ด้านบนของหน้าเว็บ ให้คลิก[อัปโหลดไฟล์][spotlight-upload-file]

  1. เลือกไฟล์เพื่ออัปโหลด คุณจะอัปโหลดไฟล์ได้ทุกประเภท

     ไม่มีไฟล์ใช่ไหม [สร้างไฟล์ตัวอย่าง][create-sample-file] จากนั้นคลิก[รีเฟรชที่เก็บข้อมูล][spotlight-refresh-bucket]ที่ด้านบนของหน้าเพื่อดูไฟล์ดังกล่าวในที่เก็บข้อมูล (เคล็ดลับ: คุณยังอัปโหลดออบเจ็กต์ได้ด้วยการลากและวางลงที่ด้านล่างของชื่อที่เก็บข้อมูล)

## ลบที่เก็บข้อมูล

ตอนนี้มาลบที่เก็บข้อมูลที่คุณเพิ่งสร้างกัน การลบที่เก็บข้อมูลจะเป็นการลบเนื้อหาข้างในด้วย

  1. ที่ด้านบนสุดของตาราง ให้คลิก[ที่เก็บข้อมูล][spotlight-buckets-link]เพื่อกลับไปยังรายการที่เก็บข้อมูล

  1. ทำเครื่องหมายช่องข้างที่เก็บข้อมูลของคุณ หากมีที่เก็บข้อมูลอื่นๆ ในโครงการนี้และคุณต้องการความช่วยเหลือในการค้นหาที่เก็บข้อมูล ให้ใช้แถบค้นหาเพื่อกรองรายการที่เก็บข้อมูล

  1. ที่ด้านบนสุดของหน้า ให้คลิก [ลบ][spotlight-delete-buckets]และยืนยันการลบ

## บทสรุป

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

ยินดีด้วย!

ทีนี้คุณก็ทราบวิธีเริ่มจัดเก็บวัตถุใน Cloud Storage แล้ว เราขอแนะนำให้คุณเรียนรู้เกี่ยวกับการนำไปใช้จริงโดย[การโฮสต์เว็บไซต์แบบคงที่](https://cloud.google.com/storage/docs/hosting-static-website)

หรือเรียนรู้การใช้ Cloud Storage กับ[เครื่องมือบรรทัดคำสั่ง gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil)

ดูวิธีเริ่มใช้ Cloud Storage และบริการ GCP อื่นๆ [ได้ฟรี](https://cloud.google.com/free)

[create-sample-file]: walkthrough://create-sample-storage-file
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-create-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,#p6n-cloudstorage-create-bucket
[spotlight-create-button]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button
[spotlight-delete-buckets]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket
[spotlight-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-public-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-label
[spotlight-refresh-bucket]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects
[spotlight-share-public]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-checkbox
[spotlight-upload-file]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file
