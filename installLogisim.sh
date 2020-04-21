#!/bin/bash
# Instala o logisim em sistemas linux
# Autor: José Elias
# Data: 21.04.2020


Text='\033[1;32m' 
Err='\033[1;31m'
Return='\033[1;30m'
usuario='/home/eliaspbareia' # modifique para seu usuário
data_link="https://ufpr.dl.sourceforge.net/project/circuit/2.7.x/2.7.1/logisim-generic-2.7.1.jar"

# Verifica se o usuário está como root
if [ "$(id -u)" != "0" ]
then
    clear
    sleep 1.5
    echo -e "${Err}Desculpe, você não é usuário root"
    sleep 1.0
    echo -e "Por favor, execute usando ${Text}sudo installLogisim.sh"
    sleep 1.0
    echo -e "${Err}Cancelando a instalação"
    sleep 1.5
    echo -e "${Return}"
    exit 1
fi
# Inicia a instalação
clear
echo -e "${Text}Iniciar download do LogiSim"
sleep 1.5
echo

cd ${usuario}/Downloads

wget --spider $data_link
status=`echo $?`

if [ "${status}" -eq "0" ]; then
    wget https://ufpr.dl.sourceforge.net/project/circuit/2.7.x/2.7.1/logisim-generic-2.7.1.jar
    wget https://ufpr.dl.sourceforge.net/project/logisim-linux/logisim-icon-icon.png
    sleep 1.5
    echo -e "${Return}"
else
    echo -e "${Err}O arquivo não existe mais na base de dados."
    echo -e "${Return}"
fi
sleep 1.5

# Verifica se a pasta bin existe em home/user
# caso contrário cria

if [ ! -d /usr/share/logisim ]; then
    mkdir /usr/share/logisim/
fi

echo -e "${Text}Movendo o arquivo e criando atalho"
echo -e "${Return}"
mv logisim-generic-2.7.1.jar /usr/share/logisim/
mv resources/logisim-icon-icon.png /usr/share/logisim/

sleep 1.0

tee /usr/share/applications/logisim.desktop <<ATALHO
[Desktop Entry]
Version=1.0
Name=Logisim
Keywords=logisim;
Comment=Aplicativo para simulação de circuitos.
Exec=java -jar /usr/share/logisim/logisim-generic-2.7.1.jar
Icon=/usr/share/logisim/logisim-icon-icon.png
Path=/usr/share/logisim
Terminal=false
Type=Application
Categories=Application;
ATALHO

echo -e "${Text}Inté..."
sleep 1.5
echo -e "${Return}"
