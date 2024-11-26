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
DOT_FILES_DIR="${USER_CONFIG_DIR}"/dot-files
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
fontconfig \

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


function download_extract() {
  URL=$1
  OUTPUT_FILE=$2
  OUTPUT_DIR=$3

  if ! curl -k -L -o "${OUTPUT_FILE}" "${URL}"; then
      echo "Error: download failed"
      exit 1
  fi

  mkdir -p "${OUTPUT_DIR}"

  if ! unzip -o "${OUTPUT_FILE}" -d "${OUTPUT_DIR}"; then
      echo "Error: Font extraction failed"
      rm -f "$OUTPUT_FILE"
      exit 1
  fi

  if [ -e "${OUTPUT_FILE}" ]; then
    rm -f "$OUTPUT_FILE"
  fi
}

# ------- NERD FONT -------
function install_nerd_fonts () {

FONT_SIZE="11"
SANS_FONT_NAME="RobotoMono Nerd Font Propo"
MONO_FONT_NAME="RobotoMono Nerd Font"

FONT_ZIP="RobotoMono.zip"
FONT_ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip"
FONT_DIR="/usr/share/fonts/truetype/roboto-mono-nerd"

CONFIG_FILE="/etc/fonts/conf.d/99-roboto-nerd-fonts.conf"

# Define Fontconfig XML configuration as a variable
FONTCONFIG_XML="<?xml version=\"1.0\"?>
<!DOCTYPE fontconfig SYSTEM \"fonts.dtd\">
<fontconfig>
  <!-- Set Roboto Nerd Font as the default sans-serif font -->
  <match target=\"pattern\">
    <test qual=\"any\" name=\"family\">
      <string>sans-serif</string>
    </test>
    <edit name=\"family\" mode=\"assign\" binding=\"strong\">
      <string>${SANS_FONT_NAME}</string>
    </edit>
    <edit name=\"size\" mode=\"assign\">
      <double>${FONT_SIZE}</double>
    </edit>
  </match>

  <!-- Set Roboto Mono Nerd Font as the default monospace font -->
  <match target=\"pattern\">
    <test qual=\"any\" name=\"family\">
      <string>monospace</string>
    </test>
    <edit name=\"family\" mode=\"assign\" binding=\"strong\">
      <string>${MONO_FONT_NAME}</string>
    </edit>
    <edit name=\"size\" mode=\"assign\">
      <double>${FONT_SIZE}</double>
    </edit>
  </match>
</fontconfig>"

 
  # url, output zip name, output dir
  download_extract "$FONT_ZIP_URL" "$FONT_ZIP" "$FONT_DIR"

  fc-cache -fv > /dev/null


  echo "$FONTCONFIG_XML" | tee "$CONFIG_FILE" > /dev/null

  echo "Sans font set to: $(fc-match sans)"
  echo "Monospace font set to: $(fc-match monospace)"
}



##########################
#    MAIN
##########################

# -- SUDO PERMISSIONS

install_toolchains

# -- USER PERMISSIONS

download_dotfiles
install_nerd_fonts
tmux_settings
neovim_settings
