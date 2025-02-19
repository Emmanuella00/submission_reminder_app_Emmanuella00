#!/bin/bash

#Enter your username to create a directory
read -p "Enter your name: " username
mkdir -p "submission_reminder_$username"
cd "submission_reminder_$username"
 

#creating subdirectories and their files
#creating subdirectory app and its file reminder.sh

mkdir -p app
cat > app/reminder.sh << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ../config/config.env
source ../modules/functions.sh

# Path to the submissions file
submissions_file="../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

#make the file executable
chmod +x app/reminder.sh


#creating my modules subdirectory and its file functions.sh

mkdir -p modules
cat > modules/functions.sh << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

#making the file executable
chmod +x modules/functions.sh


#creating my assets subdirectory and its file  submissions.txt
mkdir -p assets
cat > assets/submissions.txt << 'EOF'
Student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Emmanuella, Shell Permissions, submitted
jacky, Shell Basics, submitted
ocean, Git, submitted
Davina, shell navigation, submitted
kevinne, Shell Basics, not submitted
EOF

#making the file executable
chmod +x assets/submissions.txt

#creating my config subdirectory and its  file config.env
mkdir -p config
cat > config/config.env << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

#making the file executable
chmod +x config/config.env



#create the startup.sh file
cat > startup.sh << 'EOF'
#!/bin/bash
cd app
./reminder.sh
EOF

chmod +x startup.sh

echo "Environment successfully setup"
