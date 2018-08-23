# Ativar IAP para GCE/GKE

O Identity-Aware Proxy (IAP) protege somente o tráfego que passa pelo balanceador de carga. Siga as etapas mostradas a seguir para proteger seu aplicativo contra ataques.

[Saiba mais](https://cloud.google.com/iap/docs/)

## Veja aqui as etapas necessárias:

### Analise a configuração da rede

Se os IPs do balanceador de carga, `130.211.0.0/22` e `35.191.0.0/16`, não atingirem seus back-ends, o IAP **não funcionará**.

Se qualquer outro IP puder acessar seus back-ends, sua política de acesso ao IAP será ignorada por esse tráfego. Isso pode ser útil em alguns casos. Por exemplo, para permitir que sistemas de monitoramento se conectem a back-ends.

### Monitore a configuração da sua rede

Se a sua configuração for alterada depois da ativação do IAP, ela poderá se tornar insegura.
Implante a [Forseti Security][forseti-security], uma ferramenta de código aberto mantida pelo Google, para monitorar continuamente a configuração do projeto e enviar notificações.

### Implemente a verificação de cabeçalho assinada

[Saiba como](https://cloud.google.com/iap/docs/signed-headers-howto) proteger seu aplicativo contra desvios da política de acesso do IAP, como as seguintes:

  *  desativação acidental do IAP por um administrador de projeto
  *  erros de configuração de rede
  *  um usuário entra na VM e se conecta ao servidor da Web via "localhost"

### Confirme a configuração

Concorde que você leu e configurou o recurso GCE/GKE de acordo com a documentação.

[Veja como fazer isso][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
