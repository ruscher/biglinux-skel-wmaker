#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="~/.config/polybar/material/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Options
shutdown=" Desligar"
reboot=" Reiniciar"
# lock=" Bloquear"
# suspend=" Suspender"
logout=" Encerrar sessão"

# Confirmation
confirm_exit() {
	rofi -dmenu\
        -no-config\
		-i\
		-no-fixed-num-lines\
		-p "Tem certeza? : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -no-config -theme "$dir/message.rasi" -e "Opções disponíveis  -  yes / y / no / n"
}

# Variable passed to rofi
options="$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Tempo de atividade: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
		shutdown now
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			shutdown now
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $reboot)
		reboot
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			reboot
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
#     $lock)
# 		if [[ -f /usr/bin/i3lock ]]; then
# 			i3lock
# 		elif [[ -f /usr/bin/betterlockscreen ]]; then
# 			betterlockscreen -l
# 		fi
#         ;;
#     $suspend)
# 		ans=$(confirm_exit &)
# 		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
# 			mpc -q pause
# 			amixer set Master mute
# 			systemctl suspend
# 		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
# 			exit 0
#         else
# 			msg
#         fi
#         ;;
    $logout)
		pkill -KILL -u $USER
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			elif [[ "$DESKTOP_SESSION" == "wmaker" ]]; then
				pkill -KILL -u $USER
			fi
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
esac
