#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='coderslab'
HOSTNAME='student.edu'

echo
echo "Witaj w CodersLab!"
echo
echo "Ten skrypt zaktualizuje Twój system, zainstaluje kilka niezbędnych programów,"
echo "których będziesz potrzebować podczas kursu oraz skonfiguruje bazę danych PostgreSQL."
echo "W tym czasie na ekranie pojawi się wiele komunikatów."
echo "ABY INSTALACJA SIĘ POWIODŁA MUSISZ MIEĆ DOSTĘP DO INTERNETU W TRAKCIE TRWANIA "
echo "INSTALACJI!"
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."

mkdir ~/.coderslab

echo "Instaluję homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#install homebrew

echo "Instaluję potrzebne narzędzia..."
brew install curl
brew install git
brew install wget
brew install gpg

cd ~/.coderslab
wget https://github.com/PostgresApp/PostgresApp/releases/download/9.6.1/Postgres-9.6.1.zip
unzip Postgres-9.6.1.zip
mv Postgres.app /Applications
open /Applications/Postgres.app

wget https://ftp.postgresql.org/pub/pgadmin3/pgadmin4/v1.1/macos/pgadmin4-1.1.dmg
open pgadmin4-1.1.dmg

echo "Kliknij 'Agree' i przeciągnij ikonkę PgAdmina do folderu 'Aplikacje'"
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."

wget https://download.sublimetext.com/Sublime%20Text%20Build%203126.dmg
open "Sublime Text Build 3126.dmg"
echo "Przeciągnij ikonkę Sublime Text do folderu 'Aplikacje'"
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."

echo "Instaluję RVM i Rubyego..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby

source ~/.rvm/scripts/rvm
