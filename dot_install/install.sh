#!/bin/bash

if [ "${EUID}" -ne 0 ]; then
	echo "Please run as root, exiting ..."
	exit
fi

CURRENT_DIR="$(pwd)"
USER_HOME_DIR="$(getent passwd $SUDO_USER | cut -d: -f6)"
USER_CONFIG_DIR="${USER_HOME_DIR}"/.config
USER_LOCAL="${USER_HOME_DIR}"/.local
USER_CACHE="${USER_HOME_DIR}"/.cache
USER_LOCAL_SHARE="${USER_LOCAL}"/share
# -- DOT FILES
DOT_FILES_DIR="${USER_CONFIG_DIR}"/dotfiles
# -- FONTS
FONTS_LOCAL_SHARE="${USER_LOCAL_SHARE}"/fonts
# -- TMUX
TMUX_CONFIG_DIR="${USER_CONFIG_DIR}"/tmux
# -- NEOVIM
NVIM_CONFIG_DIR="${USER_CONFIG_DIR}"/nvim
NVIM_LOCAL_STATE="${USER_LOCAL}"/state/nvim
NVIM_LOCAL_SHARE="${USER_LOCAL_SHARE}"/nvim
NVIM_CACHE="${USER_CACHE}"/nvim


echo "${CURRENT_DIR}"
echo "${USER_HOME_DIR}"
echo "${USER_CONFIG_DIR}"
echo "${USER_LOCAL}"
echo "${USER_LOCAL_SHARE}"

echo "${DOT_FILES_DIR}"
echo "${FONTS_LOCAL_SHARE}"

echo "${TMUX_CONFIG_DIR}"

echo "${NVIM_CONFIG_DIR}"
echo "${NVIM_LOCAL_STATE}"
echo "${NVIM_LOCAL_SHARE}"
echo "${NVIM_CACHE}"

# ------- INSTALL BASIC TOOL CHAINS FOR BUILDING -------
function install_toolchains () {
apt-get update
apt-get install -y \
build-essential \
git \
cmake \
make \
gcc \
g++ \
pkg-config \
unzip \
gdb \
curl \
python3 \
python3-pip \
python3-venv \
software-properties-common \
xclip \
xsel \
unzip \


# ------- INSTALL ADDITIONAL SOURCES -------
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update


# ------- INSTALL TOOLS -------
sudo apt-get install -y \
neovim \
tmux \

}



# ------- DOT FILES -------
function download_dotfiles () {

# ------- USER CALLING SUDO -------
sudo -E -u "${SUDO_USER}" bash <<EOF
	
		if [ -d "${DOT_FILES_DIR}" ]; then
			cd "${DOT_FILES_DIR}"
			sudo -u "${SUDO_USER}" git pull
		else
			mkdir -p "${DOT_FILES_DIR}"
			sudo -u "${SUDO_USER}" git clone https://github.com/MaybeNotABob/dot-files.git "${DOT_FILES_DIR}"
		fi

		cd "${CURRENT_DIR}"
			
EOF
# ------- END USER CALLING SUDO -------
}


# ------- NEOVIM SETTINGS -------
function neovim_settings () {

# ------- USER CALLING SUDO -------
sudo -E -u "${SUDO_USER}" bash <<EOF
	
		# pyright requires nodejs and npm
		#sudo apt-get install -y nodejs npm
		#
		# lua might be needed? 
		#sudo apt-get install lua5.4 luajit
		#
		# if behind a firewall you may need
		# to set curl -k option in curlrc to allow
		# insecure certs for downloading/clone from github


		# if neovim config already exists remove
		# it ready for updates
		if [ -d "${NVIM_CONFIG_DIR}" ]; then
		
			echo "Trying to remove ${NVIM_CONFIG_DIR}"
			rm -rf "${NVIM_CONFIG_DIR}"
		
			# remove cache if it exists
			if [ -d "${NVIM_CACHE}" ]; then
				echo "Trying to remove ${NVIM_CACHE}"
				rm -rf "${NVIM_CACHE}"
			fi

			if [ -d "${NVIM_LOCAL_STATE}" ]; then
				echo "Trying to remove ${NVIM_LOCAL_STATE}"
				rm -rf "${NVIM_LOCAL_STATE}"
			fi	
			
			if [ -d "${NVIM_LOCAL_SHARE}" ]; then
				echo "Trying to remove ${NVIM_LOCAL_SHARE}"
				rm -rf "${NVIM_LOCAL_SHARE}"
			fi	
			
		fi

		echo "Copying ${DOT_FILES_DIR}/nvim to ${NVIM_CONFIG_DIR}" 
		cp -r "${DOT_FILES_DIR}"/nvim "${NVIM_CONFIG_DIR}" 
			
EOF
# ------- END USER CALLING SUDO -------
}


# ------- TMUX SETTINGS -------
function tmux_settings () {

# ------- USER CALLING SUDO -------
sudo -E -u "${SUDO_USER}" bash <<EOF
	
	# once installed you may need to source the tmux
	# conf file
	# source ~/.config/tmux/tmux.conf
	# then CTRL + B + I to trigger plugin install

		# if tmux config already exists remove
		# it ready for updates
		if [ -d "${TMUX_CONFIG_DIR}" ]; then
		
			echo "Trying to remove ${TMUX_CONFIG_DIR}"
			rm -rf "${TMUX_CONFIG_DIR}"
		fi
			
		echo "Copying ${DOT_FILES_DIR}/tmux to ${TMUX_CONFIG_DIR}" 
		cp -r "${DOT_FILES_DIR}"/tmux "${TMUX_CONFIG_DIR}"
	
EOF
# ------- END USER CALLING SUDO -------
}


# ------- NERD FONT -------
function install_nerd_fonts () {

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DroidSansMono.zip"
FONT_ZIP="DroidSansMono.zip"
FONT_CACHE="${USER_CACHE}"/fontconfig
FONT_USER="RobotoMono Nerd Font Mono Regular 11"

# ------- USER CALLING SUDO -------
sudo -E -u "${SUDO_USER}" bash <<EOF

		# check if dir exists, if not create it
		# ~/.local/share/fonts/
		
		if [ ! -d "${FONTS_LOCAL_SHARE}" ]; then
			echo "Creating fonts directory ... ${FONTS_LOCAL_SHARE}"
			mkdir -p "${FONTS_LOCAL_SHARE}"
		fi

		if [ ! -d "${FONT_CACHE}" ]; then
			echo "Creating fonts directory ... ${FONT_CACHE}"
			mkdir -p "${FONT_CACHE}"
		fi
	
		# download nerd font zip file
		if ! curl -k -L -o "${FONT_ZIP}" "${FONT_URL}"; then
				echo "Error: Font download failed"
				exit 1
		fi

		if ! unzip -o "${FONT_ZIP}" -d "${FONTS_LOCAL_SHARE}"; then
				echo "Error: Font extraction failed"
				rm -f "$FONT_ZIP"
				exit 1
		fi

		echo "Updating font cache..."
		if command -v fc-cache >/dev/null; then
			FONTCONFIG_PATH="${FONT_CACHE}" XDG_CACHE_HOME="$USER_CACHE" fc-cache -f "${FONTS_LOCAL_SHARE}"
		fi

		if [ -e "${FONT_ZIP}" ]; then
			rm "${FONT_ZIP}"
		fi
		
		echo "DroidSansMono Nerd Font installed: ${FONTS_LOCAL_SHARE}"
	
		# set the terminal font to use a nerd font with included
		# glyphs for neovim.
		dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-system-font false
		dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font "${FONT_USER}"
		echo "Terminal font has been set to ${FONT_USER}"

EOF
# ------- END USER CALLING SUDO -------
}



##########################
# 				MAIN
##########################

# -- SUDO PERMISSIONS

install_toolchains

# -- USER PERMISSIONS

tmux_settings
neovim_settings
install_nerd_fonts
