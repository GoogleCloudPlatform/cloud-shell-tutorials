# เริ่มต้นอย่างรวดเร็วโดยใช้ TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## บทนำ

คุณอาจใช้ [Tensor Processing Unit][tpu-docs] (TPU) เพื่อเร่งการทำงานเฉพาะของปริมาณงานของแมชชีนเลิร์นนิงสำหรับ [TensorFlow][tensor-flow] ได้ บทแนะนำนี้จะอธิบายถึงวิธีสร้างและใช้ Cloud TPU เพื่อให้โมเดล TensorFlow พื้นฐานเริ่มทำงาน

## ตั้งค่าโปรเจ็กต์

Google Cloud Platform จะจัดทรัพยากรลงในโปรเจ็กต์ต่างๆ ซึ่งช่วยให้คุณรวบรวมทรัพยากรที่เกี่ยวข้องทั้งหมดของแอปพลิเคชันหนึ่งไว้ในที่เดียวได้

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## กำหนดค่า Cloud SDK

### เปิด Cloud Shell

Cloud Shell เป็นเครื่องมือบรรทัดคำสั่งในตัวสำหรับคอนโซลซึ่งใช้ในการเชื่อมต่อกับ TPU ได้

เปิด Cloud Shell โดยคลิกที่<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [ไอคอน][spotlight-open-devshell]ในแถบการนำทางที่ด้านบนของคอนโซล

### ระบุโซน

ใช้คำสั่งต่อไปนี้ในการระบุโซนที่คุณวางแผนไว้ว่าจะสร้างทรัพยากร TPU

```bash
gcloud config set compute/zone us-central1-c
```

สำหรับตัวอย่างนี้ ลองใช้โซน `us-central1-c`

หากต้องการดูโซนที่ใช้ได้ ลองไปที่เว็บไซต์เอกสาร Cloud TPU

[ภูมิภาคและโซนของ Cloud TPU][tpu-regions]

## สร้างทรัพยากร

การเริ่มต้นอย่างรวดเร็วนี้จำเป็นต้องมีอินสแตนซ์เครื่องเสมือน Compute Engine โดยอิมเมจประกอบไปด้วยเครื่องมือบรรทัดคำสั่ง `gcloud beta` รวมถึง TensorFlow รุ่นแคนดิเดตที่จำเป็นสำหรับการเรียกใช้ TensorFlow บนทรัพยากร Cloud TPU

### สร้าง Compute Engine VM

ใช้เครื่องมือบรรทัดคำสั่ง `gcloud` ในการสร้างอินสแตนซ์ VM

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### เปิดใช้ API ของ TPU

ลองเปิดใช้งาน API ของ TPU หากยังไม่ได้เปิดใช้อยู่ก่อนแล้ว

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### สร้างทรัพยากร TPU

ใช้คำสั่ง `gcloud beta compute tpus create` ในการสร้างทรัพยากร Cloud TPU ใหม่ สำหรับตัวอย่างนี้ ให้ตั้งค่าแฟล็ก `--range` เป็น `10.240.1.0/29`

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## เรียกใช้ตัวอย่าง TensorFlow

เชื่อมต่อกับอินสแตนซ์แล้วสร้างโปรแกรม TensorFlow พร้อมการเรียกใช้โพรซีเยอร์ระยะไกล (RPC) ที่ชี้ไปหาปลายทางเครือข่ายของ TPU

### เชื่อมต่อกับอินสแตนซ์

ป้อนคำสั่งต่อไปนี้ให้กับ SSH ใน VM หากใช้ SSH จาก Cloud Shell เป็นครั้งแรก คุณต้องสร้างคีย์ส่วนตัว

```bash
gcloud compute ssh tpu-demo-vm
```

### ตั้งชื่อ TPU

บนอินสแตนซ์ ลองตั้งค่าตัวแปรสภาพแวดล้อมด้วยชื่อที่คุณเลือกให้กับ TPU สำหรับตัวอย่างนี้ ลองใช้ "demo-tpu"

```bash
export TPU_NAME="demo-tpu"
```

### สร้างแอปพลิเคชัน

สร้างแอปพลิเคชัน Python ที่ชี้ไปยังปลายทาง Cloud TPU แล้วเรียกใช้การคำนวณแบบเรียบง่าย

```bash
nano cloud-tpu.py
```

คัดลอกและวางเนื้อหาของไฟล์เหล่านี้

```python
import os
import tensorflow as tf
from tensorflow.contrib import tpu
from tensorflow.contrib.cluster_resolver import TPUClusterResolver

def axy_computation(a, x, y):
  return a * x + y

inputs = [
    3.0,
    tf.ones([3, 3], tf.float32),
    tf.ones([3, 3], tf.float32),
]

tpu_computation = tpu.rewrite(axy_computation, inputs)

tpu_grpc_url = TPUClusterResolver(
    tpu=[os.environ['TPU_NAME']]).get_master()

with tf.Session(tpu_grpc_url) as sess:
  sess.run(tpu.initialize_system())
  sess.run(tf.global_variables_initializer())
  output = sess.run(tpu_computation)
  print(output)
  sess.run(tpu.shutdown_system())

print('Done!')
```

### เรียกใช้แอปพลิเคชัน

เรียกใช้โปรแกรม TensorFlow

```bash
python cloud-tpu.py
```

สร้างและเรียกใช้โปรแกรม TensorFlow เพิ่มเติมที่ใช้อุปกรณ์ TPU ได้ตามต้องการ

เมื่อทดลองเรียบร้อยแล้ว ให้ออกจากอินสแตนซ์

```bash
exit
```

## ลบทรัพยากร

เพื่อเลี่ยงไม่ให้เกิดการเรียกเก็บเงินกับบัญชี Google Cloud Platform สำหรับทรัพยากรที่ใช้ในการเริ่มต้นอย่างรวดเร็วนี้ ควรทำดังนี้

### ลบทรัพยากร TPU และอินสแตนซ์ VM

ใช้เครื่องมือบรรทัดคำสั่ง gcloud เพื่อลบทรัพยากร Cloud TPU

```bash
gcloud beta compute tpus delete demo-tpu
```

ใช้เครื่องมือบรรทัดคำสั่ง `gcloud` เพื่อลบอินสแตนซ์ Compute Engine

```bash
gcloud compute instances delete tpu-demo-vm
```

### ลบเครือข่าย VPC

ไปที่หัวข้อเครือข่าย VPC ในคอนโซล Google Cloud Platform

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

ไปที่หัวข้อ [การเพียร์เครือข่าย VPC][spotlight-network-peering] และเลือกเครือข่าย VPC ที่ Google สร้างขึ้นโดยอัตโนมัติซึ่งเป็นส่วนหนึ่งของการตั้งค่า Cloud TPU รหัสของรายการการเพียร์จะขึ้นต้นด้วย `cp-to-tp-peering`

ที่ด้านบนของหน้า ให้คลิก**ลบ**

### ลบเส้นทาง VPC

ไปที่หัวข้อ[เส้นทาง][spotlight-routes-list]และเลือกเส้นทางที่ Google สร้างโดยอัตโนมัติซึ่งเป็นส่วนหนึ่งของการตั้งค่า Cloud TPU รหัสของรายการการเพียร์จะขึ้นต้นด้วย `peering-route`

ที่ด้านบนของหน้า ให้คลิก**ลบ**

## บทสรุป

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

ยินดีด้วย!

คุณได้สร้างแอปพลิเคชันที่ใช้ Cloud TPU แล้ว

หากต้องการดูข้อมูลเพิ่มเติม ลองไปที่เว็บไซต์เอกสาร Cloud TPU

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
