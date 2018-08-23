# การเริ่มต้น Compute Engine อย่างรวดเร็ว

## สร้างแอป to-do ด้วย MongoDB

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

ในการเริ่มต้นอย่างรวดเร็วนี้ คุณจะต้องใช้ Compute Engine
ในการสร้างแอปพลิเคชันแบบ 2 ระดับ โดย VM ฟรอนท์เอนด์จะเรียกใช้เว็บแอป to-do ของ
Node.js และ VM แบ็กเอนด์จะเรียกใช้ MongoDB

บทแนะนำนี้จะแนะนำคุณตลอดทุกขั้นตอน ไม่ว่าจะเป็น

*   การสร้างและกำหนดค่า VM 2 รายการ
*   การตั้งค่ากฎไฟร์วอลล์
*   การใช้ SSH เพื่อติดตั้งแพ็กเกจบน VM

## ตั้งค่าโครงการ

Google Cloud Platform จะจัดทรัพยากรลงในโครงการต่างๆ
ซึ่งช่วยให้คุณรวบรวมทรัพยากรที่เกี่ยวข้องทั้งหมดของแอปพลิเคชันหนึ่งไว้ในที่เดียวได้

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## ไปยัง Compute Engine

เปิด[เมนู][spotlight-console-menu]ทางด้านซ้ายของคอนโซล

จากนั้น เลือกส่วน **Compute Engine**

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## สร้างอินสแตนซ์

คุณจะสร้างอินสแตนซ์ 2
รายการเพื่อใช้เป็นเซิร์ฟเวอร์แบ็กเอนด์และฟรอนท์เอนด์สำหรับแอปพลิเคชัน

### สร้างอินสแตนซ์แบ็กเอนด์

ก่อนอื่น สร้างอินสแตนซ์แบ็กเอนด์ที่เรียกใช้ MongoDB
เซิร์ฟเวอร์นี้จะจัดเก็บรายการสิ่งที่ต้องทำ

คลิกที่ปุ่ม[สร้างอินสแตนซ์][spotlight-create-instance]

*   เลือก[ชื่อ][spotlight-instance-name]และ[โซน][spotlight-instance-zone]สำหรับอินสแตนซ์นี้

*   เลือก [f1-micro][spotlight-machine-type] ซึ่งจะเรียกเก็บเงินจำนวนเล็กน้อย

    *   [ดูข้อมูลเพิ่มเติมเกี่ยวกับราคา][pricing]

*   เลือก [Ubuntu 14.04 LTS][spotlight-boot-disk]
    เป็นอิมเมจดิสก์เปิดเครื่องสำหรับบทแนะนำนี้

*   ใน[ตัวเลือก Firewall][spotlight-firewall] ให้เลือก**อนุญาตการรับส่งข้อมูล
    HTTP** ซึ่งจะเป็นการเปิดพอร์ต 80 (HTTP) เพื่อเข้าถึงแอป

*   คลิกปุ่ม[สร้าง][spotlight-submit-create]เพื่อสร้างอินสแตนซ์

หมายเหตุ: เมื่อสร้างอินสแตนซ์แล้ว
ระบบจะเริ่มเรียกเก็บเงินจากบัญชีสำหรับการเรียกเก็บเงินตามราคา GCE
โดยคุณจะนำอินสแตนซ์ออกได้ในภายหลังเพื่อหลีกเลี่ยงการเรียกเก็บเงินเพิ่มเติม

### สร้างอินสแตนซ์ฟรอนท์เอนด์

ขณะที่ VM แบ็กเอนด์กำลังดำเนินการ ให้สร้าง VM ฟรอนท์เอนด์ที่เรียกใช้แอปพลิเคชัน
to-do ของ Node.js โดยใช้การกำหนดค่าเดียวกับอินสแตนซ์แบ็กเอนด์

## ตั้งค่า

คุณจะต้องติดตั้งฐานข้อมูล MongoDB บนอินสแตนซ์แบ็กเอนด์เพื่อบันทึกข้อมูล

[ปุ่ม SSH][spotlight-ssh-buttons] ในตารางจะเปิดเซสชัน SSH
ไปยังอินสแตนซ์ในหน้าต่างแยก

สำหรับบทแนะนำนี้ คุณจะเชื่อมต่อโดยใช้ Cloud Shell
ซึ่งเป็นเครื่องมือบรรทัดคำสั่งในตัวสำหรับคอนโซล

### เปิด Cloud Shell

เปิด Cloud Shell โดยคลิกที่

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ไอคอน][spotlight-open-devshell]ในแถบนำทางที่ด้านบนของคอนโซล

### รอให้อินสแตนซ์สร้างเสร็จเรียบร้อย

ต้องรอให้อินสแตนซ์สร้างเสร็จก่อน บทแนะนำจึงจะเล่นต่อได้
คุณจะติดตามกิจกรรมได้โดยการคลิก[เมนูแจ้งเตือน][spotlight-notification-menu]จากแถบนำทางด้านบน

## เชื่อมต่อกับอินสแตนซ์แบ็กเอนด์

### เชื่อมต่อเข้ากับอินสแตนซ์

ป้อนคำสั่งต่อไปนี้ให้กับ SSH ใน VM หากใช้ SSH จาก Cloud Shell เป็นครั้งแรก
คุณจะต้องสร้างคีย์ส่วนตัว ให้คุณป้อนโซนและชื่อของอินสแตนซ์ที่คุณสร้างขึ้น

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### ติดตั้งฐานข้อมูลแบ็กเอนด์

ตอนนี้คุณมีการเชื่อมต่อ SSH กับอินสแตนซ์แบ็กเอนด์แล้ว
ลองใช้คำสั่งต่อไปนี้เพื่อติดตั้งฐานข้อมูลแบ็กเอนด์

อัปเดตแพ็กเกจและติดตั้ง MongoDB เมื่อระบบถามว่าคุณต้องการดำเนินการต่อไหม
ให้พิมพ์ `Y`

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### เรียกใช้ฐานข้อมูล

บริการ MongoDB เริ่มทำงานแล้วเมื่อมีการติดตั้ง
คุณต้องหยุดการทำงานเพื่อให้เปลี่ยนวิธีเรียกใช้งานได้

```bash
sudo service mongodb stop
```

สร้างไดเรกทอรีสำหรับ MongoDB จากนั้นเรียกใช้บริการ MongoDB
ให้ทำงานในพื้นหลังบนพอร์ต 80

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

หลังจากนั้น ให้ออกจากเซสชัน SSH โดยใช้คำสั่ง `exit`

```bash
exit
```

## เชื่อมต่อกับอินสแตนซ์ฟรอนท์เอนด์

### ติดตั้งและเรียกใช้เว็บแอปบน VM ฟรอนท์เอนด์

เซิร์ฟเวอร์แบ็กเอนด์กำลังทำงาน ถึงเวลาติดตั้งเว็บแอปพลิเคชันฟรอนท์เอนด์

### เชื่อมต่อเข้ากับอินสแตนซ์

ป้อนคำสั่งต่อไปนี้ให้กับ SSH ใน VM แล้วป้อนโซนและชื่อของอินสแตนซ์ที่คุณสร้างขึ้น

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### ติดตั้งการอ้างอิง

ตอนนี้คุณได้เชื่อมต่อกับอินสแตนซ์ฟรอนท์เอนด์แล้ว ลองอัปเดตแพ็กเกจและติดตั้ง git,
Node.js และ npm เมื่อระบบถามว่าคุณต้องการดำเนินการต่อไหม ให้พิมพ์ `Y`

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### ติดตั้งและเรียกใช้เว็บแอปฟรอนท์เอนด์

โคลนแอปพลิเคชันตัวอย่างและติดตั้งการอ้างอิงแอปพลิเคชัน

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

เริ่มต้นเว็บแอปพลิเคชัน to-do ด้วยคำสั่งต่อไปนี้
ซึ่งป้อน[ที่อยู่ IP ภายใน][spotlight-internal-ip]สำหรับอินสแตนซ์ที่คุณสร้าง

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

หลังจากนั้น ให้ออกจากเซสชัน SSH โดยใช้คำสั่ง `exit`

```bash
exit
```

### ไปที่แอปพลิเคชัน

ไปที่เว็บเซิร์ฟเวอร์ตามที่อยู่ IP ที่ระบุในคอลัมน์
[External IP][spotlight-external-ip] ถัดจากอินสแตนซ์ฟรอนท์เอนด์

## ล้างข้อมูล

หากต้องการลบอินสแตนซ์ ให้เลือก[ช่องทำเครื่องหมาย][spotlight-instance-checkbox]
ถัดจากชื่ออินสแตนซ์และคลิก [ปุ่มลบ][spotlight-delete-button]

## บทสรุป

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

เท่านี้ก็เรียบร้อย!

สิ่งที่คุณทำต่อไปได้มีดังนี้

*   ค้นหา[ตัวอย่าง Google Cloud Platform บน GitHub](http://googlecloudplatform.github.io/)

*   ดูวิธีตั้งค่า[การจัดสรรภาระงาน](https://cloud.google.com/compute/docs/load-balancing/)

*   ดูวิธี[โอนไฟล์ไปยังเครื่องเสมือน](https://cloud.google.com/compute/docs/instances/transfer-files/)

*   ดูวิธี[เรียกใช้คอนเทนเนอร์](https://cloud.google.com/compute/docs/containers)

[pricing]: https://cloud.google.com/compute/#compute-engine-pricing
[spotlight-boot-disk]: walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-control-panel]: walkthrough://spotlight-pointer?cssSelector=#p6n-action-bar-container-main
[spotlight-create-instance]: walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-external-ip]: walkthrough://spotlight-pointer?cssSelector=.p6n-external-link
[spotlight-firewall]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall
[spotlight-instance-checkbox]: walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-internal-ip]: walkthrough://spotlight-pointer?cssSelector=gce-internal-ip
[spotlight-machine-type]: walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select
[spotlight-notification-menu]: walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-ssh-buttons]: walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[spotlight-vm-list]: walkthrough://spotlight-pointer?cssSelector=vm2-instance-list%20.p6n-checkboxed-table
