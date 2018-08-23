# Tutorial de contagem de palavras do Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Introdução

Neste tutorial, você aprenderá os fundamentos do serviço do Cloud Dataflow executando um canal de exemplo simples com o uso do Python.

Os canais do Dataflow são classificados em *lote* (entrada limitada de processamento, como uma tabela de arquivos ou banco de dados) ou *streaming* (entrada ilimitada de processamento, como uma origem do Cloud Pub/Sub, por exemplo). O exemplo que veremos neste tutorial é um canal em lote que conta palavras em uma coleção de obras de Shakespeare.

Antes de começar, você precisará verificar os pré-requisitos em seu projeto do Cloud Platform e fazer a configuração inicial.

## Configuração do projeto

O Google Cloud Platform organiza recursos em projetos. Com isso, você pode coletar todos os recursos relacionados para um único aplicativo em um só lugar.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Configuração do Cloud Dataflow

Para usar o Dataflow, ative as APIs do Cloud Dataflow e abra o Cloud Shell.

### Ativar as APIs do Google Cloud

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Abrir o Cloud Shell

O Cloud Shell é uma ferramenta de linha de comando integrada para o console que você usará para executar seu app.

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Clique no ícone][spotlight-open-devshell] na barra de navegação na parte superior do console para abrir o Cloud Shell.

## Instalar amostras do Cloud Dataflow no Cloud Shell

A versão Python do Cloud Dataflow requer um ambiente de desenvolvimento que tenha o Python, o Google Cloud SDK e o SDK do Cloud Dataflow para Python.
Para gerenciar dependências do SDK, o Cloud Dataflow usa o pip, que é o gerenciador de pacotes do Python.

Este tutorial usa um Cloud Shell que tem o Python e o pip já instalados. Se preferir, você pode fazer este tutorial [na sua máquina local.][dataflow-python-tutorial]

### Faça o download das amostras e do SDK do Cloud Dataflow para Python usando o comando pip

Ao executar esse comando, o pip fará o download e instalará a versão apropriada do SDK do Cloud Dataflow.

```bash
pip install --user google-cloud-dataflow
```

Execute o comando pip no Cloud Shell.

## Configurar um intervalo do Cloud Storage

O Cloud Dataflow usa os intervalos do Cloud Storage para armazenar dados de saída e armazenar o código do canal em cache.

### Execute "gsutil mb"

No Cloud Shell, use o comando `gsutil mb` para criar um intervalo do Cloud Storage.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Para mais informações sobre a ferramenta `gsutil`, consulte a [documentação da ferramenta][gsutil-docs].

## Criar e iniciar um canal

No Cloud Dataflow, o processamento de dados é representado por um *canal*. Esse trabalho de processamento lê os dados de entrada, realiza transformações nesses dados e gera dados de saída. As transformações de um canal podem incluir filtragem, agrupamento, comparação ou associação de dados.

### Inicie seu canal no serviço Dataflow

Use o Python para iniciar seu canal no serviço do Cloud Dataflow. O canal em execução é chamado de *job.*

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  `output` é o intervalo usado pelo exemplo do WordCount para armazenar os resultados do job.

### O job está sendo executado

Parabéns! Seu binário está sendo testado no intervalo de armazenamento que você criou anteriormente, e as instâncias do Compute Engine estão sendo criadas. O Cloud Dataflow dividirá o arquivo de entrada para que os dados possam ser processados ​​por várias máquinas em paralelo.

Observação: quando aparecer a mensagem "JOB_STATE_DONE", você poderá fechar o Cloud Shell.

## Monitorar o job

Verifique o andamento do canal na página do Cloud Dataflow.

### Acesse a página da IU de monitoramento do Cloud Dataflow

Acesse a página IU para monitoramento do Cloud Dataflow, caso isso ainda não tenha sido feito.

[Abra o menu][spotlight-console-menu] no lado esquerdo do console.

Em seguida, selecione a seção **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Selecione o job

Clique no seu job para ver os detalhes.

### Explore os detalhes e as métricas do canal

Explore o canal à esquerda e as informações do trabalho à direita. Para ver o status detalhado do job, clique em [Registros][spotlight-job-logs]. Clique em uma etapa no canal para visualizar suas métricas.

Após a conclusão do job, você verá que ele mudará de status. As instâncias do Compute Engine usadas pelo job serão interrompidas automaticamente.

## Visualizar sua saída

Agora que o job foi executado, explore os arquivos de saída no Cloud Storage.

### Acesse a página do Cloud Storage

[Abra o menu][spotlight-console-menu] no lado esquerdo do console.

Em seguida, selecione a seção **Compute Engine**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Vá até o intervalo de armazenamento

Na lista de intervalos, selecione o que você criou anteriormente. Se você usou a sugestão, o nome do intervalo será `{{project-id}}`.

O intervalo contém uma pasta de teste e pastas de saída. Como o Dataflow salva a saída em fragmentos, seu intervalo terá vários arquivos de saída.

## Limpar

Para não ser cobrado pelo uso do Cloud Storage, exclua o intervalo que você criou.

### Volte para o navegador de intervalos

Clique no link [Intervalos][spotlight-buckets-link].

### Selecione o intervalo

Marque a caixa ao lado do intervalo que você acabou de criar.

### Exclua o intervalo

Clique em [Excluir][spotlight-delete-bucket] e confirme a exclusão.

## Conclusão

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Veja a seguir o que você pode fazer:

  *  [Saiba mais sobre o exemplo do WordCount][wordcount]
  *  [Saiba mais sobre o modelo de programação do Cloud Dataflow][df-pipelines]
  *  [Explore o SDK do Apache Beam SDK no GitHub][beam-sdk]

Configure seu ambiente local:

  *  [Como usar Java e Eclipse para executar o Dataflow][df-eclipse]
  *  [Como usar Java e Maven para executar o Dataflow][df-maven]

[beam-sdk]: https://github.com/apache/beam/tree/master/sdks/python
[dataflow-python-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-maven]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-pipelines]: https://cloud.google.com/dataflow/model/programming-model-beam
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
