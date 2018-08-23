# Tutorial do WordCount do Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Introdução

Neste tutorial, você aprenderá os conceitos básicos do serviço do Cloud Dataflow ao executar um canal de exemplo simples por meio do Java.

Os canais do Dataflow são classificados *em lote* (entrada limitada de processamento, como uma tabela de arquivos ou bancos de dados) ou *streaming* (entrada ilimitada de processamento, como uma origem do Cloud Pub/Sub, por exemplo). O exemplo que veremos neste tutorial é um canal em lote que conta palavras em uma coleção de obras de Shakespeare.

Antes de começar, você precisará verificar os pré-requisitos no seu projeto do Cloud Platform e fazer a configuração inicial.

## Configurar o projeto

O Google Cloud Platform organiza recursos em projetos. Com isso, você pode coletar todos os recursos relacionados para um único aplicativo em um só lugar.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Configurar o Cloud Dataflow

Para usar o Dataflow, ative as APIs do Cloud Dataflow e abra o Cloud Shell.

### Ativar as Google Cloud APIs

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Abrir o Cloud Shell

O Cloud Shell é uma ferramenta de linha de comando integrada para o console que você usará para executar seu app.

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Clique no ícone][spotlight-open-devshell] na barra de navegação na parte superior do console para abrir o Cloud Shell.

## Instalar amostras do Cloud Dataflow no Cloud Shell

Para usar o SDK do Cloud Dataflow para Java, os requisitos mínimos do ambiente de desenvolvimento são o Java, o Google Cloud SDK, o SDK do Cloud Dataflow para Java e o Apache Maven. Esses requisitos são necessários para o gerenciamento de dependências de SDK. Este tutorial usa um Cloud Shell com versões do Java, do Google Cloud SDK e do Maven já instaladas.

Se preferir, você pode seguir este tutorial [na sua máquina local][dataflow-java-tutorial].

### Fazer o download das amostras e do SDK do Cloud Dataflow para Java usando o comando Maven

Ao executar este comando, o Maven criará uma estrutura de projeto e um arquivo de configuração para fazer o download da versão correspondente do SDK do Cloud Dataflow.

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{directory}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

  *  `archetypeArtifactId` e `archetypeGroupId` são usados para definir a estrutura do projeto de exemplo.
  *  `groupId` é o prefixo do nome do pacote Java da sua organização (por exemplo, `com.mycompany`).
  *  `artifactId` define o nome do arquivo jar criado. Use o valor padrão (`{{directory}}`) para este tutorial.

Execute o comando Maven no Cloud Shell.

### Alterar o diretório

Mude seu diretório de trabalho para `{{directory}}`.

```bash
cd {{directory}}
```

Se você quiser ver o código deste exemplo, ele está disponível no subdiretório `src` localizado no diretório `{{directory}}`.

## Configurar um intervalo do Cloud Storage

O Cloud Dataflow usa os intervalos do Cloud Storage para armazenar dados de saída, além de fazer o armazenamento do código do canal em cache.

### Executar "gsutil mb"

No Cloud Shell, use o comando `gsutil mb` para criar um intervalo do Cloud Storage.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Para mais informações sobre a ferramenta `gsutil`, consulte a [documentação][gsutil-docs].

## Criar e iniciar um canal

No Cloud Dataflow, o processamento de dados é representado por um *canal*. Esse recurso lê os dados de entrada, transforma-os e gera dados de saída. As transformações de um canal podem incluir filtragem, agrupamento, comparação ou associação de dados.

Se você quiser ver o código deste exemplo, ele está disponível no subdiretório `src` localizado no diretório `{{directory}}`.

### Iniciar o canal no serviço do Dataflow

Use o comando `mvn exec` do Apache Maven para iniciar seu canal no serviço.
O canal em execução é chamado de *job.*

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation` é o intervalo de armazenamento que o Cloud Dataflow usará nos binários e outros dados para executar o canal. Esse local pode ser compartilhado entre vários jobs.
  *  `output` é o intervalo usado pelo exemplo do WordCount para armazenar os resultados do job.

### O job está em execução

Parabéns! Seu binário está sendo testado no intervalo de armazenamento que você criou anteriormente, e as instâncias do Compute Engine estão sendo criadas. O Cloud Dataflow dividirá o arquivo de entrada para que os dados possam ser processados por várias máquinas em paralelo.

Observação: quando aparecer a mensagem "Job concluído", você poderá fechar o Cloud Shell.

Se você quer remover o projeto Maven gerado, execute `cd .. && rm -R {{directory}}` no Cloud Shell para excluir o diretório.

## Monitorar o job

Verifique o status do seu canal na página da IU de monitoramento do Cloud Dataflow.

### Acessar a página do Cloud Dataflow

Abra o [menu][spotlight-console-menu] no lado esquerdo do console.

Em seguida, selecione a seção **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Selecionar o job

Clique no seu job para ver os detalhes.

### Explorar os detalhes e as métricas do canal

Explore o canal no lado esquerdo e as informações do job localizadas no lado direito. Para ver o status detalhado do job, clique em [Registros][spotlight-job-logs]. Clique em uma etapa no canal para visualizar as métricas dele.

Após a conclusão do job, você verá que ele mudará de status. As instâncias do Compute Engine usadas pelo job serão interrompidas automaticamente.

## Visualizar a saída

Agora que seu job foi executado, explore os arquivos de saída no Cloud Storage.

### Acessar a página do Cloud Storage

Abra o [menu][spotlight-console-menu] no lado esquerdo do console.

Em seguida, selecione a seção **Armazenamento**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Acessar o intervalo de armazenamento

Na lista de intervalos, selecione o que você criou anteriormente. Se você usou a sugestão, o nome do intervalo será `{{project-id}}`.

O intervalo contém uma pasta de teste e pastas de saída. Como o Dataflow salva a saída em fragmentos, seu intervalo terá vários arquivos de saída.

## Limpar

Para não ser cobrado pelo uso do Cloud Storage, exclua o intervalo que você criou.

### Voltar para o navegador de intervalos

Clique no link [Intervalos][spotlight-buckets-link].

### Selecionar o intervalo

Marque a caixa ao lado do intervalo que você acabou de criar.

### Excluir o intervalo

Clique em [Excluir][spotlight-delete-bucket] e confirme a exclusão.

## Conclusão

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Veja o que você pode fazer a seguir:

  *  [Saiba mais sobre o exemplo do WordCount][wordcount]
  *  [Saiba mais sobre o modelo de programação do Cloud Dataflow][df-model]
  *  [Explore o SDK do Cloud Dataflow no GitHub][df-sdk]

Configure seu ambiente local:

  *  [Use o Eclipse para executar o Dataflow][df-eclipse]
  *  [Use o Python para executar o Dataflow][df-python]

[dataflow-java-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-model]: https://cloud.google.com/dataflow/model/programming-model-beam
[df-python]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-sdk]: https://github.com/apache/beam/tree/master/sdks/java
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
