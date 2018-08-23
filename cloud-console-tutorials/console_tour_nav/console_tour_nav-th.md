# ทัวร์ชม Cloud Console

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## บทนำ

บทแนะนำนี้ครอบคลุมฟีเจอร์หลักของ Cloud Console เพื่อให้คุณพร้อมที่จะสร้างและจัดการแอปพลิเคชันบน Google Cloud Platform

คุณจะได้ดูข้อมูลเกี่ยวกับแนวคิดต่อไปนี้

  *  โปรเจ็กต์และทรัพยากร GCP
  *  ภาพรวมของทรัพยากรระดับสูงและบันทึกกิจกรรม
  *  การนำทางคอนโซลและการค้นหา
  *  การจัดการผู้ใช้และสิทธิ์
  *  การสนับสนุนด้านเทคนิค
  *  บรรทัดคำสั่งแบบใช้เบราว์เซอร์ของ GCP

เรามาเริ่มกันเลย!

## ใช้ทรัพยากร GCP

ทรัพยากร GCP เป็นองค์ประกอบพื้นฐานที่สร้างเป็นบริการ Google Cloud ทั้งหมด ทรัพยากรมีการจัดลำดับชั้นและช่วยจัดระเบียบงานบน GCP

โปรเจ็กต์เป็นลำดับชั้นทรัพยากรระดับแรก และประกอบด้วยทรัพยากรระดับล่างอื่นๆ เช่น ที่เก็บข้อมูล Cloud Storage และอินสแตนซ์ Compute Engine

[ดูข้อมูลเพิ่มเติมเกี่ยวกับทรัพยากร GCP][gcp-resources]

### การนำทางโปรเจ็กต์

ไปยังโปรเจ็กต์ GCP ต่างๆ ได้อย่างง่ายดายโดยใช้[ตัวเลือกขอบเขต][spotlight-project-select]ใน Cloud Console การเปลี่ยนโปรเจ็กต์จะปรับการแสดงผลไปยังโปรเจ็กต์ดังกล่าวและทรัพยากรทั้งหมดที่อยู่ภายใต้โปรเจ็กต์นั้น

<walkthrough-project-setup></walkthrough-project-setup>

## ไปยังส่วนต่างๆ ของ Google Cloud Services

### การนำทางบริการ

เข้าถึงบริการ Google Cloud ได้ใน[เมนูนำทางด้านซ้ายมือ][spotlight-console-menu]ที่จัดระเบียบตามพื้นที่ผลิตภัณฑ์ ได้แก่ Big Data, Compute, Networking ฯลฯ

### การตรึงหัวข้อ

สำหรับบริการใดๆ ที่คุณใช้เป็นประจำ ให้ตรึงหัวข้อไว้ที่ด้านบนของเมนูการนำทางโดยการวางเมาส์บนรายการของหัวข้อแล้วคลิกที่ไอคอนตรึง

เปิดเมนูการนำทางแล้วเลือก**หน้าแรก**เพื่อดำเนินการต่อ

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## ดูภาพรวมระดับสูงของโปรเจ็กต์ต่างๆ

### แดชบอร์ดในหน้าแรก

แดชบอร์ดในหน้าแรกจะแสดงภาพรวมระดับสูงของโปรเจ็กต์ GCP ที่เลือก ไฮไลต์เมตริกหลัก การเรียกเก็บเงิน และข้อมูลที่เป็นประโยชน์อื่นๆ

### การปรับแต่ง

คุณปรับแต่งแดชบอร์ดได้โดยคลิก[ปรับแต่ง][spotlight-customize-dashboard]
คุณจะซ่อน แสดง หรือเปลี่ยนลำดับของการ์ดได้ในหน้านี้ โดยการ์ดแต่ละใบจะมีตัวเลือกที่กำหนดเองซึ่งเข้าถึงได้จากเมนูรายการเพิ่มเติมเมื่อวางเมาส์เหนือการ์ด

## ดูกิจกรรมในทรัพยากร GCP๋

โดยการใช้[สตรีมกิจกรรม][spotlight-activity-stream] คุณจะทำความเข้าใจกิจกรรมทั้งหมดที่เกิดขึ้นในทรัพยากร GCP ได้ในที่เดียว

ดูสิ่งที่เพื่อนร่วมทีมกำลังอัปเดตในโปรเจ็กต์เพื่อติดตามปัญหาและตรวจสอบการเข้าถึง กรองฟีดเพื่อค้นหาสิ่งที่คุณต้องการได้อย่างง่ายดาย

## ค้นหาใน Cloud Console

[แถบค้นหา][spotlight-search-bar]ใน Cloud Console ช่วยให้คุณเข้าถึงผลิตภัณฑ์ Google Cloud และทรัพยากรต่างๆ ใน GCP ได้อย่างรวดเร็ว

ลองเรียกใช้การค้นหาเพื่อหา **App Engine** หรือชื่อของโปรเจ็กต์

## รับการสนับสนุนได้ทุกเมื่อ

หากพบปัญหา หรือต้องการความช่วยเหลือในการสำรวจโลกแห่ง GCP ทีมสนับสนุนพร้อมที่จะช่วยเหลือคุณ

[ดูข้อมูลเพิ่มเติมเกี่ยวกับการสนับสนุน](http://cloud.google.com/support)

เข้าถึงบริการสนับสนุนจากเมนูการนำทาง

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## จัดการผู้ใช้และสิทธิ์

Google Cloud Identity และ Access Management (Cloud IAM) ช่วยให้คุณจัดการและสร้างสิทธิ์สำหรับทรัพยากร GCP ได้

[ดูข้อมูลเพิ่มเติมเกี่ยวกับ IAM](https://cloud.google.com/iam/docs/)

เมื่อทีมขยายขึ้น คุณให้สิทธิ์เข้าถึงกับเพื่อนร่วมทีมได้โดยใช้ Cloud IAM ในส่วน "IAM & Admin"

เพิ่มบัญชีผู้ใช้ กลุ่ม หรือบริการและกำหนดบทบาทต่างๆ เพื่อให้สิทธิ์ที่ทีมต้องการ

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## เข้าถึงบรรทัดคำสั่งจากเบราว์เซอร์

Google Cloud Shell มีบรรทัดคำสั่งเพื่อเข้าถึงทรัพยากรในระบบคลาวด์ได้จากเบราว์เซอร์โดยตรง คุณจะจัดการโปรเจ็กต์และทรัพยากรได้อย่างง่ายดายโดยไม่ต้องติดตั้ง Google Cloud SDK หรือเครื่องมืออื่นๆ ในระบบ

โดยการใช้ <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [Cloud Shell][spotlight-open-devshell] จะมีเครื่องมือบรรทัดคำสั่ง gcloud และยูทิลิตีอื่นๆ ล่าสุดและมีการตรวจสอบสิทธิ์แบบเต็มของ Cloud SDK พร้อมให้คุณใช้งานได้ตลอดเวลาเมื่อต้องการ

[ดูข้อมูลเพิ่มเติมเกี่ยวกับ Cloud Shell](https://cloud.google.com/shell/)

## สำรวจ GCP ต่อ

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

ตอนนี้คุณน่าจะรู้สึกดีกับการใช้ Cloud Console ที่มีรากฐานที่มั่นคงสำหรับการสำรวจบริการและผลิตภัณฑ์ใหม่แล้ว

[เอกสารโดยละเอียด](https://cloud.google.com/docs/)ยังมีข้อมูลมากมายตั้งแต่ภาพรวมผลิตภัณฑ์จนถึงคำแนะนำการเริ่มต้นอย่างรวดเร็วและการอ้างอิง API

กลับไปที่หน้าเริ่มต้นใช้งานเพื่อดูบทแนะนำเพิ่มเติม
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
