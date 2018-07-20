# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Introdução

Neste tutorial, você verá como usar um aplicativo básico da Vision API por meio
de uma solicitação `LABEL_DETECTION`. Esta solicitação `LABEL_DETECTION` anota
uma imagem com um marcador ("tag") que é selecionado de acordo com o conteúdo da
imagem. Por exemplo, a imagem de um celeiro pode ter os marcadores "celeiro",
"fazenda" ou outra anotação parecida.

Veja as etapas que serão abordadas no tutorial:

*   **Execução do app de detecção de marcadores**: você aprenderá como executar
    seu aplicativo usando o Google Cloud Shell diretamente no seu navegador.
*   **Finalmente…** Seu app estará pronto, e você poderá testá-lo ou removê-lo e
    começar novamente.

["Python" e os logotipos do Python são marcas registradas da Python Software
Foundation.](walkthrough://footnote)

# Configuração do projeto

Você precisará ativar a Cloud Vision API usando um projeto.

O Google Cloud Platform organiza recursos em projetos. Com isso, você pode
coletar todos os recursos relacionados para um único aplicativo em um só lugar.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Ativar a Vision API

A Vision API precisa estar ativada no seu projeto para que as solicitações sejam
aceitas.

### Navegar para o Gerenciador de API

O Gerenciador de API define quais APIs estão ativadas no seu projeto.

Abra o [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) no
canto esquerdo do console.

Depois, selecione a seção **APIs e serviços**.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Ver APIs disponíveis

Para ativar as APIs, clique no botão
[Ativar API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button).

### Selecionar Vision API

Clique no link da [Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).

### Ativar Vision API

Para ativar a Vision API, clique no botão [Ativar](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com). Ainda
neste tutorial, você criará credenciais para seu projeto.

## Como usar o Google Cloud Shell

O Cloud Shell é uma ferramenta de linha de comando integrada para o console que
você usará para executar seu app.

### Abrir o Google Cloud Shell

Para abrir o Cloud Shell, clique no
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[ícone](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
na barra de navegação que fica na parte superior do console.

### Clonar o código de amostra

Use o Cloud Shell para clonar e acessar o código "Hello World". O código de
amostra é clonado do seu repositório de projeto para o Cloud Shell.

Observação: se o diretório já existir, remova os arquivos dentro dele antes de
clonar o código de amostra:

```bash
rm -rf {{repo-name}}
```

Clone um repositório de amostra:

```bash
git clone {{repo-url}}
```

Em seguida, mude para o diretório do tutorial:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Como configurar sua implantação

Você está agora no diretório principal do código de amostra. Analise os arquivos
que configuram seu aplicativo.

### Como explorar o aplicativo

Insira o seguinte comando para ver o código do seu aplicativo:

```bash
cat quickstart.py
```

O arquivo `quickstart.py` formata as informações da sua solicitação, como o tipo
de solicitação e o conteúdo. Expanda cada seção abaixo para ver mais detalhes.

As solicitações para a Vision API são fornecidas como objetos JSON. Para ver
informações completas sobre a estrutura específica da solicitação, consulte a
[Referência da Vision API][vision-request-doc]. A solicitação JSON será enviada
somente quando você chamar `execute`. Com esse padrão, é possível transferir
essas solicitações e chamar `execute` conforme necessário.

## Como testar o aplicativo

É necessário configurar credenciais antes de usar a API. Para usar uma Cloud
API, configure as [credenciais][auth-doc] adequadas para seu aplicativo. Com
isso, seu aplicativo poderá autenticar a própria identidade no serviço e receber
autorização para executar tarefas. Em seguida, você testará a API com imagens de
amostra.

### Criar uma conta de serviço

É necessário criar uma conta de serviço para autenticar suas solicitações de
API. Se você já tiver essa conta de serviço, ela será reutilizada.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Criar credenciais

Em seguida, crie uma chave de conta de serviço e defina-a como suas credenciais
padrão.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Testar o aplicativo

Para testar seu app com a imagem de amostra, digite:

```bash
python quickstart.py
```

O recurso de imagem, `resources/wakeupcat.jpg`, é especificado na origem. [Ver
imagem][cat-picture]

## Conclusão

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Parabéns! Agora você já pode usar a Cloud Vision API.

Veja a seguir o que você pode fazer:

*   realizar o tutorial [Detecção facial][face-tutorial]
*   realizar o tutorial [Texto de documentos][document-text-tutorial]
*   ver os [aplicativos de amostra][vision-samples]
*   fazer o download do [Google Cloud SDK][get-cloud-sdk] e executá-lo na sua
    máquina local

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
