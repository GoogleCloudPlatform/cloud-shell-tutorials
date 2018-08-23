# Guia de início rápido do App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Introduçăo

Neste tutorial, vocę aprenderá a implantar um aplicativo de amostra [Java][java]
ao Google App Engine usando o Maven App Engine Plugin.

Para isso, siga as etapas a seguir:

*   **Crie e execute seu app "Hello, world!"**

    Vocę aprenderá a executar seu app usando o Google Cloud Shell diretamente no
    seu navegador. Depois, vocę implantará seu app na Web usando o Maven App
    Engine Plugin.

*   **Depois da implantaçăo...**

    Após a implantaçăo, seu app já estará funcionando. Vocę poderá testá-lo ou
    removę-lo para começar novamente.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Configuraçăo do projeto

Para implantar um aplicativo, primeiro vocę precisa criar um projeto.

No Google Cloud Platform, os recursos săo organizados em projetos. Isso ajuda
vocę a manter todos os recursos relacionados a um único aplicativo em um só
lugar.

<walkthrough-project-setup/>

## Como usar o Google Cloud Shell

O Cloud Shell é uma ferramenta de linha de comando integrada ao console.
Usaremos o Cloud Shell para implantar nosso app.

### Abrir o Google Cloud Shell

Abra o Cloud Shell clicando no ícone <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) na
barra de navegaçăo na parte superior do console.

### Clonar o código de amostra

Use o Cloud Shell para clonar e navegar para o código do "Hello World". O código
de amostra será clonado a partir do repositório do seu projeto no Cloud Shell.

Observaçăo: se o diretório já existir, remova os arquivos anteriores antes da
clonagem:

```bash
rm -rf {{repo-name}}
```

No Cloud Shell, digite o seguinte:

```bash
git clone {{repo-url}}
```

Entăo, alterne para o diretório do tutorial:

```bash
cd {{repo-name}}
```

## Como configurar sua implantaçăo

Agora vocę está no diretório principal do código de amostra. Veremos a seguir os
arquivos que configuram seu aplicativo.

### Como explorar o aplicativo

Insira o seguinte comando para ver o código do seu aplicativo:

```bash
cat src/main/java/myapp/DemoServlet.java
```

Este servlet responde a qualquer solicitaçăo enviando uma mensagem `Hello,
world!`.

### Como explorar sua configuraçăo

No Java, o Google App Engine usa arquivos XML para especificar a configuraçăo da
implantaçăo.

Insira o seguinte comando para ver seu arquivo de configuraçăo:

```bash
cat pom.xml
```

O app `helloworld` usa Maven. Isso significa que vocę precisa especificar um
modelo de objeto de projeto (POM, na sigla em inglęs), que pode conter
informaçőes sobre o projeto e detalhes da configuraçăo usada pelo Maven para
criar o projeto.

## Como testar seu app

### Testar seu app no Cloud Shell

O Cloud Shell permite que vocę teste seu app antes da implantaçăo para confirmar
se ele está funcionando corretamente, como uma depuraçăo na sua máquina local.

Para testar seu app, digite o seguinte:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Ver seu app com a "Visualizaçăo da Web"

Agora seu app está em execuçăo no Cloud Shell. Vocę pode acessá-lo usando a
Visualizaçăo da Web <walkthrough-web-preview-icon/> para se conectar ŕ porta
8080. [Veja
como](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Como encerrar a instância de visualizaçăo

Encerre a instância do aplicativo pressionando `Ctrl+C` no Cloud Shell.

## Como implantar no Google App Engine

### Criar um aplicativo

Para implantar nosso app, é preciso criar um aplicativo em uma regiăo:

```bash
gcloud app create
```

Observaçăo: se vocę já criou um app, pule esta etapa.

### Como implantar com o Cloud Shell

Agora vocę pode usar o Cloud Shell para implantar seu app.

Primeiro defina qual projeto será usado:

```bash
gcloud config set project {{project-id}}
```

Depois, implante seu app:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Acessar seu app

Seu app foi implantado! O URL padrăo dele é
[{{project-gae-url}}](http://{{project-gae-url}}) Clique no link para acessar
seu aplicativo.

### Ver o status do seu app

Para monitorar seu app, basta verificar o status dele no painel do App Engine.

Abra o [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) no
canto esquerdo do console.

Depois, clique na seçăo **App Engine**.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Conclusăo

<walkthrough-conclusion-trophy/>

Parabéns! Vocę criou o aplicativo do App Engine com sucesso! Veja as próximas
etapas:

**Fazer o download do Google Cloud SDK e desenvolver na máquina local**

[Google Cloud SDK][cloud-sdk-installer]

**Criar seu próximo aplicativo**

Saiba como usar o App Engine com outros produtos do Google Cloud Platform:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Aprenda a usar o Cloud Datastore**
O Cloud Datastore é um banco de dados NoSQL altamente escalável para seus apps.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Aprenda a usar o Cloud Storage**
O Cloud Storage é um serviço simples e poderoso de armazenamento de objetos.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
