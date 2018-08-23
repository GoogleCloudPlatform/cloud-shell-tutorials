# Guia de início rápido com uma TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Introdução

Você pode usar uma [unidade de processamento de tensor][tpu-docs] (TPU, na sigla em inglês) para acelerar cargas de trabalho de aprendizado de máquina específicas do [TensorFlow][tensor-flow]. Neste tutorial, você aprenderá a criar uma Cloud TPU e usá-la para executar um modelo básico do TensorFlow.

## Configuração do projeto

O Google Cloud Platform organiza recursos em projetos. Com isso, você pode coletar todos os recursos relacionados a um único aplicativo em um só lugar.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Configurar o Cloud SDK

### Abrir o Cloud Shell

O Cloud Shell é uma ferramenta de linha de comando integrada ao console que você pode usar para se conectar à sua TPU.

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Clique no ícone][spotlight-open-devshell] na barra de navegação na parte superior do console para abrir o Cloud Shell.

### Especificar uma zona

Use o comando a seguir para especificar a zona em que você planeja criar seu recurso de TPU:

```bash
gcloud config set compute/zone us-central1-c
```

Para este exemplo, use a zona `us-central1-c`.

Para ver as zonas disponíveis, acesse o site da documentação do Cloud TPU:

[Regiões e zonas do Cloud TPU][tpu-regions]

## Criar recursos

Este guia de início rápido requer uma instância de máquina virtual do Compute Engine. A imagem inclui a ferramenta de linha de comando `gcloud beta`, assim como a versão RC do TensorFlow necessária para executar os recursos do TensorFlow na Cloud TPU.

### Crie uma VM do Compute Engine

Use a ferramenta de linha de comando `gcloud` para criar uma instância de VM.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Ativar a TPU API

Ative a TPU API se você ainda não tiver feito isso.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Criar um recurso de TPU

Use o comando `gcloud beta compute tpus create` para criar um novo recurso do Cloud TPU. Para este exemplo, defina a sinalização `--range` como `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Executar um exemplo de TensorFlow

Conecte-se à sua instância e crie um programa do TensorFlow com uma chamada de procedimento remoto (RPC) que aponte para o ponto de extremidade da rede da sua TPU.

### Conectar-se à instância

Digite o seguinte comando para usar SSH na VM. Se esta é a primeira vez que você usa o SSH no Cloud Shell, é necessário criar uma chave privada:

```bash
gcloud compute ssh tpu-demo-vm
```

### Nomear a TPU

Na instância, defina uma variável de ambiente com um nome que você escolher para a TPU. Para este exemplo, use "demo-tpu".

```bash
export TPU_NAME="demo-tpu"
```

### Criar o aplicativo

Crie um aplicativo Python que aponte para o ponto de extremidade da Cloud TPU e execute um processamento simples.

```bash
nano cloud-tpu.py
```

Copie e cole estes conteúdos de arquivos:

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

### Executar o aplicativo

Execute o programa do TensorFlow.

```bash
python cloud-tpu.py
```

Você pode criar e executar outros programas do TensorFlow que usam o dispositivo TPU livremente.

Quando terminar os testes, saia da instância.

```bash
exit
```

## Excluir recursos

Para evitar a cobrança na sua conta do Google Cloud Platform pelo uso de recursos neste guia de início rápido, siga estas instruções:

### Excluir o recurso de TPU e a instância de VM

Use a ferramenta de linha de comando gcloud para excluir o recurso de TPU do Cloud.

```bash
gcloud beta compute tpus delete demo-tpu
```

Use a ferramenta de linha de comando `gcloud` para excluir sua instância do Compute Engine.

```bash
gcloud compute instances delete tpu-demo-vm
```

### Excluir a rede VPC

Acesse a seção "Rede VPC" no Console do Google Cloud Platform.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Navegue até a seção de [peering da rede VPC][spotlight-network-peering] e selecione a rede VPC que o Google criou automaticamente como parte da configuração da Cloud TPU. A entrada do peering começa com `cp-to-tp-peering` no código.

Na parte superior da página, clique em **Excluir**.

### Excluir a rota da VPC

Navegue até a seção [Rotas][spotlight-routes-list] e selecione a rota que o Google criou automaticamente como parte da configuração da Cloud TPU. A entrada do peering começa com o `peering-route` no código.

Na parte superior da página, clique em **Excluir**.

## Conclusão

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Parabéns!

Você criou um aplicativo que usa o Cloud TPU.

Para saber mais, acesse o site da documentação do Cloud TPU:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
