# Stackdriver Error Reporting

## บทนำ

Stackdriver Error Reporting จะรวบรวมและแสดงข้อผิดพลาดที่เกิดจากบริการระบบคลาวด์

บทแนะนำนี้จะแนะนำคุณเกี่ยวกับอินเทอร์เฟซทางเว็บของ Error Reporting คุณจะได้เรียนรู้วิธีแสดงรายการข้อผิดพลาดของแอปพลิเคชัน ดูรายละเอียดเพิ่มเติม และเริ่มดำเนินการ

## การตั้งค่าโครงการ

<walkthrough-project-setup></walkthrough-project-setup>

## สร้างข้อผิดพลาด

คุณต้องรายงานข้อผิดพลาดปลอมก่อนที่จะดำเนินการต่อ คุณจะใช้คำสั่ง `gcloud` ในการดำเนินการ

ในสถานการณ์จริง ระบบจะรายงานข้อผิดพลาดเหล่านี้โดยตรงจากแอปพลิเคชันที่ทำงานอยู่ หลังจบบทแนะนำนี้ คุณจะได้ดูข้อมูลเพิ่มเติมเกี่ยวกับวิธีตั้งค่า Error Reporting

### เปิด Google Cloud Shell

เปิด Cloud Shell โดยคลิกที่<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ไอคอน][spotlight-open-devshell]ในแถบการนำทางที่ด้านบนของคอนโซล

### รายงานข้อผิดพลาด 2-3 รายการ

คลิกปุ่ม**คัดลอกไปที่คลิปบอร์ด**ที่ด้านบนขวาของสคริปต์ต่อไปนี้และเรียกใช้ใน Cloud Shell เพื่อสร้างข้อผิดพลาดตัวอย่าง

```bash
COUNTER=0
while [  $COUNTER -lt 11 ]; do
    gcloud beta error-reporting events report --service tutorial --service-version v$((COUNTER/10+1)) \
        --message "java.lang.RuntimeException: Error rendering template $COUNTER
          at com.example.TestClass.test(TestClass.java:51)
          at com.example.AnotherClass(AnotherClass.java:25)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    if [ $COUNTER -lt 3 ]; then
      gcloud beta error-reporting events report --service tutorial --service-version v1 \
          --message "java.lang.ArrayIndexOutOfBoundsException: $COUNTER
            at com.example.AppController.createUser(AppController.java:42)
            at com.example.User(User.java:31)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    fi
    if [ $COUNTER -eq 10 ]; then
      echo "All artificial errors reported."
    fi
    let COUNTER=COUNTER+1
done
```

### ปิด Cloud Shell

ปิด Cloud Shell แล้วคลิก*ต่อไป*เมื่อดำเนินการเสร็จสิ้น

## แสดงรายการข้อผิดพลาดของแอปพลิเคชัน

คุณจะใช้ Stackdriver Error Reporting เพื่อดูภาพรวมของข้อผิดพลาดที่มีการรายงานได้อย่างรวดเร็ว

### เปิดการรายงานข้อผิดพลาด

เปิด[เมนู][spotlight-console-menu]ทางด้านซ้ายของคอนโซล

จากนั้น เลื่อนไปที่หมวดหมู่ **Stackdriver** แล้วเลือก **Error Reporting**

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### จัดเรียงตามที่*ปรากฏครั้งแรก*

ระบบจะจัดกลุ่มข้อผิดพลาดที่เกิดขึ้นในแอปพลิเคชันจะถูกจัดกลุ่มและนำรายการที่ซ้ำออกโดยการวิเคราะห์สแต็กเทรซ ข้อมูลในรายการนี้จะให้บทสรุปที่ช่วยให้คุณระบุได้ว่าเมื่อไหร่ที่แอปพลิเคชันจะเริ่มสร้างข้อผิดพลาด ความถี่ที่จะเกิดขึ้น และเกิดขึ้นได้อย่างไรเมื่อเร็วๆ นี้

การเรียงตามค่าเริ่มต้นคือ*รายการ* คลิกส่วนหัวของคอลัมน์*ปรากฏครั้งแรก*เพื่อดูข้อผิดพลาดที่เกิดขึ้นเมื่อเร็วๆ นี้

### เลือกรับการแจ้งเตือนข้อผิดพลาดใหม่

ระบบสามารถส่งข้อความ Push ทางอีเมลและอุปกรณ์เคลื่อนที่เมื่อเกิดข้อผิดพลาดใหม่ในโครงการได้ หากต้องการเลือกรับการแจ้งเตือนเหล่านี้ ให้คลิก*เปิดการแจ้งเตือน*

คลิก*ต่อไป*เมื่อดำเนินการเสร็จสิ้น

## ทำความเข้าใจรายละเอียดของข้อผิดพลาด

### เปิดรายงานข้อผิดพลาด

คลิกข้อผิดพลาดจากรายการนี้เพื่อดูรายละเอียด

### ลิงก์ปัญหากับข้อผิดพลาดนี้

ใช้หน้านี้ในการตรวจสอบข้อมูลและประวัติของข้อผิดพลาดที่เฉพาะเจาะจง

หลังจากดูข้อผิดพลาดใหม่แล้ว ขั้นตอนต่อไปคือการระบุปัญหาในตัวติดตามปัญหาของทีมของคุณ จากนั้นคุณจะลิงก์ปัญหานี้กับข้อผิดพลาดใน Stackdriver Error Reporting ได้

โดยดำเนินการดังนี้

  *  คลิก*ลิงก์ไปยังปัญหา*ด้านบน (คุณอาจต้องเปิดเมนู**การดำเนินการเพิ่มเติม**เพื่อดูลิงก์นี้)
  *  ป้อน `http://example.com/issues/1234` ในกล่องโต้ตอบ
  *  คลิก*บันทึก*

### สำรวจสแต็กเทรซ

เพื่อช่วยให้คุณมุ่งเน้นไปที่โค้ด เราจะซ่อนเฟรมสแต็กเทรซที่ไม่ได้มาจากโค้ดของแอปพลิเคชัน

คลิก*แสดงทั้งหมด*ในตัวอย่างข้อผิดพลาดเพื่อแสดงเฟรมสแต็กของเฟรมเวิร์ก

## บทสรุป

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

ยินดีด้วย! คุณดำเนินการตามบทแนะนำ Stackdriver Error Reporting เสร็จสิ้นแล้ว

สิ่งที่คุณทำต่อไปได้มีดังนี้

### ตั้งค่า Error Reporting สำหรับโครงการของคุณ

เรียนรู้วิธีตั้งค่า Error Reporting สำหรับบริการที่ทำงานอยู่ได้ใน[เอกสารประกอบการตั้งค่า][errors-setup]

### สำรวจบทแนะนำอื่นๆ ของ Stackdriver

แก้ไขข้อบกพร่องของแอปพลิเคชันเวอร์ชันที่ใช้งานจริงด้วยการเริ่มต้น [Stackdriver Debugger][debug-quickstart] อย่างรวดเร็ว

ทำความเข้าใจเวลาในการตอบสนองของแอปพลิเคชันด้วยการเริ่มต้น [Stackdriver
Trace][trace-quickstart] อย่างรวดเร็ว

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
