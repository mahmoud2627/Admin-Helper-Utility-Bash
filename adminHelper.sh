#!/bin/bash

# Function to add a user
add_user() {
    read -p "Enter the username to add: " username
    sudo adduser "$username" && echo "Username added successfully"
    read -p "Press Enter to return to the menu..."
}

# Function to modify a user
modify_user() {
    read -p "Enter the current username to modify: " old_username
    read -p "Enter the new username: " new_username
    sudo usermod -l "$new_username" "$old_username" && echo "Username modified successfully"

    # Rename home directory with the new username
    read -p "Do you want to rename the user's home directory? (y/n): " rename_home
    if [[ "$rename_home" == "y" ]]; then
        old_home_dir="/home/$old_username"
        new_home_dir="/home/$new_username"
        sudo usermod -d "$new_home_dir" -m "$new_username" && echo "Home directory renamed successfully"
    fi

    read -p "Press Enter to return to the menu..."
}

# Function to delete a user
delete_user() {
    read -p "Enter the username to delete: " username
    sudo userdel "$username" && echo "User deleted successfully"
    read -p "Press Enter to return to the menu..."
}

# Function to list all users
list_users() {
    cut -d: -f1 /etc/passwd
    read -p "Press Enter to return to the menu..."
}

# Function to list user details
list_user_details() {
    read -p "Enter the username to view details: " username

    # Basic user information
    echo "Login: $username"
    getent passwd "$username" | awk -F: '{print "Name:", $5}'
    getent passwd "$username" | awk -F: '{print "Directory:", $6}'
    getent passwd "$username" | awk -F: '{print "Shell:", $7}'

    # Last login information
    last -n 1 "$username"
    # Password information
    sudo chage -l "$username"
    read -p "Press Enter to return to the menu..."
}

# Function to add a group
add_group() {
    read -p "Enter the group name to add: " groupname
    sudo groupadd "$groupname" && echo "Group added successfully"
    read -p "Press Enter to return to the menu..."
}

# Function to modify a group
modify_group() {
    read -p "Enter the current group name to modify: " old_groupname
    read -p "Enter the new group name: " new_groupname
    sudo groupmod -n "$new_groupname" "$old_groupname" && echo "Group modified successfully"
    read -p "Press Enter to return to the menu..."
}

# Function to delete a group
delete_group() {
    read -p "Enter the group name to delete: " groupname
    sudo groupdel "$groupname" && echo "Group Deleted successfully"
    read -p "Press Enter to return to the menu..."
}

# Function to list all groups
list_groups() {
    cut -d: -f1 /etc/group
    read -p "Press Enter to return to the menu..."
}

# Function to disable a user (lock account)
disable_user() {
    read -p "Enter the username to disable: " username
    sudo passwd -l "$username" && echo "User disabled successfully"
    read -p "Press Enter to return to the menu..."
}

# Function to enable a user (unlock account)
enable_user() {
    read -p "Enter the username to enable: " username
    sudo passwd -u "$username" && echo "User enabled successfully"
    read -p "Press Enter to return to the menu..."
}

# Function to change user password
change_password() {
    read -p "Enter the username to change password: " username
    sudo passwd "$username" && echo "Password changed successfully"
    read -p "Press Enter to return to the menu..."
}

# Function to display about information
about() {
    echo "This is an Admin Helper program written in Bash Created by Mohamed Fayez."
    read -p "Press Enter to return to the menu..."
}

# Main menu
while true; do
    echo "Main Menu"
    PS3="Please select an option: "
    options=("Add User" "Modify User" "Delete User" "List Users" "List User Details" "Add Group" "Modify Group" "Delete Group" "List Groups" "Disable User" "Enable User" "Change Password" "About" "Exit")
    select opt in "${options[@]}"; do
        case $REPLY in
            1) add_user; break ;;
            2) modify_user; break ;;
            3) delete_user; break ;;
            4) list_users; break ;;
            5) list_user_details; break ;;
            6) add_group; break ;;
            7) modify_group; break ;;
            8) delete_group; break ;;
            9) list_groups; break ;;
            10) disable_user; break ;;
            11) enable_user; break ;;
            12) change_password; break ;;
            13) about; break ;;
            14) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid option. Please try again."; break ;;
        esac
    done
    echo
done
