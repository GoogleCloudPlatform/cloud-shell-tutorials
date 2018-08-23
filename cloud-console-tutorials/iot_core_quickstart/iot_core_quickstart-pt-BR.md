# Introdução ao Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Introdução

O Google Cloud IoT Core é um serviço totalmente gerenciado para conectar e administrar de maneira segura dispositivos de Internet das Coisas (IoT, na sigla em inglês). Neste tutorial, você verá como usar a ferramenta de linha de comando do `gcloud` para adicionar um dispositivo e criar um registro de dispositivos do Cloud IoT Core. Além disso, você aprenderá a executar uma amostra MQTT para conectar um dispositivo e publicar eventos de telemetria.

Neste tutorial, orientaremos você sobre o seguinte:

  *  como criar um tópico do Cloud Pub/Sub
  *  como criar um registro de dispositivos
  *  como adicionar um dispositivo ao registro
  *  como configurar credenciais no dispositivo
  *  como criar uma inscrição no tópico Pub/Sub para enviar e receber mensagens
  *  como conectar um dispositivo virtual e visualizar dados de telemetria

## Configuração do projeto

O Google Cloud Platform organiza recursos em projetos. Com isso, você pode coletar todos os recursos relacionados para um único aplicativo em um só lugar.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Como usar o Google Cloud Shell

Neste tutorial, você fará todo o trabalho no Cloud Shell.

### Abrir o Google Cloud Shell

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Clique no ícone][spotlight-open-devshell] na barra de navegação na parte superior do Console para abrir o Cloud Shell.

### Ativar as APIs do Google Cloud

Isso ativará a Cloud IoT Core API.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Criar seu primeiro tópico

Um tópico é um recurso nomeado que recebe mensagens de dispositivos. Use o comando a seguir para criar seu primeiro tópico:

```bash
gcloud pubsub topics create my-topic
```

Enviaremos várias mensagens para esse tópico mais tarde.

## Clonar os arquivos de amostra Node.js do Cloud IoT Core a partir do GitHub

Você usará a amostra MQTT para enviar mensagens ao Cloud IoT Core.

Observação: se o diretório já existir, remova os arquivos dentro dele antes de clonar o código de amostra:

```bash
rm -rf nodejs-docs-samples
```

Clone o programa de amostra com o seguinte comando:

```bash
git clone {{repo-url}}
```

## Conceder permissão para a conta de serviço do Cloud IoT Core

Use o script de ajuda na pasta `/iot/scripts`, adicione a conta de serviço
`cloud-iot@system.gserviceaccount.com` ao tópico do Cloud Pub/Sub
com o papel de editor.

### Navegue até o diretório IoT:

```bash
cd nodejs-docs-samples/iot
```

### Instale as dependências:

```bash
npm --prefix ./scripts install
```

### Execute o script de ajuda:

```bash
node scripts/iam.js my-topic
```

O script concede permissão para a conta de serviço do Cloud IoT Core no tópico 
`my-topic`.

## Criar um registro de dispositivos

Um registro de dispositivo contém dispositivos e define propriedades compartilhadas entre todos eles. Use o comando a seguir para criar seu registro de dispositivo:

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## Gerar suas chaves de assinatura

Para autenticar um dispositivo no Cloud IoT Core, ele precisa de uma chave privada e uma chave pública. Gere suas chaves de assinatura executando o seguinte comando:

```bash
./scripts/generate_keys.sh
```

Esse script cria chaves RS256 e ES256 no formato PEM, mas você só precisará das chaves RS256 para este tutorial A chave privada precisa ser armazenada de maneira segura no dispositivo e será usada para assinar a autenticação JWT ([Token JSON da Web][web-token-docs]). A chave pública é armazenada no registro do dispositivo.

## Criar um dispositivo e adicioná-lo ao registro

Execute o seguinte comando para criar um dispositivo e adicioná-lo ao registro:

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Conectar seu dispositivo e ver dados de telemetria

Nesta etapa, você enviará mensagens de um dispositivo virtual para o Pub/Sub e, depois, efetuará o pull delas a fim de visualizá-las.

### Navegue até o diretório de amostra MQTT:

```bash
cd mqtt_example
```

### Instale as dependências do Node.js:

```bash
npm install
```

### Execute o seguinte comando para conectar um dispositivo virtual a um Cloud IoT Core usando a ponte MQTT:

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

A saída mostra que o dispositivo virtual está publicando mensagens no tópico de telemetria. Foram publicadas 25 mensagens.

## Criar uma inscrição no tópico do dispositivo

Execute o comando a seguir para criar uma inscrição, o que permite visualizar as mensagens publicadas pelo seu dispositivo:

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Efetuar pull das mensagens publicadas

Para efetuar o pull das mensagens publicadas pelo dispositivo, use o seguinte comando:

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

Se você executar este comando, as mensagens publicadas pelo dispositivo serão retornadas. As mensagens têm os seguintes dados os: `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, um `MESSAGE_ID` e uma lista `ATTRIBUTES` de informações sobre o dispositivos. O `MESSAGE_ID` é um código exclusivo atribuído pelo servidor.

Observação: o Cloud Pub/Sub não garante a ordem das mensagens. Também é possível que você veja apenas uma mensagem no Cloud Shell. Nesse caso, tente executar o mesmo comando várias vezes até que as outras mensagens sejam exibidas.

## Ver recursos no console do Google Cloud Platform

Com isso, você conclui o tutorial da linha de comando do `gcloud`, mas também pode usar o Console do GCP para visualizar os recursos que acabou de criar.

Abra o [menu][spotlight-console-menu] no lado esquerdo do Console.

Em seguida, selecione **IoT Core**.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

Na IU, você também pode adicionar dispositivos, além de criar e gerenciar registros de dispositivos.

## Conclusão

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Parabéns! Você concluiu o tutorial de conceitos básicos do Cloud IoT Core usando a ferramenta de linha de comando do `gcloud` e usou o console do GCP para visualizar os recursos do Cloud IoT Core. A próxima etapa é criar aplicativos incríveis. Para mais informações, consulte a [documentação do IoT Core](https://cloud.google.com/iot/docs/).

### Veja o que você pode fazer a seguir

Veja mais amostras do Cloud IoT Core no GitHub:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
