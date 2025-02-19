#!/bin/bash

# Step 1: Ask for user's name
read -p "Enter your name:" $username

# Step 2: Create the main directory
main_dir="submission_reminder_${userName}"
mkdir -p "$main_dir"

# Step 3: Create the required subdirectories
mkdir -p "$main_dir/config"
mkdir -p "$main_dir/scripts"
mkdir -p "$main_dir/data"

# Step 4: Create the required files
touch "$main_dir/config/config.env"
touch "$main_dir/scripts/reminder.sh"
touch "$main_dir/scripts/functions.sh"
touch "$main_dir/scripts/startup.sh"
touch "$main_dir/data/submissions.txt"

# Step 5: Make startup.sh executable
chmod +x "$main_dir/scripts/startup.sh"

# Step 6: Print success message
echo "Environment setup complete! The directory structure has been created inside $main_dir." 
