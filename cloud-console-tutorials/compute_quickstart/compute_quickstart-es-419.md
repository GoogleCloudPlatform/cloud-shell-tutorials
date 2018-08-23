# Inicio rápido de Compute Engine

## Diseña una aplicación de tareas pendientes con MongoDB

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

En esta guía de inicio rápido, usarás Compute Engine para crear una aplicación
de dos niveles. La VM de frontend ejecuta una app web Node.js de tareas
pendientes y la VM de backend ejecuta MongoDB.

En este instructivo se tratan los temas siguientes:

*   Crear y configurar dos VM
*   Configurar las reglas del firewall
*   Usar SSH para instalar paquetes en tus VM

## Configuración del proyecto

Google Cloud Platform organiza los recursos en proyectos. Esto te permite
recopilar todos los recursos relacionados con una aplicación específica en un
solo lugar.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Navega a Compute Engine

Abre el [menú][spotlight-console-menu] ubicado en el lado izquierdo de la
consola.

Luego, selecciona la sección **Compute Engine**.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Crea instancias

Crearás 2 instancias, que serán los servidores de backend y frontend de la
aplicación.

### Crea la instancia de backend

Primero, crea la instancia de backend que ejecuta MongoDB. Este servidor
almacena los elementos de tareas pendientes.

Haz clic en el botón [Create instance][spotlight-create-instance].

*   Selecciona un [nombre][spotlight-instance-name] y una
    [zona][spotlight-instance-zone] para esta instancia.

*   Selecciona [f1-micro][spotlight-machine-type]. Esto te generará menos
    cargos.

    *   [Más información sobre los precios][pricing]

*   Selecciona [Ubuntu 14.04 LTS][spotlight-boot-disk] como tu imagen de disco
    de arranque para este instructivo.

*   En [Firewall selector][spotlight-firewall], selecciona **Allow HTTP
    traffic**. Esto abre el puerto 80 (HTTP) para acceder a la app.

*   Haz clic en el botón [Create][spotlight-submit-create] para crear la
    instancia.

Nota: Una vez creada la instancia, comenzará a cobrarse en tu cuenta de
facturación de acuerdo con los precios de GCE. Luego, deberás quitar la
instancia para evitar cargos adicionales.

### Crea la instancia de frontend

Mientras la VM de backend se pone en marcha, crea la instancia de frontend que
ejecuta la aplicación Node.js de tareas pendientes. Usa la misma configuración
que en la instancia de backend.

## Configuración

Instalarás una base de datos de MongoDB en la instancia de backend para guardar
tus datos.

Los [botones SSH][spotlight-ssh-buttons] de la tabla abrirán una sesión de SSH
para tu instancia en una ventana diferente.

Para este instructivo, te conectarás con Cloud Shell. Cloud Shell es una
herramienta de línea de comandos integrada para Console.

### Abre Cloud Shell

Para abrir Cloud Shell, haz
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>clic en el
[ícono][spotlight-open-devshell] de la barra de navegación ubicada en la parte
superior de Console.

### Espera a que termine de crearse la instancia.

Las instancias deben terminar de crearse para poder continuar con el
instructivo. Para realizar un seguimiento de la actividad, haz clic en el
[menú de notificaciones][spotlight-notification-menu] en la barra de navegación
de la parte superior.

## Conéctate a tu instancia de backend

### Conéctate a la instancia

Ingresa el siguiente comando para establecer una conexión SSH a la VM. Si es la
primera vez que usas el protocolo SSH desde Cloud Shell, tendrás que crear una
clave privada. Ingresa la zona y el nombre de la instancia que creaste.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### Instala la base de datos de backend

Ahora que tienes una conexión SSH a la instancia de backend, usa los siguientes
comandos para instalar la base de datos de backend:

Actualiza los paquetes y luego instala MongoDB. Cuando se te pregunte si deseas
continuar, escribe `Y`:

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Ejecuta la base de datos

El servicio de MongoDB se inició cuando lo instalaste. Debes detenerlo para
poder modificar su ejecución.

```bash
sudo service mongodb stop
```

Crea un directorio para MongoDB y luego ejecuta el servicio de MongoDB en
segundo plano, en el puerto 80.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Después, sal de la sesión de SSH con el comando `exit`:

```bash
exit
```

## Conéctate a tu instancia de frontend

### Instala y ejecuta la aplicación web en tu VM de frontend

El servidor de backend se está ejecutando, por lo que es momento de instalar la
aplicación web de frontend.

### Conéctate a la instancia

Ingresa el siguiente comando a SSH en la VM. Ingresa la zona y el nombre de la
instancia que creaste.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### Instala las dependencias

Ahora que te conectaste a tu instancia de frontend, actualiza los paquetes a fin
de instalar git, Node.js y npm. Cuando se te pregunte si deseas continuar,
escribe `Y`:

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Instala y ejecuta la app web de frontend

Instala las dependencias de la aplicación después de clonar la aplicación de
muestra.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Inicia la aplicación de tareas pendientes con el siguiente comando. Ingresa las
[direcciones IP internas][spotlight-internal-ip] de las instancias que creaste.

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

Después, sal de la sesión de SSH con el comando `exit`:

```bash
exit
```

### Visita tu aplicación

Visita el servidor web en la dirección IP que aparece en la columna
[External IP][spotlight-external-ip], junto a la instancia de frontend.

## Limpieza

Para quitar tus instancias, selecciona la
[casilla de verificación][spotlight-instance-checkbox] junto a los nombres de
tus instancias y haz clic en el [botón Delete][spotlight-delete-button].

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

¡Listo!

A continuación, puedes hacer lo siguiente:

*   Encuentra
    [muestras de Google Cloud Platform en GitHub](http://googlecloudplatform.github.io/).

*   Obtén información sobre cómo configurar el
    [balanceo de cargas](https://cloud.google.com/compute/docs/load-balancing/).

*   Obtén información sobre cómo
    [transferir archivos a tu máquina virtual](https://cloud.google.com/compute/docs/instances/transfer-files/).

*   Obtén información sobre cómo
    [ejecutar contenedores](https://cloud.google.com/compute/docs/containers).

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
