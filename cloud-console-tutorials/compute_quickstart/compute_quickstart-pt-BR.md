# Guia de início rápido do Compute Engine

## Criar um app de tarefas com o MongoDB

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

Neste guia de início rápido, você utilizará o Google Compute Engine para criar
um aplicativo de duas camadas. A VM de front-end executa um app da Web de
tarefas Node.js e a VM back-end executa o MongoDB.

Neste tutorial, você aprenderá como:

*   criar e configurar duas VMs;
*   configurar regras de firewall;
*   usar SSH para instalar pacotes nas suas VMs.

## Configuração do projeto

O Google Cloud Platform organiza recursos em projetos. Com isso, você pode
coletar todos os recursos relacionados a um único aplicativo em um só lugar.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Navegar até o Compute Engine

Abra o [menu][spotlight-console-menu] no lado esquerdo do console.

Em seguida, clique na seção **Compute Engine**.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Criar instâncias

Você criará duas instâncias para serem servidores de back-end e front-end do
aplicativo.

### Criar a instância de back-end

Primeiro, crie a instância de back-end que executa o MongoDB. Este servidor
armazena os itens de tarefas.

Clique no botão [Criar instância][spotlight-create-instance].

*   Selecione um [nome][spotlight-instance-name] e uma
    [zona][spotlight-instance-zone] para esta instância.

*   Selecione [f1-micro][spotlight-machine-type]. Isso gerará menos cobranças.

    *   [Saiba mais sobre preços][pricing]

*   Selecione [Ubuntu 14.04 LTS][spotlight-boot-disk] como sua imagem do disco
    de inicialização para este tutorial.

*   No [seletor do Firewall][spotlight-firewall], selecione **Permitir tráfego
    HTTP**. Essa opção abre a porta 80 (HTTP) para acessar o app.

*   Clique no botão [Criar][spotlight-submit-create] para criar a instância.

Observação: depois que a instância for criada, sua conta de faturamento começará
a ser cobrada de acordo com o preço do GCE. Você removerá a instância mais tarde
para evitar cobranças adicionais.

### Criar a instância de front-end

Enquanto a VM de back-end está em operação, crie a instância de front-end que
executa o aplicativo de tarefas desenvolvido em Node.js. Use a mesma
configuração da instância de back-end.

## Configuração

Você instalará um banco de dados MongoDB na instância de back-end para salvar os
dados.

Os [botões SSH][spotlight-ssh-buttons] na tabela abrirão uma sessão SSH para sua
instância em uma janela separada.

Para este tutorial, você se conectará usando o Cloud Shell, uma ferramenta de
linha de comando integrada do console.

### Abrir o Cloud Shell

Para abrir o Cloud
Shell,<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> acesse a
barra de navegação localizada na parte superior do console e
[clique no ícone][spotlight-open-devshell].

### Aguardar a conclusão da criação da instância

A criação das instâncias precisa ser concluída antes que você possa continuar o
tutorial. Para acompanhar a atividade, acesse a barra de navegação localizada na
parte superior da página e clique no
[menu de notificação][spotlight-notification-menu].

## Conectar-se à instância de back-end

### Conectar-se à instância

Digite o seguinte comando para SSH na VM. Se esta for a primeira vez que você
usa SSH do Cloud Shell, será preciso criar uma chave privada. Insira a zona e o
nome da instância que você criou.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### Instalar o banco de dados do back-end

Agora que você tem uma conexão SSH com a instância de back-end, use os seguintes
comandos para instalar o banco de dados do back-end:

Atualize pacotes e instale o MongoDB. Quando for perguntado se você quer
continuar, digite `Y`:

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Executar o banco de dados

O serviço MongoDB foi iniciado quando você o instalou. É necessário
interrompê-lo para alterar as configurações dele.

```bash
sudo service mongodb stop
```

Crie um diretório para o MongoDB e execute o serviço MongoDB em segundo plano na
porta 80.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Após isso, utilize o comando `exit` para sair da sessão SSH:

```bash
exit
```

## Conectar-se à instância de front-end

### Instalar e executar o app da Web na sua VM de front-end

Com o servidor de back-end em execução, é hora de instalar o aplicativo da Web
de front-end

### Conectar-se à instância

Digite o seguinte comando para SSH na VM. Insira a zona e o nome da instância
que você criou.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### Instalar as dependências

Agora que você se conectou à sua instância de front-end, atualize pacotes e
instale o git, o Node.js e o npm. Quando for perguntado se você quer continuar,
digite `Y`:

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Instalar e executar o aplicativo da Web de front-end

Clone o app de amostra e instale as dependências do app.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Utilize o comando a seguir para iniciar o aplicativo da Web de tarefas e insira
os [endereços IP internos][spotlight-internal-ip] para as instâncias criadas.

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

Após isso, utilize o comando `exit` para sair da sessão SSH:

```bash
exit
```

### Acessar seu aplicativo

Acesse seu servidor da Web no endereço IP listado na coluna
[IP externo][spotlight-external-ip] ao lado da sua instância de front-end.

## Limpeza

Para remover suas instâncias, marque a
[caixa de seleção][spotlight-instance-checkbox] ao lado do nome das instâncias e
clique no botão [Excluir][spotlight-delete-button].

## Conclusão

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Pronto!

Veja a seguir o que você pode fazer:

*   Veja
    [exemplos do Google Cloud Platform no GitHub](http://googlecloudplatform.github.io/).

*   Aprenda a configurar o
    [balanceamento de carga](https://cloud.google.com/compute/docs/load-balancing/).

*   Aprenda a
    [transferir arquivos para sua máquina virtual](https://cloud.google.com/compute/docs/instances/transfer-files/).

*   Aprenda a
    [executar contêineres](https://cloud.google.com/compute/docs/containers).

[pricing]: https://cloud.google.com/compute/#compute-engine-pricing
[spotlight-boot-disk]: walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-control-panel]: walkthrough://spotlight-pointer?cssSelector=#p6n-action-bar-container-main
[spotlight-create-instance]: walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-external-ip]: walkthrough://spotlight-pointer?cssSelector=.p6n-external-link
[spotlight-firewall]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall
[spotlight-instance-checkbox]: walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-internal-ip]: walkthrough://spotlight-pointer?cssSelector=gce-internal-ip
[spotlight-machine-type]: walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select
[spotlight-notification-menu]: walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-ssh-buttons]: walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[spotlight-vm-list]: walkthrough://spotlight-pointer?cssSelector=vm2-instance-list%20.p6n-checkboxed-table
