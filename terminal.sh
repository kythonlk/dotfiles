#!/bin/bash

sudo apt install curl

# Select the Nerd Font from https://www.nerdfonts.com/font-downloads
# Testing with ShellCheck

echo "[-] Download The Nerd fonts [-]"
echo "#######################"
echo "Select Nerd Font"
fons_list=("Agave" "AnonymousPro" "Arimo" "AurulentSansMono" "BigBlueTerminal" "BitstreamVeraSansMono" "CascadiaCode" "CodeNewRoman" "ComicShannsMono" "Cousine" "DaddyTimeMono" "DejaVuSansMono" "FantasqueSansMono" "FiraCode" "FiraMono" "Gohu" "Go-Mono" "Hack" "Hasklig" "HeavyData" "Hermit" "iA-Writer" "IBMPlexMono" "InconsolataGo" "InconsolataLGC" "Inconsolata" "IosevkaTerm" "JetBrainsMono" "Lekton" "LiberationMono" "Lilex" "Meslo" "Monofur" "Monoid" "Mononoki" "MPlus" "NerdFontsSymbolsOnly" "Noto" "OpenDyslexic" "Overpass" "ProFont" "ProggyClean" "RobotoMono" "ShareTechMono" "SourceCodePro" "SpaceMono" "Terminus" "Tinos" "UbuntuMono" "Ubuntu" "VictorMono")
PS3="Enter a number: "
select font_name in "${fons_list[@]}" "Quit"; do

	if [ -n "$font_name" ]; then

		echo "Starting download $font_name nerd font"

		if [ "$(command -v curl)" ]; then
			echo "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font_name.zip"
			curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font_name.zip"
			echo "creating fonts folder: ${HOME}/.fonts"
			mkdir -p "$HOME/.fonts"
			echo "unzip the $font_name.zip"
			unzip "$font_name.zip" -d "$HOME/.fonts/$font_name/"
			fc-cache -fv
			echo "done!"
			break

		elif [ "$(command -v wget)" ]; then
			echo "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font_name.zip"
			wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font_name.zip"
			echo "creating fonts folder: ${HOME}/.fonts"
			mkdir -p "$HOME/.fonts"
			echo "unzip the $font_name.zip"
			unzip "$font_name.zip" -d "$HOME/.fonts/$font_name/"
			fc-cache -fv
			echo "done!"
			break

		else

			echo "We cannot find the curl and wget command. First, install the curl and wget command, one of them."
			break

		fi

	else

		echo "Select the vaild $font_name nerd Font, just type number"
		continue

	fi
done

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo apt update

ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

KCF=~/.config/kitty/kitty.conf

echo "# background" >>$KCF
echo "" >>$KCF
echo "background_opacity 0.76" >>$KCF
echo "draw_minimal_borders yes" >>$KCF
echo "window_padding_width 2" >>$KCF
echo "window_border_width 0" >>$KCF
echo "hide_window_decorations yes" >>$KCF
echo "titlebar-only yes" >>$KCF
echo "active_border_color none" >>$KCF
echo "" >>$KCF
echo "" >>$KCF
echo "# top nav" >>$KCF
echo "tab_bar_edge top" >>$KCF
echo "tab_bar_background none" >>$KCF
echo "tab_bar_style powerline" >>$KCF
echo "tab_powerline_style slanted" >>$KCF
echo "tab_title_template \"{fmt.fg.c2c2c2}{title}\"" >>$KCF
echo "active_tab_title_template \"{fmt.fg._fff}{title}\"" >>$KCF
echo "active_tab_foreground #fff" >>$KCF
echo "active_tab_font_style bold-italic" >>$KCF
echo "active_tab_background #8631B4" >>$KCF
echo "inactive_tab_foreground #c2c2c2" >>$KCF
echo "inactive_tab_background #8631B4" >>$KCF
echo "map ctrl+n new_tab" >>$KCF
echo "map ctrl+left previous_tab" >>$KCF
echo "map ctrl+right next_tab" >>$KCF
echo "mouse_map ctrl+left click ungrabbed mouse_handle_click link" >>$KCF


sudo apt update
curl -sS https://starship.rs/install.sh | sh

echo "eval "$(starship init bash)"" >>~/.bashrc
source ~/.bashrc
