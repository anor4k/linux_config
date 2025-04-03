#!/bin/bash

# Define your activity UUIDs (get them using the qdbus command above)
WORK_UUID="de6e026f-52d6-4f99-8f1c-8ebb151e6e51"
PERSONAL_UUID="5245d0b9-b49d-4fe0-9494-04d920db2ec0"

# Get the current activity
CURRENT_UUID=$(qdbus org.kde.ActivityManager /ActivityManager/Activities CurrentActivity)

# Choose profile based on activity
if [ "$CURRENT_UUID" = "$WORK_UUID" ]; then
    PROFILE="Uncover"
else
    PROFILE="default"
fi

# Launch Firefox with the correct profile
firefox-developer-edition -P "$PROFILE" --new-tab "$1"
