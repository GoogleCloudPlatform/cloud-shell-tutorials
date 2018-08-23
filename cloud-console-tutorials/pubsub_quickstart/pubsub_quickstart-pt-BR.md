# Introdução ao Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Introdução

O Google Cloud Pub/Sub é um serviço de mensagens em tempo real totalmente gerenciado que permite o envio e recebimento de mensagens entre aplicativos independentes. Neste tutorial, você verá uma breve introdução à interface de linha de comando do Cloud Pub/Sub com o uso do comando `gcloud`.

## Configuração do projeto

O Google Cloud Platform organiza recursos em projetos. Com isso, você pode coletar todos os recursos relacionados a um único aplicativo em um só lugar.

O Cloud Pub/Sub precisa de um projeto para configurar mensagens.

<walkthrough-project-setup></walkthrough-project-setup>

## Criar seu primeiro tópico

### Abrir o Google Cloud Shell

O Cloud Shell é uma ferramenta de linha de comando integrada para o console que você usará para configurar o Cloud Pub/Sub.

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Clique no ícone][spotlight-open-devshell] na barra de navegação na parte superior do console para abrir o Cloud Shell.

### Criar um tópico

Um tópico é um recurso nomeado ao qual você enviará mensagens. Use o comando a seguir para criar seu primeiro tópico:

```bash
gcloud pubsub topics create my-topic
```

## Adicionar uma assinatura

Crie assinaturas para receber mensagens. Uma assinatura precisa ter um tópico correspondente. Use o código a seguir para criar sua primeira assinatura.

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

Esse comando cria uma assinatura chamada `my-sub` anexada ao tópico `my-topic`. Todas as mensagens publicadas no tópico `my-topic` serão entregues na assinatura criada.

Você poderá ver a opção `--ack-deadline=60`. `ack-deadline` representa `Acknowledgement deadline`. A assinatura tem um `Acknowledgement deadline` de 60 segundos. Explicaremos o que isso significa neste tutorial.

## Listar tópicos e assinaturas

Antes de enviar sua primeira mensagem, verifique se o tópico e a assinatura foram criados. Use o comando a seguir para listar seu tópico e sua assinatura:

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Como publicar mensagens no tópico

Enviar duas mensagens com os seguintes comandos:

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Cada um desses comandos envia uma mensagem. A primeira é `hello` e a segunda é `goodbye`. Após a publicação de uma mensagem, você deverá ver o messageID retornado do servidor. Ele é um código exclusivo atribuído a cada mensagem automaticamente pelo servidor.

## Receber mensagens da assinatura

### Receber mensagens

Use o comando a seguir para receber as mensagens:

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

Provavelmente, você viu as duas mensagens que acabou de publicar. As mensagens contêm os dados, `hello` e `goodbye`, além do `MESSAGE_ID`. O `MESSAGE_ID` é um código exclusivo da mensagem que o servidor atribuiu.

Observação: o Cloud Pub/Sub não garante a ordem das mensagens. Também é possível que você tenha visto apenas uma mensagem. Nesse caso, tente executar o mesmo comando várias vezes até que a outra mensagem seja exibida.

### Confirmação e prazo de confirmação

Após receber uma mensagem e processá-la corretamente, você precisará notificar o recebimento dela ao Cloud Pub/Sub. Esta ação é chamada de **confirmação**.

Talvez você tenha observado que a sinalização `--auto-ack` foi transferida junto com o comando `pull`.
A sinalização `--auto-ack` recebe a mensagem e a confirma automaticamente.

## Confirmação manual

### Enviar uma nova mensagem

Envie uma nova mensagem com o seguinte comando:

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### Receber as mensagens novamente

Use o comando a seguir para receber as mensagens:

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

Com isso, você deverá ver a mensagem `thanks`, além do `MESSAGE_ID` e do `ACK_ID`.
Você também pode usar o código `ACK_ID` para confirmar a mensagem.

### Confirmar a mensagem

Após receber a mensagem, você precisa confirmá-la antes que o **prazo de confirmação** se esgote. Por exemplo, se a assinatura for configurada com um **prazo de confirmado** de 60 segundos (como fizemos neste tutorial), será preciso confirmar a mensagem em até 60 segundos após o recebimento dela. Caso contrário, o Cloud Pub/Sub enviará a mensagem novamente.

Use o comando a seguir para confirmar a mensagem. Substitua `ACK_ID` pelo valor verdadeiro ao copiar e colar os dados:

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Ver o tópico e a inscrição na UI do Pub/Sub

Com isso, você conclui o tutorial sobre a linha de comando do `gcloud`, mas vamos analisar a IU do Google Cloud Console antes de terminar esta etapa.

Você também pode consultar a seção do Pub/Sub para ver os tópicos e as assinaturas.

### Consultar a seção do Pub/Sub

[Abra o menu][spotlight-console-menu] no lado esquerdo do console.

Em seguida, selecione a seção **Pub/Sub**.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

Com a IU, você também pode criar e gerenciar tópicos e assinaturas.

### Excluir o tópico

Marque a caixa de seleção ao lado do tópico que você criou e clique no [botão Excluir][spotlight-delete-button] para excluí-lo permanentemente.

## Conclusão

Parabéns!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Você concluiu o tutorial de conceitos básicos do Cloud
Pub/Sub usando a linha de comando do `gcloud` e agora tem uma visão melhor da IU do Cloud Pub/Sub. Na próxima etapa, você verá como criar aplicativos incríveis. Para mais informações, consulte a [documentação do Pub/Sub][pubsub-docs].

Veja a seguir o que você pode fazer:

[Ver exemplos de código](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
