# ข้อมูลเบื้องต้นเกี่ยวกับ Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## บทนำ

Cloud Pub/Sub คือบริการรับส่งข้อความแบบเรียลไทม์ที่มีการจัดการเต็มรูปแบบ ซึ่งช่วยให้คุณรับส่งข้อความระหว่างแอปพลิเคชันต่างๆ ที่เป็นอิสระได้ บทแนะนำนี้จะให้ข้อมูลเบื้องต้นเกี่ยวกับอินเทอร์เฟซบรรทัดคำสั่งของ Cloud Pub/Sub โดยใช้คำสั่ง `gcloud`

## การตั้งค่าโปรเจ็กต์

Google Cloud Platform จะจัดทรัพยากรลงในโปรเจ็กต์ต่างๆ ซึ่งช่วยให้คุณรวบรวมทรัพยากรที่เกี่ยวข้องทั้งหมดของแอปพลิเคชันหนึ่งไว้ในที่เดียวได้

Cloud Pub/Sub ต้องการโปรเจ็กต์เพื่อจัดเตรียมข้อความ

<walkthrough-project-setup></walkthrough-project-setup>

## สร้างหัวข้อแรก

### เปิด Google Cloud Shell

Cloud Shell เป็นเครื่องมือบรรทัดคำสั่งในตัวสำหรับคอนโซล คุณจะใช้ Cloud Shell ในการจัดเตรียม Cloud Pub/Sub

เปิด Cloud Shell ด้วยการคลิก
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[ไอคอน][spotlight-open-devshell]ในแถบนำทางที่ด้านบนของคอนโซล

### สร้างหัวข้อ

หัวข้อคือทรัพยากรที่มีการตั้งชื่อที่คุณจะส่งข้อความไปถึง สร้างหัวข้อแรกของคุณด้วยคำสั่งต่อไปนี้

```bash
gcloud pubsub topics create my-topic
```

## เพิ่มการสมัครรับข้อมูล

คุณจำเป็นต้องสร้างการสมัครรับข้อมูลเพื่อรับข้อความ การสมัครรับข้อมูลจะต้องมีหัวข้อที่สอดคล้องอยู่ สร้างการสมัครรับข้อมูลแรกของคุณด้วยคำสั่งต่อไปนี้

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

คำสั่งนี้จะสร้างการสมัครรับข้อมูลที่ชื่อว่า `my-sub` ซึ่งเชื่อมโยงอยู่กับหัวข้อ
`my-topic` ระบบจะส่งข้อความทั้งหมดที่เผยแพร่ต่อ `my-topic` ไปยังการสมัครรับข้อมูลนี้

คุณอาจสังเกตเห็นตัวเลือก `--ack-deadline=60` ซึ่ง `ack-deadline` ย่อมาจาก
`กำหนดเวลาในการยอมรับ` การสมัครรับข้อมูลใหม่นี้มี`กำหนดเวลาในการยอมรับ` 60 วินาที เราจะอธิบายเพิ่มเติมเกี่ยวกับประเด็นนี้ในภายหลัง

## สร้างรายการหัวข้อและการสมัครรับข้อมูล

ก่อนที่จะส่งข้อความแรก ให้ตรวจสอบว่าได้สร้างหัวข้อและการสมัครรับข้อมูลเสร็จสมบูรณ์แล้วหรือไม่ แสดงรายการหัวข้อและการสมัครรับข้อมูลของคุณโดยใช้คำสั่งต่อไปนี้

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## เผยแพร่ข้อความไปยังหัวข้อ

ส่งข้อความ 2 รายการด้วยคำสั่งต่อไปนี้

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

คำสั่งเหล่านี้จะส่งข้อความคำสั่งละหนึ่งข้อความ ข้อความแรกคือ `hello` และข้อความที่สองคือ `goodbye` เมื่อเผยแพร่ข้อความสำเร็จแล้ว คุณจะเห็น messageId ที่ส่งกลับมาจากเซิร์ฟเวอร์ ซึ่งเป็นรหัสเฉพาะที่เซิร์ฟเวอร์กำหนดให้กับแต่ละข้อความ

## ดึงข้อความจากการสมัครรับข้อมูล

### ดึงข้อความ

ในตอนนี้ ให้ดึงข้อความด้วยคำสั่งต่อไปนี้:

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

คุณอาจเห็นทั้งสองข้อความที่คุณเพิ่งเผยแพร่ไป ข้อความจะมีข้อมูล, `hello` และ `goodbye` รวมถึง `MESSAGE_ID` ซึ่ง `MESSAGE_ID` เป็นรหัสเฉพาะของข้อความที่เซิร์ฟเวอร์กำหนดให้

หมายเหตุ: Cloud Pub/Sub จะไม่รับประกันลำดับของข้อความ นอกจากนี้ยังเป็นไปได้ที่คุณจะเห็นเพียงข้อความเดียว ในกรณีดังกล่าว ให้ลองเรียกใช้คำสั่งเดิมหลายๆ ครั้งจนกว่าคุณจะเห็นข้อความอื่น

### การยอมรับและกำหนดเวลาในการยอมรับ

เมื่อดึงและประมวลผลข้อความอย่างถูกต้อง คุณต้องแจ้ง Cloud Pub/Sub ว่าคุณได้รับข้อความสำเร็จแล้ว การดำเนินการนี้เรียกว่าการ**ยอมรับ**

คุณอาจสังเกตเห็นว่ามีการติดธง `--auto-ack` ส่งมาพร้อมกับคำสั่ง `pull` ด้วย
การติดธง `--auto-ack` จะดึงและยอมรับข้อความนั้นโดยอัตโนมัติ

## การยอมรับด้วยตนเอง

### ส่งข้อความใหม่

ส่งข้อความใหม่ด้วยคำสั่งต่อไปนี้

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### ดึงข้อความอีกครั้ง

ดึงข้อความด้วยคำสั่งต่อไปนี้

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

คำสั่งนี้จะแสดงข้อความ `thanks` รวมถึง `MESSAGE_ID` และ `ACK_ID`
ซึ่ง `ACK_ID` เป็นอีกรหัสหนึ่งที่คุณใช้ในการยอมรับข้อความได้

### ยอมรับข้อความ

หลังจากที่คุณดึงข้อความ คุณต้องยอมรับข้อความนั้นก่อนที่**กำหนดเวลาในการยอมรับ**จะผ่านไป ตัวอย่างเช่น หากมีการกำหนดค่าการสมัครรับข้อมูลไว้ให้มี**กำหนดเวลาในการยอมรับ** 60 วินาที ดังที่เราทำในบทแนะนำนี้ คุณต้องยอมรับข้อความภายใน 60 วินาทีหลังจากดึงข้อความ มิเช่นนั้น Cloud Pub/Sub จะส่งข้อความนั้นอีกครั้ง

ยอมรับข้อความด้วยคำสั่งต่อไปนี้ (แทนที่ `ACK_ID` ด้วยรหัสจริงด้วยการคัดลอก/วาง)

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## ดูหัวข้อและการสมัครรับข้อมูลใน UI ของ Pub/Sub

ส่วนนี้จะสรุปบทแนะนำเกี่ยวกับบรรทัดคำสั่ง `gcloud` แต่เราจะมาดูกันที่ UI บน Google Cloud Console ก่อนที่จะสิ้นสุดบทแนะนำ

นอกจากนี้ คุณอาจเห็นหัวข้อและการสมัครรับข้อมูลในส่วน Pub/Sub ด้วย

### ไปที่ส่วน Pub/Sub

เปิด[เมนู][spotlight-console-menu]ทางด้านซ้ายของคอนโซล

จากนั้น เลือกส่วน **Pub/Sub**

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

UI ยังให้คุณสร้างและจัดการหัวข้อและการสมัครรับข้อมูลได้

### ลบหัวข้อ

เลือกช่องทำเครื่องหมายถัดจากหัวข้อที่คุณสร้างขึ้น และคลิก[ปุ่มลบ][spotlight-delete-button]เพื่อลบหัวข้อโดยถาวร

## บทสรุป

ยินดีด้วย!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

คุณได้ทราบถึงแนวคิดเบื้องต้นของ Cloud Pub/Sub โดยใช้เครื่องมือบรรทัดคำสั่ง `gcloud` และคุณได้รู้จักกับ UI ของ Cloud Pub/Sub ไปบ้างแล้ว ขั้นตอนต่อไปคือการสร้างแอปพลิเคชันสุดเจ๋ง โปรดดู[เอกสารประกอบเกี่ยวกับ Pub/Sub][pubsub-docs]สำหรับข้อมูลเพิ่มเติม

สิ่งที่คุณทำต่อไปได้มีดังนี้

[ดูรหัสตัวอย่าง](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
