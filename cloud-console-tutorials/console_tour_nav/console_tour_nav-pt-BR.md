# Tour do Cloud Console

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Introdução

Neste tutorial, você verá os principais recursos do Cloud Console para começar a criar e gerenciar seus aplicativos no Google Cloud Platform.

Você aprenderá sobre os seguintes conceitos:

  *  projetos e recursos do GCP
  *  visão geral de recursos de alto nível e registro de atividades
  *  navegação e pesquisa no console
  *  gerenciamento de usuários e permissões
  *  suporte técnico
  *  linha de comando baseada no navegador do GCP

Vamos começar.

## Usar recursos do GCP

Os recursos do GCP são os componentes fundamentais que compõem todos os serviços do Google Cloud. Os recursos são organizados por hierarquia e ajudam a organizar seu trabalho no GCP.

Os projetos são o primeiro nível da hierarquia de recursos. Eles contêm outros recursos de baixo nível, como intervalos do Cloud Storage e instâncias do Compute Engine.

[Saiba mais sobre os recursos do GCP][gcp-resources]

### Navegar pelos projetos

Use o [seletor de escopo][spotlight-project-select] para navegar facilmente pelos seus projetos do GCP no Cloud Console. Cada projeto tem uma visualização personalizada que inclui os recursos secundários.

<walkthrough-project-setup></walkthrough-project-setup>

## Navegar pelos serviços do Google Cloud

### Navegar pelos serviços

Para acessar os serviços do Google Cloud, use o [menu de navegação do lado esquerdo][spotlight-console-menu]. Ele está organizado por área do produto, incluindo Big Data, computação, rede etc.

### Fixar uma seção

Para serviços acessados regularmente, passe o cursor sobre o item da seção e clique no ícone de fixação para adicioná-la à parte superior do menu de navegação.

Abra o menu de navegação e selecione **Página inicial** para continuar.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Acessar uma visão geral de alto nível de um projeto

### Painel inicial

O painel inicial apresenta uma visão geral de alto nível do projeto do GCP selecionado, com destaque para as métricas principais, faturamento e outras informações úteis.

### Personalização

Clique em [Personalizar][spotlight-customize-dashboard] para editar seu painel.
É possível ocultar, exibir ou reordenar qualquer cartão na página. Além disso, você pode ver as opções de personalização no menu flutuante ao passar o cursor sobre o cartão.

## Ver a atividade nos seus recursos do GCP

Com o [stream de atividades][spotlight-activity-stream], você poderá analisar em um só lugar todas as ações feitas nos seus recursos do GCP.

Veja o que seus colegas atualizaram nos projetos para rastrear problemas e fazer uma auditoria do acesso. Filtre o feed para encontrar exatamente o que você precisa com facilidade.

## Pesquisar em todo o Cloud Console

Com a [barra de pesquisa][spotlight-search-bar] no Cloud Console, você pode acessar rapidamente os produtos do Google Cloud e qualquer um dos seus recursos no GCP.

Pesquise **App Engine** ou o nome de um dos seus projetos.

## Receber suporte a qualquer momento

Se você tiver problemas e precisar de ajuda para navegar pelo ambiente do GCP, entre em contato com a nossa equipe.

[Saiba mais sobre o serviço de suporte](http://cloud.google.com/support)

Acesse o suporte no menu de navegação.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Gerenciar usuários e permissões

Com o Google Cloud Identity and Access Management (Cloud IAM), você pode gerenciar e criar permissões para seus recursos do GCP.

[Saiba mais sobre o IAM](https://cloud.google.com/iam/docs/)

Conforme sua equipe aumenta, conceda acesso a colegas de equipe usando o Cloud IAM na seção "IAM e administrador".

Adicione usuários, grupos ou contas de serviço e atribua os papéis para conceder as permissões de que eles precisam.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Acessar a linha de comando a partir do seu navegador

O Google Cloud Shell oferece acesso de linha de comando aos recursos na nuvem a partir do seu navegador. Gerencie projetos e recursos com facilidade sem precisar instalar o Google Cloud SDK ou outras ferramentas no seu sistema.

Com o <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell][spotlight-open-devshell], a ferramenta de linha de comando gcloud do Cloud SDK e outros utilitários de que você precisa estão sempre disponíveis, atualizados e totalmente autenticados quando necessário.

[Saiba mais sobre o Cloud Shell](https://cloud.google.com/shell/)

## Continuar sua jornada no GCP

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Agora você sabe como navegar pelo Cloud Console e tem as informações necessárias para conhecer novos serviços e produtos.

Na [documentação detalhada](https://cloud.google.com/docs/), você também encontra diversas informações, desde visões gerais de produtos até guias de início rápido e referência de APIs.

Volte para a página "Primeiros passos" e veja mais tutoriais.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
