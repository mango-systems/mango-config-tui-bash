#!/bin/bash

distro_upgrade(){
    # https://jumpcloud.com/blog/how-to-upgrade-ubuntu-20-04-to-ubuntu-22-04
    echo -e "\nDistro upgrade:\n"
    echo -e "Prerequisites:\n-Atleast 20GB of Free Space\nRecommended:\n-Connect your device to a Power Source\n-Close all other application\n-Backup all your data"
    # use gnome terminal to pass sudo privillage, do not initiate sudo in this script
    ## INCOMPLETE
}

main_screen() {
    clear
    figlet "Mango Linux"
    echo -e "Mango Linux Configurator \n"
    echo -e "Welcome to mango linux configurator. \n(shell script version) \n"

    # echo -e ""

    # "This tool is not affiliated with or endorsed by any third-party open-source applications it may interact with. 
    # Use of these applications is subject to their respective terms of use and privacy policies. 
    # The developer of this tool bears no responsibility for any damages or issues that may arise 
    # from the use of these third-party applications."

    # \n\n\n

    # add a first time setup to install flatpak dependencies and apt dependencies, with confirmation

    echo "Select to Manage/Configure:"
    configure_action=$(gum choose "Manage Apps and Pkgs" "Add-ons" "Boot-config" "Tweaks" "System Tools" "Disk Management" "Connectivity and Wifi Hotspot" \
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
                    distro_upgrade &
                    main_screen
                ;;
                "Go Back")
                    main_screen
                ;;
            esac
        ;;
        "Disk Management")
        ;;
        "Connectivity and Wifi Hotspot")
        ;;
        "Common Config Files")
        ;;
        "Install Proprietary software and Codecs")
        ;;
        "Optimise GS-connect")
        ;;
        "exit")
            clear
            echo -e "\nThanks for using Mango-Configurator\n"
            exit
        ;;
    esac
}

# _main_
main_screen