# Guia de início rápido do Cloud Storage

## Bem-vindo ao Google Cloud Storage.

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

O Google Cloud Storage é uma solução de armazenamento avançada e com ótimo custo-benefício para objetos não estruturados. Ele é perfeito para qualquer tarefa, incluindo hospedagem de conteúdo da Web, armazenamento para análise, arquivamento e backup.

Neste tutorial, mostraremos como é fácil começar a armazenar objetos no Cloud Storage. Você precisará fazer o seguinte:

  *  **Criar um intervalo**

     Os intervalos guardam os objetos de qualquer tipo de arquivo que você pretende armazenar no Cloud Storage.

  *  **Fazer upload e compartilhar objetos**

     Faça upload de um objeto e o torne público para começar a usar o intervalo.

  *  **Limpeza**

     Como última etapa, você excluirá o intervalo e o objeto criados neste tutorial.

Como o intervalo e o objeto serão excluídos, não se preocupe. Você não receberá nenhuma cobrança pelas tarefas concluídas aqui.

## Configuração do projeto

Para criar recursos no Cloud Storage, é necessário ter um projeto.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Criar um intervalo

No Cloud Storage, você armazena seus objetos em intervalos. Para criar um intervalo, acesse o navegador do Cloud Storage.

Abra o [menu][spotlight-menu] no lado esquerdo do console.

Em seguida, selecione a seção **Armazenamento**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Criar um intervalo

Antes de começar a fazer upload de objetos, você precisa criar um intervalo para armazená-los. Com os intervalos, é possível organizar seus objetos e controlar o acesso a eles.

  1. Clique em [Criar intervalo](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,).

  1. Na página de criação do intervalo, especifique as propriedades dele. Lembre-se do seguinte:

     *  **Nome:** Pense em algo único. Você verá um erro se digitar um nome igual ao de outro intervalo existente no Cloud Storage.
     *  **Classe de armazenamento padrão:** essa é a classe de armazenamento atribuída por padrão aos objetos do seu intervalo. Sua escolha depende principalmente da frequência de acesso aos objetos e se você disponibilizará os dados em todo o mundo. A classe de armazenamento afeta o custo.
     *  **Localização:** é recomendável manter seus dados próximos dos aplicativos e usuários que os acessam. As opções disponíveis dependem da seleção da classe de armazenamento.

Neste tutorial, qualquer classe de armazenamento e local serve, já que você excluirá o intervalo no final.

  1. Clique em [Criar][spotlight-create-button].

## Fazer upload de um objeto

Agora que você tem um intervalo, comece a fazer upload de objetos.

  1. Na parte superior da página, clique em [Fazer upload de arquivos][spotlight-upload-file].

  1. Selecione um arquivo para o upload. Você pode fazer upload de qualquer tipo de arquivo.

     Você não tem um arquivo? [Crie um arquivo de amostra][create-sample-file] e clique em [Atualizar intervalo][spotlight-refresh-bucket] na parte superior da página para vê-lo no seu intervalo. Dica: também é possível arrastar e soltar os objetos na área abaixo do nome do intervalo para fazer upload.

## Excluir o intervalo

Agora vamos excluir o intervalo que você acabou de criar. A exclusão de um intervalo também exclui o conteúdo dele.

  1. Na parte superior da tabela, clique em [Intervalos][spotlight-buckets-link] para retornar à lista de intervalos.

  1. Marque a caixa ao lado do seu intervalo. Se este projeto tiver outros intervalos, e você precisar de ajuda para encontrar os seus, use a barra de pesquisa para filtrar a lista de intervalos.

  1. Na parte superior da página, clique em [Excluir][spotlight-delete-buckets] e confirme a exclusão.

## Conclusão

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Parabéns!

Agora que você já sabe como armazenar objetos no Cloud Storage, veja como colocar seus conhecimentos em prática para [hospedar um site estático](https://cloud.google.com/storage/docs/hosting-static-website).

Você também pode aprender a usar o Cloud Storage com a [ferramenta de linha de comando gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil).

Saiba como você pode começar a usar o Cloud Storage e outros serviços do GCP com a [camada gratuita](https://cloud.google.com/free).

[create-sample-file]: walkthrough://create-sample-storage-file
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-create-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,#p6n-cloudstorage-create-bucket
[spotlight-create-button]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button
[spotlight-delete-buckets]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket
[spotlight-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-public-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-label
[spotlight-refresh-bucket]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects
[spotlight-share-public]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-checkbox
[spotlight-upload-file]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file
