#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='coderslab'
HOSTNAME='student.edu'

echo
echo "Witaj w CodersLab!"
echo
echo "Ten skrypt zaktualizuje Twój system, zainstaluje kilka niezbędnych programów,"
echo "których będziesz potrzebować podczas kursu oraz skonfiguruje bazę danych MySQL."
echo "W tym czasie na ekranie pojawi się wiele komunikatów."
echo "ABY INSTALACJA SIĘ POWIODŁA MUSISZ MIEĆ DOSTĘP DO INTERNETU W TRAKCIE TRWANIA "
echo "INSTALACJI!"
echo "Proces może potrwać parę minut"
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."

mkdir ~/.coderslab

# pausing updating grub as it might triger ui
sudo apt-mark hold grub*
echo
echo "Aktualizuję system..."

# update / upgrade
sudo apt update
sudo apt -y upgrade
echo
echo "Instaluję narzędzia systemowe..."

# install all used tools
sudo apt install -y curl vim git openjdk-8-jre-headless build-essential unzip

echo
echo "Instaluję bazę danych PostgreSQL i narzędzie PgAdmin4..."

sudo apt install -y postgresql postgresql-contrib

sudo -u postgres createuser -s `whoami`
psql postgres -c "CREATE DATABASE `whoami`;"

sudo apt install -y qt4-dev-tools libqt4-dev libqt4-dev-bin python-dev python-pip libpq-dev
wget "https://ftp.postgresql.org/pub/pgadmin3/pgadmin4/v1.1/source/pgadmin4-1.1.tar.gz"
tar -xzf pgadmin4-1.1.tar.gz
sudo apt -y install python3-pip
sudo pip3 install virtualenv
virtualenv --system-site-packages --no-setuptools ~/py3-venv-pgadmin
cd ~/py3-venv-pgadmin/bin
source activate
cd ../../pgadmin4-1.1/
pip3 install flask flask_security flask_babel htmlmin django-htmlmin dateutil flask_sqlalchemy python-dateutil psycopg2
pip3 install -r requirements_py3.txt
cd runtime/
qmake
make
cd ~/pgadmin4-1.1/web
echo "SERVER_MODE = False" > config_local.py
python3 setup.py
sudo /bin/bash -c 'echo "#!/usr/bin/env bash" > /usr/bin/pgadmin4'
sudo /bin/bash -c 'echo "cd ~/py3-venv-pgadmin/bin" >> /usr/bin/pgadmin4'
sudo /bin/bash -c 'echo "source activate" >> /usr/bin/pgadmin4'
sudo /bin/bash -c 'echo "python3 ~/pgadmin4-1.1/web/pgAdmin4.py &" >> /usr/bin/pgadmin4'
sudo /bin/bash -c 'echo "sleep 2" >> /usr/bin/pgadmin4'
sudo /bin/bash -c 'echo "firefox localhost:5050"  >> /usr/bin/pgadmin4'
sudo chmod +x /usr/bin/pgadmin4

echo "Instaluję edytor sublime text3..."
wget "https://download.sublimetext.com/sublime-text_build-3126_amd64.deb"
sudo dpkg -i sublime-text_build-3126_amd64.deb

echo
echo "Dla pewności -- ponownie aktualizuję system..."
# update and upgrade all packages
sudo apt update -y
sudo apt upgrade -y

echo "Instaluję RVM i Rubyego..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby

echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc

# unpausing updating grub
sudo apt-mark unhold grub*

echo
echo "Instalacja ukończona poprawnie!"
echo
echo "Po naciśnięciu dowolnego klawisza, zamknę to okienko terminala."
echo "Uruchom następne jeśli potrzebujesz z niego korzystać."
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."
kill -9 $PPID