#
# Install required packages
#
apt update -y
apt install git bzip2 libgl1-mesa-glx -y

#
# Create a jupyter user and switch to that context
#
adduser jupyter --uid 2001 --disabled-password --gecos "" --quiet

#
# Install Anaconda
#
cd /tmp
wget https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
bash Anaconda3-5.2.0-Linux-x86_64.sh -b -p /opt/anaconda3

#
# Create a Jupyter configuration or the jupyter user
#
cd /home/jupyter
mkdir .jupyter
git clone https://github.com/JuliaComputing/JuliaBoxTutorials.git notebooks

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nbkey.key -out nbcert.pem --batch

cat <<JUPYTER_CONFIG > /home/jupyter/.jupyter/jupyter_notebook_config.py
c.NotebookApp.certfile = u'/home/jupyter/nbcert.pem'
c.NotebookApp.keyfile = u'/home/jupyter/nbkey.key'
c.NotebookApp.allow_origin = '*'
c.NotebookApp.ip = '*'
c.NotebookApp.port = 8089
c.NotebookApp.password = u'sha1:721564bd62b9:0e360213223406e735c176a72e0fda05404bb90e'
JUPYTER_CONFIG

chown jupyter -R /home/jupyter

#
# Install Julia
#
cd /opt
mkdir julia
cd julia
wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.0-linux-x86_64.tar.gz
tar zxf julia-1.0.0-linux-x86_64.tar.gz
rm julia-1.0.0-linux-x86_64.tar.gz
ln -s /opt/julia/julia-1.0.0/bin/julia /usr/local/bin

#
# Add the Julia kernel to the Jupyter setup
#
cat <<IJULIA > /tmp/ijulia.jl
using Pkg
Pkg.add("IJulia")
IJULIA

chown jupyter /tmp/ijulia.jl
su - jupyter -c 'julia /tmp/ijulia.jl'
rm /tmp/ijulia.jl

#
# Start the notebook server
#
cat <<JUPYTER_SERVICE > /lib/systemd/system/jupyter.service
[Unit]
Description=Jupyter notebook server
After=network.target

[Service]
ExecStart=/opt/anaconda3/bin/jupyter notebook \
    --config=/home/jupyter/.jupyter/jupyter_notebook_config.py \
    --no-browser \
    --port=8089 \
    --notebook-dir=/home/jupyter/notebooks

User=jupyter
Group=jupyter

Restart=no
PrivateTmp=true
ProtectSystem=true

[Install]
WantedBy=multi-user.target
JUPYTER_SERVICE

systemctl enable juypter.service
systemctl daemon-reload
systemctl restart jupyter.service
