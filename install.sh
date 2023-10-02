#!/data/data/com.termux/files/usr/bin/bash

# Configuracao Inicial
clear
pkg i ncurses-utils -y
clear

tput civis
termux-setup-storage -y &> /dev/null

# Separador de Linha
function linebreaker {
	for i in $(seq 1 $(tput cols)); do
		echo -en "\033[1m\033[35m=\033[0m"
	done
}

# Sinalizar os Creditos
linebreaker
echo -e "\033[1m\033[32mPROJETO: \033[37mTermux-Pawn"
echo -e "\033[1m\033[32mAUTORES: \033[37mBeerlID e DeviceBlack"
linebreaker

# Atualizar os Pacotes
echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mUpdating packages............................ \033[32m[\033[37m**\033[32m]"
yes | pkg update -y &> /dev/null
yes | pkg upgrade -y &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

# Instalar os Repositorios
echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling Repository x11-repo................ \033[32m[\033[37m**\033[32m]"
pkg install x11-repo -y &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling Repository tur-repo................ \033[32m[\033[37m**\033[32m]"
pkg install tur-repo -y &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

# Atualizar os Repositorios
echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mUpdating repositories....................... \033[32m[\033[37m**\033[32m]"
yes | pkg update -y &> /dev/null
yes | pkg upgrade -y &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

# Instalar os Pacotes
echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling Package cmake........................ \033[32m[\033[37m**\033[32m]"
pkg install cmake -y &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling Package gcc-9........................ \033[32m[\033[37m**\033[32m]"
pkg install gcc-9 -y &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling Package git.......................... \033[32m[\033[37m**\033[32m]"
pkg install git -y &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling Package make......................... \033[32m[\033[37m**\033[32m]"
pkg install make -y &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mDownloading the repository Device-Black/Termux-Pawn.. \033[32m[\033[37m**\033[32m]"
git clone https://github.com/device-black/termux-pawn $HOME/Termux-Pawn -q
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mDownloading the repository pawn-lang/compiler........ \033[32m[\033[37m**\033[32m]"
git clone https://github.com/pawn-lang/compiler $HOME/compiler -q
mv $HOME/Termux-Pawn/pawncc.c $HOME/compiler/source/compiler/ &> /dev/null
mv $HOME/Termux-Pawn/amxcons.c $HOME/compiler/source/amx/ &> /dev/null
mv $HOME/Termux-Pawn/prun3.c $HOME/compiler/source/amx/pawnrun/ &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

# Sugerir Tradução
echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[35mWould you like to install the translated compiler? (N because it already translated) \033[37m[y/N] "
read translate

if [ "$translate" = "y" ] || [ "$translate" = "Y" ]; then
	mv $HOME/Termux-Pawn/libpawnc.c $HOME/compiler/source/compiler/ &> /dev/null
	mv $HOME/Termux-Pawn/sc1.c $HOME/compiler/source/compiler/ &> /dev/null
	mv $HOME/Termux-Pawn/sc5.c $HOME/compiler/source/compiler/ &> /dev/null
fi

# Construir o Compilador
echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mBuilding the compiler, please wait [1/2]................. \033[32m[\033[37m**\033[32m]"
mkdir -p $HOME/compiler/build && cd $HOME/compiler/build
cmake $HOME/compiler/source/compiler -DCMAKE_C_COMPILER=$PREFIX/bin/gcc-9 -DCMAKE_BUILD_TYPE=Release &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mBuilding the compiler, please wait [2/2]................. \033[32m[\033[37m**\033[32m]"
make &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

# Instalando os Programas
echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling the command pawncc.................... \033[32m[\033[37m**\033[32m]"
mv $HOME/compiler/build/pawncc $PREFIX/bin/ &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling the command pawndisasm................ \033[32m[\033[37m**\033[32m]"
mv $HOME/compiler/build/pawndisasm $PREFIX/bin/ &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling the command pawnruns.................. \033[32m[\033[37m**\033[32m]"
mv $HOME/compiler/build/pawnruns $PREFIX/bin/ &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mInstalling the library libpawnc.so............ \033[32m[\033[37m**\033[32m]"
mv $HOME/compiler/build/libpawnc.so $PREFIX/lib/ &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

# Movendo a Pasta do Projeto
echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mMoving the pawn-lang folder to the sdcard........ \033[32m[\033[37m**\033[32m]"
mv $HOME/Termux-Pawn/pawn-lang /storage/emulated/0/ &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

# Limpando o Cache
echo -en "\033[1m\033[32m[\033[37m+\033[32m] \033[33mCleaning Cache...................... \033[32m[\033[37m**\033[32m]"
rm -rf $HOME/Termux-Pawn $HOME/compiler &> /dev/null
echo -e "\b\b\b\033[1m\033[37mOK\033[32m]"

# Como Usar
linebreaker
echo -e "\033[1m\033[32mCompiler successfully installed!\n"
echo -e "\033[0m\033[1m- Note that the folder \033[33m\"pawn-lang\" \033[37mis in internal storage (sdcard)!"
echo -e "\033[0m\033[1m- Use \033[33mcd /sdcard/pawn-lang \033[37mto navigate to the folder!"
echo -e "\033[0m\033[1m- Use \033[33mpawncc <example.pwn> \033[37mto compile the script!\n"
echo -e "\033[1m\033[32mExample :"
echo -e "\033[0m\033[1mcd /sdcard/pawn-lang"
echo -e "\033[0m\033[1mpawncc gamemodes/new.pwn\n"
linebreaker
echo -e "------------------Indonesia------------------"
echo -e "\033[1m\033[32mPawno Compiler sukses diinstall!\n"
echo -e "\033[0m\033[1m- Harap perhatikan folder \033[33m\"pawn-lang\" \033[37mberada di internal storage (sdcard)!"
echo -e "\033[0m\033[1m- Gunakan \033[33mcd /sdcard/pawn-lang \033[37muntuk mengarah ke folder!"
echo -e "\033[0m\033[1m- Gunakan \033[33mpawncc <example.pwn> \033[37muntuk compile script!\n"
echo -e "\033[1m\033[32mContoh :"
echo -e "\033[0m\033[1mcd /sdcard/pawn-lang"
echo -e "\033[0m\033[1mpawncc gamemodes/new.pwn\n\n"
echo -e "\033[0m\033[1mUntuk menambahkan includes, gunakan pawncc <contoh.pwn> -i<lokasi>\n"
echo -e "\033[0m\033[1mContoh: \n"
echo -e "\033[0m\033[1mJika foldermu berada di sdcard maka pawncc <gm.pwn> -i/sdcard/gamemode/includes/ \n"

echo -e "\n\033[0m\033[1mHappy Scripting!\n"
echo -e "\n\033[0m\033[1mTranslated to English By: Tayoikoo"
linebreaker

# Restaurar o Cursor
tput cnorm
