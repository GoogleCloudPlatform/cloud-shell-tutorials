# ข้อมูลเบื้องต้นเกี่ยวกับ Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## บทนำ

Google Cloud Internet of Things (IoT) Core เป็นบริการที่ได้รับการจัดการเต็มรูปแบบสำหรับการเชื่อมต่อและจัดการอุปกรณ์ IoT เริ่มตั้งแต่ 2-3 เครื่องไปจนถึงนับล้านเครื่อง บทแนะนำนี้จะแสดงวิธีใช้เครื่องมือบรรทัดคำสั่ง `gcloud` ในการสร้างรีจิสทรีของอุปกรณ์ Cloud IoT Core และเพิ่มอุปกรณ์ พร้อมทั้งแสดงวิธีเรียกใช้ตัวอย่าง MQTT ในการเชื่อมต่ออุปกรณ์และเผยแพร่เหตุการณ์การส่งข้อมูลทางไกลของอุปกรณ์

บทแนะนำนี้จะแนะนำคุณตลอดทุกขั้นตอน ไม่ว่าจะเป็น

  *  การสร้างหัวข้อ Cloud Pub/Sub
  *  การสร้างรีจีสทรีของอุปกรณ์
  *  การเพิ่มอุปกรณ์ในรีจิสทรี
  *  การตั้งค่าข้อมูลรับรองบนอุปกรณ์
  *  สร้างการสมัครสมาชิกหัวข้อ Pub/Sub เพื่อส่งและรับข้อความ
  *  การเชื่อมต่ออุปกรณ์เสมือนและการดูข้อมูลการส่งข้อมูลทางไกล

## การตั้งค่าโปรเจ็กต์

Google Cloud Platform จะจัดทรัพยากรลงในโปรเจ็กต์ต่างๆ ซึ่งช่วยให้คุณรวบรวมทรัพยากรที่เกี่ยวข้องทั้งหมดของแอปพลิเคชันหนึ่งไว้ในที่เดียวได้

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## การใช้ Google Cloud Shell

ในบทแนะนำนี้ คุณจะได้ทำงานทั้งหมดใน Cloud Shell

### เปิด Google Cloud Shell

เปิด Cloud Shell โดยการคลิก
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[ไอคอน][spotlight-open-devshell]ในแถบนำทางที่ด้านบนของคอนโซล

### เปิด Google Cloud APIs

การดำเนินการนี้จะเปิดใช้ Cloud IoT Core API

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## สร้างหัวข้อแรก

หัวข้อเป็นทรัพยากรที่มีชื่อที่อุปกรณ์จะส่งข้อความถึง สร้างหัวข้อแรกของคุณด้วยคำสั่งต่อไปนี้

```bash
gcloud pubsub topics create my-topic
```

คุณจะส่งข้อความจำนวนมากไปที่หัวข้อนี้ในภายหลัง

## โคลนไฟล์ Cloud IoT Core Node.js ตัวอย่างจาก GitHub

คุณจะใช้ MQTT ตัวอย่างเพื่อส่งข้อความไปยัง Cloud IoT Core

หมายเหตุ: หากมีไดเรกทอรีอยู่แล้ว ให้นำไฟล์ก่อนหน้าออกก่อนการโคลน

```bash
rm -rf nodejs-docs-samples
```

โคลนโปรแกรมตัวอย่างด้วยคำสั่งต่อไปนี้

```bash
git clone {{repo-url}}
```

## ให้สิทธิ์กับบัญชีบริการ Cloud IoT Core

ใช้สคริปต์ตัวช่วยในโฟลเดอร์ `/iot/scripts` เพิ่มบัญชีบริการ `cloud-iot@system.gserviceaccount.com` ให้กับหัวข้อ Cloud Pub/Sub พร้อมบทบาทผู้เผยแพร่

### ไปที่ไดเรกทอรี IoT

```bash
cd nodejs-docs-samples/iot
```

### ติดตั้งการอ้างอิง

```bash
npm --prefix ./scripts install
```

### เรียกใช้สคริปต์ตัวช่วย

```bash
node scripts/iam.js my-topic
```

สคริปต์จะให้สิทธิ์แก่บัญชีบริการ Cloud IoT Core ในหัวข้อ `my-topic`

## สร้างรีจิสทรีของอุปกรณ์

รีจิสทรีของอุปกรณ์ประกอบด้วยอุปกรณ์ต่างๆ และกำหนดคุณสมบัติที่อุปกรณ์ที่มีอยู่ทั้งหมดใช้ร่วมกัน สร้างรีจิสทรีของอุปกรณ์ด้วยคำสั่งดังต่อไปนี้

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## การสร้างคีย์การลงชื่อ

หากต้องการตรวจสอบสิทธิ์ Cloud IoT Core อุปกรณ์จะต้องมีคีย์ส่วนตัวและคีย์สาธารณะ สร้างคีย์การลงชื่อโดยการเรียกใช้คำสั่งต่อไปนี้

```bash
./scripts/generate_keys.sh
```

สคริปต์นี้จะสร้างคีย์ RS256 และ ES256 ในรูปแบบ PEM แต่คุณจะต้องใช้คีย์ RS256 เท่านั้นสำหรับบทแนะนำนี้ี คีย์ส่วนตัวต้องมีการจัดเก็บไว้อย่างปลอดภัยในอุปกรณ์ และใช้เพื่อลงชื่อ JWT การตรวจสอบสิทธิ์ ([JSON Web Token][web-token-docs]) ระบบจะจัดเก็บคีย์สาธารณะไว้ในรีจิสทรีของอุปกรณ์

## สร้างอุปกรณ์และเพิ่มในรีจิสทรี

เรียกใช้คำสั่งต่อไปนี้เพื่อสร้างอุปกรณ์และเพิ่มในรีจิสทรี

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## เชื่อมต่ออุปกรณ์และดูข้อมูลการส่งข้อมูลทางไกล

ในขั้นตอนนี้ คุณจะส่งข้อความจากอุปกรณ์เสมือนไปยัง Pub/Sub จากนั้นจึงดึงข้อความเหล่านั้นเพื่อดู

### ไปที่ไดเรกทอรี MQTT ตัวอย่าง

```bash
cd mqtt_example
```

### ติดตั้งการอ้างอิง Node.js

```bash
npm install
```

### เรียกใช้คำสั่งต่อไปนี้เพื่อเชื่อมต่ออุปกรณ์เสมือนกับ Cloud IoT Core โดยใช้ MQTT ฺBridge

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{project-id}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

เอาต์พุตจะแสดงให้เห็นว่าอุปกรณ์เสมือนกำลังเผยแพร่ข้อความไปยังหัวข้อการส่งข้อมูลทางไกล โดยมีการเผยแพร่ข้อความแล้ว 25 ข้อความ

## สร้างการสมัครรับข้อมูลกับหัวข้อของอุปกรณ์

เรียกใช้คำสั่งต่อไปนี้เพื่อสร้างการสมัครรับข้อมูล ซึ่งช่วยให้คุณดูข้อความที่อุปกรณ์ของคุณเผยแพร่ได้

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## ดึงข้อความที่เผยแพร่แล้ว

ดึงข้อความที่อุปกรณ์เผยแพร่แล้วโดยใช้คำสั่งต่อไปนี้

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

การเรียกใช้คำสั่งนี้จะส่งคืนข้อความที่อุปกรณ์ของคุณเผยแพร่ ข้อความจะมีข้อมูลต่อไปนี้ `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, `MESSAGE_ID` และรายการข้อมูล `ATTRIBUTES` เกี่ยวกับอุปกรณ์ ซึ่ง `MESSAGE_ID` เป็นรหัสที่ไม่ซ้ำกันที่เซิร์ฟเวอร์กำหนด

หมายเหตุ: Cloud Pub/Sub จะไม่รับประกันลำดับของข้อความ นอกจากนี้ยังอาจเป็นไปได้ที่คุณจะเห็นเพียงข้อความเดียวใน Cloud Shell ในกรณีดังกล่าว ให้ลองเรียกใช้คำสั่งเดียวกันหลายๆ ครั้งจนกว่าคุณจะเห็นข้อความอื่น

## ดูทรัพยากรในคอนโซล Google Cloud Platform

ส่วนนี้จะสรุปบทแนะนำเกี่ยวกับบรรทัดคำสั่ง `gcloud` แต่คุณจะยังใช้คอนโซล GCP เพื่อดูทรัพยากรที่คุณเพิ่งสร้างขึ้นได้

เปิด[เมนู][spotlight-console-menu]ทางด้านซ้ายของคอนโซล

จากนั้นเลือก **IoT Core**

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

UI ยังให้คุณสร้างและจัดการกับรีจิสทรีของอุปกรณ์และอุปกรณ์ต่างๆ ได้

## บทสรุป

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

ยินดีด้วย! คุณได้ทราบแนวคิดเบื้องต้นของ Cloud IoT Core โดยใช้เครื่องมือบรรทัดคำสั่ง `gcloud` รวมถึงได้ใช้ GCP Console เพื่อดูทรัพยากร Cloud IoT Core แล้ว ขั้นตอนต่อไปคือการสร้างแอปพลิเคชันสุดเจ๋ง ดู[เอกสารเพิ่มเติมเกี่ยวกับ IoT Core](https://cloud.google.com/iot/docs/) เพื่อดูข้อมูลเพิ่มเติม

### สิ่งที่คุณทำต่อไปได้มีดังนี้

ดู Cloud IoT Core ตัวอย่างอื่นๆ ใน GitHub

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
