#!/bin/bash
set -eou pipefail

if ! command -v pip3 &> /dev/null; then
   if [ "$EUID" -ne 0 ]; then
      printf "Please run as root to install pip3"
      exit 1
   fi
   printf "  Install pip3 (as root)... "
   sudo apt-get install python3-pip 1> /dev/null
   printf "\r✔ Install pip3 (as root)   \n"
else
   printf "\r✔ pip3 already installed\n"
fi

printf "  Install pynvim and msgpack... "
pip3 install --upgrade pynvim msgpack 1> /dev/null
printf "\r✔ Install pynvim and msgpack   \n"

printf "  Get vim-plug... "
curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
	--create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

printf "\r✔ Get vim-plug   \n"

printf "  Install all plugins with vim-plug... "
nvim --headless +PlugUpgrade +PlugInstall +PlugUpdate +UpdateRemotePlugins +qa &> /dev/null
printf "\r✔ Install all plugins with vim-plug   \n"

printf "Enjoy."

