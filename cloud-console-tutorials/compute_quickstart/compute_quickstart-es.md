# Tutorial de inicio rápido de Compute Engine

## Diseñar una aplicación de tareas pendientes con MongoDB

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

En este tutorial de inicio rápido utilizarás Compute Engine para crear una
aplicación de dos niveles. La máquina virtual de frontend ejecuta una aplicación
web Node.js de tareas pendientes, y la máquina virtual de backend ejecuta
MongoDB.

En este tutorial se tratan los temas siguientes:

*   Crear y configurar dos máquinas virtuales
*   Configurar las reglas del cortafuegos
*   Usar SSH para instalar paquetes en tus máquinas virtuales

## Configuración del proyecto

Google Cloud Platform organiza los recursos en proyectos para que puedas tener
en un solo lugar todos los recursos de una aplicación.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Ir a Compute Engine

Abre el [menú][spotlight-console-menu] que se encuentra en el lado izquierdo de
la consola.

Luego, elige la sección **Compute Engine**.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Crear instancias

En este tutorial crearás dos instancias, que serán los servidores de backend y
frontend de la aplicación.

### Crea la instancia de backend

Primero, crea la instancia de backend que ejecuta MongoDB. En este servidor se
almacenan los elementos pendientes.

Haz clic en el botón [Crear instancia][spotlight-create-instance] y, a
continuación, realiza las siguientes acciones:

*   Selecciona un [nombre][spotlight-instance-name] y una
    [zona][spotlight-instance-zone] para la instancia.

*   Selecciona [f1-micro][spotlight-machine-type]; así se producirán menos
    cargos.

    *   [Más información sobre los precios][pricing]

*   Selecciona [Ubuntu 14.04 LTS][spotlight-boot-disk] como imagen del disco de
    arranque del tutorial.

*   En el [selector de cortafuegos][spotlight-firewall], selecciona **Permitir
    el tráfico HTTP**. Cuando lo hagas, se abrirá el puerto 80 (HTTP) para
    acceder a la aplicación.

*   Para crear la instancia, haz clic en el botón
    [Crear][spotlight-submit-create].

Nota: Cuando crees la instancia, se empezarán a aplicar los cargos a tu cuenta
de facturación en función de los precios de Google Compute Engine (GCE). Más
adelante podrás quitar la instancia para no incurrir en otros gastos.

### Crea la instancia de frontend

Mientras la máquina virtual de backend se pone en marcha, crea la instancia de
frontend que ejecuta la aplicación Node.js de tareas pendientes. Utiliza la
misma configuración que en la instancia de backend.

## Configuración

A continuación, instalarás una base de datos de MongoDB en la instancia de
backend para guardar tus datos.

Mediante los [botones SSH][spotlight-ssh-buttons] de la tabla, podrás abrir una
sesión SSH a tu instancia en una ventana independiente.

En este tutorial te conectarás mediante Cloud Shell, que es una herramienta de
línea de comandos integrada para la consola.

### Abre Cloud Shell

Para abrir esta herramienta, haz clic en el
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icono][spotlight-open-devshell]
que se encuentra en la barra de navegación de la parte superior de la consola.

### Espera a que termine de crearse la instancia

Para poder continuar con el tutorial, primero debes esperar a que las instancias
terminen de crearse. Para supervisar esta actividad, solo tienes que hacer clic
en el [menú de notificaciones][spotlight-notification-menu] que se encuentra en
la barra de navegación de la parte superior.

## Conectarse a la instancia de backend

### Conéctate a la instancia

Introduce el comando que aparece más adelante para acceder mediante SSH a la
máquina virtual. Si es la primera vez que utilizas el SSH de Cloud Shell,
tendrás que crear una clave privada e introducir la zona y el nombre de la
instancia que has creado.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### Instala la base de datos de backend

Ahora que has establecido una conexión SSH a la instancia de backend, usa los
siguientes comandos para instalar la base de datos de backend:

Luego, actualiza los paquetes e instala MongoDB. Cuando se te pregunte si
quieres continuar, escribe `Y` para confirmar la acción:

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Ejecuta la base de datos

El servicio MongoDB se inició cuando instalaste la base de datos. Debes
detenerlo para poder cambiar su forma de ejecución.

```bash
sudo service mongodb stop
```

Crea un directorio para MongoDB y después ejecuta el servicio MongoDB en segundo
plano en el puerto 80.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Después, sal de la sesión SSH mediante el comando `exit`:

```bash
exit
```

## Conectarse a la instancia de frontend

### Instala y ejecuta la aplicación web en tu máquina virtual de frontend

Como el servidor de backend se está ejecutando, es el momento de instalar la
aplicación web de frontend.

### Conéctate a la instancia

Introduce el comando que aparece más adelante para acceder a la máquina virtual
a través de SSH e introduce la zona y el nombre de la instancia que has creado.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### Instala las dependencias

Ahora que te has conectado a tu instancia de frontend, actualiza los paquetes e
instala git, Node.js y npm. Cuando se te pregunte si quieres continuar, escribe
`Y`:

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Instala y ejecuta la aplicación web de frontend

Clona la aplicación de muestra e instala las dependencias de la aplicación.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Luego, inicia la aplicación web de tareas pendientes con el comando que aparece
a continuación e introduce las [direcciones IP internas][spotlight-internal-ip]
de las instancias que has creado.

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

Después, sal de la sesión SSH mediante el comando `exit`:

```bash
exit
```

### Visita la aplicación

Visita tu servidor web a través de la dirección IP que aparece junto a tu
instancia de frontend en la columna [IP externa][spotlight-external-ip].

## Eliminar los recursos utilizados

Para eliminar las instancias, selecciona la
[casilla][spotlight-instance-checkbox] que aparece junto a sus nombres y haz
clic en el botón [Eliminar][spotlight-delete-button].

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

¡Bien hecho! Ya has terminado.

Esto es lo que puedes hacer a continuación:

*   Encontrar [muestras en GitHub](http://googlecloudplatform.github.io/) de
    Google Cloud Platform

*   Aprender a configurar el
    [balanceo de carga](https://cloud.google.com/compute/docs/load-balancing/)

*   Descubrir cómo
    [transferir archivos a tu máquina virtual](https://cloud.google.com/compute/docs/instances/transfer-files/)

*   Aprender a
    [ejecutar contenedores](https://cloud.google.com/compute/docs/containers)

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
