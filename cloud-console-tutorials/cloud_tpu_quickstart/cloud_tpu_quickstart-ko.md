# TPU로 빠르게 시작하기

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## 소개

TPU([텐서 처리 장치][tpu-docs])를 사용하여 특정 [텐서플로우][tensor-flow] 머신러닝 작업 부하를 가속화할 수 있습니다. 이 가이드에서는 Cloud TPU를 만들어 기본 텐서플로우 모델을 실행하는 데 사용하는 방법을 설명합니다.

## 프로젝트 설정

Google Cloud Platform은 리소스를 프로젝트별로 정리하므로 애플리케이션 1개와 관련된 모든 리소스를 한곳에 모을 수 있습니다.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Cloud SDK 구성

### Cloud Shell 열기

Cloud Shell은 TPU에 연결하는 데 사용할 수 있는 콘솔용으로 내장된 명령줄 도구입니다.

콘솔 상단 탐색 메뉴에서
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[아이콘][spotlight-open-devshell]을 클릭하여 Cloud Shell을 엽니다.

### 영역 지정

다음 명령어를 사용하여 TPU 리소스를 만들 영역을 지정합니다.

```bash
gcloud config set compute/zone us-central1-c
```

이 예에서는 `us-central1-c` 영역을 사용합니다.

사용 가능한 영역을 보려면 Cloud TPU 문서 사이트를 방문하세요.

[Cloud TPU 지역 및 영역][tpu-regions]

## 리소스 만들기

이 퀵스타트에는 Compute Engine 가상 머신 인스턴스가 필요합니다. 이미지에 Cloud TPU 리소스에서 텐서플로우를 실행하는 데 필요한 텐서플로우 출시 후보와 `gcloud beta` 명령줄 도구가 포함되어 있습니다.

### Compute Engine VM 만들기

`gcloud` 명령줄 도구를 사용하여 VM 인스턴스를 만듭니다.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### TPU API 사용 설정

TPU API를 아직 활성화하지 않았다면 활성화합니다.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### TPU 리소스 만들기

`gcloud beta compute tpus create` 명령어를 사용하여 새 Cloud TPU 리소스를 만듭니다. 이 예에서는 `--range` 플래그를 `10.240.1.0/29`로 설정합니다.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## 텐서플로우 예 실행

인스턴스에 연결하고 TPU의 네트워크 엔드포인트를 가리키는 원격 절차 호출(RPC)로 텐서플로우 프로그램을 만듭니다.

### 내 인스턴스에 연결

다음 명령어를 입력하여 VM에 SSH를 설정합니다. Cloud Shell에서 SSH를 사용하는 것이 처음이라면 비공개 키를 만들어야 합니다.

```bash
gcloud compute ssh tpu-demo-vm
```

### TPU 이름 지정

인스턴스에서 TPU에 사용할 이름으로 환경 변수를 설정하세요. 이 예에서는 'demo-tpu'를 사용합니다.

```bash
export TPU_NAME="demo-tpu"
```

### 애플리케이션 만들기

Cloud TPU 엔드포인트를 가리키는 Python 애플리케이션을 만들고 간단한 계산을 실행합니다.

```bash
nano cloud-tpu.py
```

다음 파일 콘텐츠를 복사하고 붙여넣습니다.

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

### 애플리케이션 실행

텐서플로우 프로그램을 실행합니다.

```bash
python cloud-tpu.py
```

TPU 기기를 사용하는 추가 텐서플로우 프로그램을 자유롭게 만들고 실행합니다.

실험을 마치면 인스턴스를 종료합니다.

```bash
exit
```

## 리소스 삭제

이 퀵스타트에서 사용한 리소스 비용이 Google Cloud Platform 계정에 청구되지 않도록 하는 방법은 다음과 같습니다.

### TPU 리소스 및 VM 인스턴스 삭제

gcloud 명령줄 도구를 사용하여 Cloud TPU 리소스를 삭제합니다.

```bash
gcloud beta compute tpus delete demo-tpu
```

`gcloud` 명령줄 도구를 사용하여 Compute Engine 인스턴스를 삭제합니다.

```bash
gcloud compute instances delete tpu-demo-vm
```

### VPC 네트워크 삭제

Google Cloud Platform 콘솔의 VPC 네트워크 섹션으로 이동합니다.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

[VPC 네트워크 피어링][spotlight-network-peering] 섹션으로 이동하고 Cloud TPU 설정의 일부로 Google에서 자동으로 만든 VPC 네트워크를 선택합니다. 피어링 항목의 ID는 `cp-to-tp-peering`으로 시작됩니다.

페이지 상단에서 **삭제**를 클릭합니다.

### VPC 경로 삭제

[경로][spotlight-routes-list] 섹션으로 이동한 후 Cloud TPU 설정의 일부로 Google에서 자동으로 만든 경로를 선택합니다. 피어링 항목의 ID는 `peering-route`로 시작됩니다.

페이지 상단에서 **삭제**를 클릭합니다.

## 마무리

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

축하합니다.

Cloud TPU를 사용하는 애플리케이션을 만들었습니다.

자세히 알아보려면 Cloud TPU 문서 사이트를 방문하세요.

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
