#!/bin/bash

# BOOKMARKS
# - https://misc.flogisoft.com/bash/tip_colors_and_formatting

distro_upgrade_cli_way(){
    # UNUSED!, for preffered update-manager

    # https://jumpcloud.com/blog/how-to-upgrade-ubuntu-20-04-to-ubuntu-22-04
    
    gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Distro Upgrade Utility' 'So sweet and so fresh!'

    echo -e "\nDistro upgrade:\n"
    echo -e "Prerequisites:\n-Atleast 20GB of Free Space\nRecommended:\n-Connect your device to a Power Source\n-Close all other application\n-Backup all your data"
    # use gnome terminal to pass sudo privillage, do not initiate sudo in this script
    ## INCOMPLETE
    $confirmation
    gum confirm "Continue? This may make your system unstable" && confirmation=true || main_screen
    # echo $confirmation
    if [[ $confirmation == "true" ]]; then
        gnome-terminal -e "bash -c ' \
        sudo apt update \
        sudo apt install update-manager-core -y \
        sudo do-release-upgrade -d \
        sudo apt autoremove --purge \
        ; exec bash'" > /dev/null;
    fi
    clear
    main_screen

}

distro_upgrade(){
    update-manager --check-dist-upgrades & main_screen
}

main_screen() {
    clear
    # figlet "Mango Linux"
    # echo -e "Mango Linux Configurator \n"
    # echo -e "\033[47m\033[30m 🥭 Mango Linux Configurator \033[0m\n"
    # printf "\033[38;2;204;204;255m Mango Linux Configurator \033[0m\n"
    # printf "\033[38;2;255;255;255;48;2;227;182;44mMango Linux Configurator\033[0m\n"
    # printf "\n\033[38;2;0;0;0;48;2;227;182;44m 🥭 Mango Linux Configurator 🥭 \033[0m\n\n"
    # printf "\n\033[38;2;255;255;255;48;2;242;144;24m Mango Linux Configurator \033[0m\n\n"
    printf "\n 🥭 \033[38;2;0;0;0;48;2;242;144;24m Mango Linux Configurator \033[0m 🥭\n\n"





    echo -e "Welcome to \e[1mmango linux configurator. \n\e[0m(shell script version) \n"

    # echo -e ""

## maybe include it in the first run setup
echo -e "\e[2mThis tool is not affiliated with or endorsed by any third-party open-source applications \
it may interact with. Use of these applications is subject to their respective terms of \
use and privacy policies. The developer of this tool bears no responsibility for any damages or issues that may \
arise from the use of these third-party applications.\n" | fold -s

    # add a first time setup to install flatpak dependencies and apt dependencies, with confirmation

    echo -e "\e[1mSelect to Manage/Configure:"
    configure_action=$(gum choose  --height 9  --cursor.foreground="#e3b62c" --item.foreground="#d9d9d9" "Manage Apps and Pkgs" \
    "Add-ons" "Boot-config" "Tweaks" "System Tools" "Setup Windows Subsystem" "Setup Android Subsystem" "Optimise for Gaming"\
    "Disk Management" "Connectivity and Wifi Hotspot" \
    "Common Config Files" "Install Proprietary software and Codecs" "Optimise GS-connect" "exit")

    case $configure_action in
        "Manage Apps and Pkgs")
            echo "Manage Apps:"
            manage_apps=$(gum choose "GNOME Store" "Synaptic Package Manager" "Flatseal" "Go Back")

            case $manage_apps in 
                "GNOME Store")
                    gnome-software &
                    main_screen
                ;;
                "Synaptic Package Manager and Pkgs")
                    nohup pkexec synaptic &
                    main_screen
                ;;
                "Flatseal")
                    nohup flatpak run com.github.tchx84.Flatseal > /dev/null &
                    main_screen
                ;;        
                "Go Back")
                    main_screen
                ;;
                # add third-party opensource projects such as Gnome-adwaita firefox theme
            esac
        ;;
        "Add-ons")
            echo "Manage Add-ons"
            addon_action=$(gum choose "Extension Manager" "Gnome Extensions" "Go Back")

            case $addon_action in
                "Extension Manager")
                    nohup flatpak run com.mattjakeman.ExtensionManager > /dev/null &
                    main_screen
                ;;
                "Gnome Extension")
                    nohup flatpak run org.gnome.Extensions > /dev/null &
                    main_screen
                ;;
                "Go Back")
                    main_screen
                ;;
            esac
        ;;
        "Boot-config")
            echo "Manage Boot Config:"
            boot_config=$(gum choose "Grub Customizer" "Go Back")

            case $boot_config in
                "Grub Customizer")
                    nohup pkexec grub-customizer > /dev/null &
                    main_screen
                ;;
                "Go Back")
                    main_screen
                ;;
            esac
        ;;
        "Tweaks")
            echo "Configure Tweaks:"
            tweaks=$(gum choose "GNOME Tweaks" "Gradience" "Go Back")

            case $tweaks in
                "GNOME Tweaks")
                    gnome-tweaks &
                    main_screen
                ;;
                "Gradience")
                    nohup flatpak run com.github.GradienceTeam.Gradience > /dev/null &
                    main_screen
                ;;
                "Go Back")
                    main_screen
                ;;
            esac
        ;;
        "System Tools")
            echo "Manage System Tools"
            system_action=$(gum choose "Manage Firmware" "PulseAudio Volume" "Additional Driver" "Stacer" "System Monitoring Center" "Distro Upgrade" "Go Back")

            case $system_action in
                "Manage Firmware")
                    nohup flatpak run org.gnome.Firmware > /dev/null &
                    main_screen
                ;;
                "PulseAudio Volume")
                    nohup flatpak run org.pulseaudio.pavucontrol > /dev/null &
                    main_screen
                ;;
                "Additional Driver")
                    nohup software-properties-gtk --open-tab=4 &
                    main_screen 
                ;;
                "System Monitoring Center")
                ;;
                "Distro Upgrade")
                    distro_upgrade
                ;;
                "Go Back")
                    main_screen
                ;;
            esac
        ;;
        "Disk Management")
            echo "Select Disk Management utility"
            disk_manage=$(gum choose "GNOME Disks" "Go Back")
            case $disk_manage in
                "GNOME Disks")
                    gnome-disks &
                    main_screen
                ;;
                "Go Back")
                    main_screen
                ;;
            esac
        ;;
        "Connectivity and Wifi Hotspot")
            echo "Select to Manage Connectivity setting and Wifi Hotspot"
            network_manage=$(gum choose "Blueman" "WiFi Hotspot" "Go Back")
            case $network_manage in
                "Blueman")
                    blueman-manager &
                    main_screen
                ;;
                "WiFi Hotspot")
                    nohup wihotspot &
                    main_screen
                ;;
                "Go Back")
                    main_screen
                ;;
            esac
        ;;
        "Common Config Files")
        ;;
        "Install Proprietary software and Codecs")
        ;;
        "Optimise GS-connect")
            echo "Manage and Optimise GS Connect:"
            gs_connect=$(gum choose "GS-Connect Settings" "Optimise GS-Connect on Android - Blog Post" "Go Back")
            case $gs_connect in
                "GS-Connect Settings")
                    gnome-extensions prefs gsconnect@andyholmes.github.io > /dev/null &
                    main_screen
                ;;
                "Optimise GS-Connect on Android - Blog Post")
                    xdg-open "https://google.com" #enter blog post later
                ;;
                "Go Back")
                    main_screen
                ;;
            esac
        ;;
        "Setup Win"*)
            echo "WINDOWS"
        ;;
        "Setup Android"*)
            echo "Android subsystem"
        ;;
        *"Gaming")
            echo "Gaming"
        ;;
        "exit")
            clear
            echo -e "\nThanks for using Mango-Configurator\n"
            exit
        ;;
    esac
}

# _main_

# add a conditional for first time run config

main_screen

