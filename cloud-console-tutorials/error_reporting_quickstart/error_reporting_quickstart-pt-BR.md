# Stackdriver Error Reporting

## Introdução

O Stackdriver Error Reporting agrega e exibe erros produzidos por serviços em nuvem.

Neste tutorial, você navegará na interface da Web do Error Reporting. Além disso, aprenderá a listar os erros do aplicativo, ver mais detalhes sobre eles e realizar as ações necessárias.

## Configuração do projeto

<walkthrough-project-setup></walkthrough-project-setup>

## Gerar erros

Antes de continuar, é preciso informar os erros artificiais. Para isso, use o comando `gcloud`.

Em uma situação real, esses erros seriam informados diretamente do seu aplicativo em execução. Depois de seguir este tutorial, você pode saber mais sobre como configurar o Error Reporting.

### Abrir o Google Cloud Shell

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Clique no ícone][spotlight-open-devshell] na barra de navegação na parte superior do console para abrir o Cloud Shell.

### Informar alguns erros

Clique no botão **Copiar para a área de transferência** no canto superior direito do script a seguir e execute-o no Cloud Shell para gerar erros de amostra.

```bash
COUNTER=0
while [  $COUNTER -lt 11 ]; do
    gcloud beta error-reporting events report --service tutorial --service-version v$((COUNTER/10+1)) \
        --message "java.lang.RuntimeException: Error rendering template $COUNTER
          at com.example.TestClass.test(TestClass.java:51)
          at com.example.AnotherClass(AnotherClass.java:25)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    if [ $COUNTER -lt 3 ]; then
      gcloud beta error-reporting events report --service tutorial --service-version v1 \
          --message "java.lang.ArrayIndexOutOfBoundsException: $COUNTER
            at com.example.AppController.createUser(AppController.java:42)
            at com.example.User(User.java:31)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    fi
    if [ $COUNTER -eq 10 ]; then
      echo "All artificial errors reported."
    fi
    let COUNTER=COUNTER+1
done
```

### Fechar o Cloud Shell

Quando terminar, feche o Cloud Shell e clique em *Continuar*.

## Listar os erros dos seus aplicativos

Para acessar rapidamente os erros informados, use o Stackdriver Error Reporting.

### Abrir o Error Reporting

[Abra o menu][spotlight-console-menu] no lado esquerdo do console.

Em seguida, role até a categoria **Stackdriver** e selecione **Error Reporting**.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Classificar por *Visto pela primeira vez*

Por meio da análise dos seus rastreamentos de pilha, os erros que ocorrem no seu aplicativo são agrupados. Além disso, os dados duplicados são removidos. Cada entrada nesta lista fornece um resumo que informa o momento em que o aplicativo começou a gerar erros, a frequência deles e quando ocorreu o último erro.

A classificação padrão é *Ocorrências*. Clique no cabeçalho de *Visto pela primeira vez* para ver os erros que começaram a ocorrer recentemente.

### Inscrever-se para receber notificações sobre novos erros

Quando um erro for visto pela primeira vez no projeto, talvez um e-mail e uma notificação push para dispositivos móveis sejam enviados. Para ativar essas notificações, clique em *Ativar notificações*.

Clique em *Continuar* quando terminar.

## Compreender os detalhes de um erro

### Abrir um relatório de erros

Clique em um erro da lista para ver os detalhes dele.

### Vincular um problema a esse erro

Use esta página para examinar as informações o histórico de um erro específico.

Depois de analisar um erro novo, geralmente a próxima etapa é registrar o problema no rastreador de problemas da sua equipe. A entrada no rastreador pode ser vinculada ao erro no Stackdriver Error Reporting.

Para fazer isso:

  *  Clique em *Link do problema* na parte superior da tela. Talvez seja necessário abrir o menu de **mais ações** para ver esse link.
  *  Digite `http://example.com/issues/1234` na caixa de diálogo.
  *  Clique em *Salvar*.

### Explorar os rastreamentos de pilha

Para ajudar você a se concentrar no seu código, ocultamos os frames de rastreamento de pilha que não se referem ao código do seu aplicativo.

Clique em *Mostrar tudo* em uma amostra de erro para exibir os frames da estrutura da pilha.

## Conclusão

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Parabéns! Você concluiu o tutorial do Stackdriver Error Reporting.

Veja a seguir o que você pode fazer:

### Configurar o Error Reporting no seu projeto

Para saber como configurar o Error Reporting nos seus serviços em execução, acesse a [documentação de configuração][errors-setup].

### Explorar outros tutoriais do Stackdriver

Depure um aplicativo de produção com o guia de início rápido do [Stackdriver Debugger][debug-quickstart].

Para entender a latência do seu aplicativo, consulte o guia de início rápido do [Stackdriver Trace][trace-quickstart].

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
