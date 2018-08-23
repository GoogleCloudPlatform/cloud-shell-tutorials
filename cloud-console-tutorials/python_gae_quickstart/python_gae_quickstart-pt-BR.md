# Guia de início rápido do App Engine

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Introdução

Neste tutorial, você aprenderá a implantar um aplicativo de amostra em [Python](https://python.org/) no Google App Engine usando o comando `gcloud`.

Veja abaixo as etapas que você deverá seguir.

  *  **Crie um projeto**

     Nos projetos, o código, as VMs e outros recursos são agrupados para facilitar o desenvolvimento e o monitoramento.

  *  **Crie e execute seu aplicativo "Hello, world!"**

     Você aprenderá a executar seu aplicativo usando o Google Cloud Shell direto do seu navegador. Na etapa final, você implantará seu aplicativo na Web usando o comando `gcloud`.

  *  **Após o tutorial...**

     Seu aplicativo estará pronto. Você poderá fazer testes com ele depois da implantação ou excluí-lo e começar de novo.

["Python" e os logotipos do Python são marcas registradas da Python Software Foundation.](walkthrough://footnote)

## Configuração do projeto

Para implantar um aplicativo, primeiro você precisa criar um projeto.

O Google Cloud Platform organiza recursos em projetos. Com isso, você pode coletar todos os recursos relacionados a um único aplicativo em um só lugar.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Como usar o Google Cloud Shell

O Cloud Shell é uma ferramenta de linha de comando integrada ao console. Usaremos o Cloud Shell para implantar o aplicativo.

### Abrir o Google Cloud Shell

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Clique no ícone][spotlight-open-devshell] na barra de navegação na parte superior do console para abrir o Cloud Shell.

### Clonar o código de amostra

Use o Cloud Shell para clonar e acessar o código "Hello World". O código de amostra é clonado do seu repositório de projeto para o Cloud Shell.

Observação: se o diretório já existir, remova os arquivos dentro dele antes de clonar o código de amostra.
No Cloud Shell, digite:

```bash
git clone {{repo-url}}
```

Em seguida, mude para o diretório do tutorial:

```bash
cd {{repo-dir}}
```

## Como configurar sua implantação

Você está agora no diretório principal do código de amostra. Analise os arquivos que configuram seu aplicativo.

### Como explorar o aplicativo

Digite o seguinte comando para ver o código do seu aplicativo:

```bash
cat main.py
```

Ele é um aplicativo simples em Python que usa a biblioteca da Web [webapp2](https://webapp2.readthedocs.io/). Este script em Python responde à solicitação com um cabeçalho HTTP e a mensagem `Hello, World!`.

### Como explorar sua configuração

O Google App Engine usa arquivos YAML para especificar a configuração de uma implantação.
Os arquivos `app.yaml` contém informações sobre seu aplicativo, como o ambiente de execução, gerenciadores de URL e muito mais.

Digite o seguinte comando para ver seu arquivo de configuração:

```bash
cat app.yaml
```

De cima para baixo, estas são as informações do aplicativo que estão no arquivo de configuração:

  *  Este código é executado no ambiente de execução `python`.
  *  Este aplicativo é classificado como `threadsafe`. Portanto, a mesma instância pode processar várias solicitações simultâneas. "Threadsafe" é um recurso avançado e pode ocasionar um comportamento instável se o seu aplicativo não for especificamente projetado para ser seguro para threads.
  *  Toda solicitação a um URL que tenha um caminho correspondente à expressão regular `/.*` (todos os URLs) precisa ser processada pelo objeto do aplicativo no módulo `main` do Python.

A sintaxe desse arquivo é [YAML](http://www.yaml.org). Para ver uma lista completa das opções de configuração, consulte a referência do [`app.yaml`][app-yaml-reference].

## Como testar seu aplicativo

### Testar seu aplicativo no Cloud Shell

O Cloud Shell permite testar seu aplicativo antes da implantação para garantir que ele funcione como esperado, assim como acontece no processo de depuração na sua máquina local.

Para testar seu aplicativo, digite:

```bash
dev_appserver.py $PWD
```

### Visualizar seu aplicativo com a "Visualização da Web"

Agora seu aplicativo está sendo executado no Cloud Shell. Use a [visualização da Web][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon> para se conectar à porta 8080 e acessar o aplicativo.

### Como encerrar a instância de visualização

Pressione `Ctrl+C` no Cloud Shell para encerrar a instância do aplicativo.

## Como implantar no Google App Engine

### Criar um aplicativo

Para implantar seu aplicativo, você precisa criar um aplicativo em uma região:

```bash
gcloud app create
```

Observação: se você já fez isso, pule esta etapa.

### Como implantar com o Cloud Shell

É possível usar o Cloud Shell para implantar seu aplicativo. Para fazer isso, insira o seguinte comando:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Acessar seu aplicativo

Parabéns! Seu aplicativo foi implantado. O URL padrão dele é [{{project-gae-url}}](http://{{project-gae-url}}). Clique no URL para acessá-lo.

### Ver o status do seu aplicativo

Para monitorar o status do seu aplicativo, acesse o painel do App Engine.

[Abra o menu][spotlight-console-menu] no lado esquerdo do console.

Em seguida, selecione a seção **App Engine**.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Conclusão

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Você implantou um aplicativo no App Engine.

Veja a seguir quais são as próximas etapas:

**Fazer o download do Google Cloud SDK e desenvolver localmente**

Instale o [Google Cloud SDK][cloud-sdk-installer] na sua máquina local.

**Criar seu próximo aplicativo**

Saiba como usar o App Engine com outros produtos do Google Cloud Platform:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Executar o Django**
  Desenvolva aplicativos Django executados no App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Aprender a usar o Cloud Datastore**
  O Cloud Datastore é um banco de dados NoSQL altamente escalonável para seus aplicativos.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
