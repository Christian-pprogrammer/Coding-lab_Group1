#!/bin/bash

# Error handling function
fail() {
    echo "ERROR: $1" >&2
    exit 1
}

archive_log() {
    local log_type=$1
    local log_file="hospital_data/active_logs/${log_type}.log"
    local archive_dir="hospital_data/archived_logs/${log_type}_data_archive"
    
    [ -f "$log_file" ] || fail "Log file $log_file not found"
    mkdir -p "$archive_dir" || fail "Cannot create archive directory"
    
    local timestamp=$(date +"%Y-%m-%d_%H:%M:%S")
    mv "$log_file" "${archive_dir}/${log_type}_${timestamp}.log" || fail "Archive failed"
    touch "$log_file" || fail "Cannot recreate log file"
    
    echo "Successfully archived to ${archive_dir}/${log_type}_${timestamp}.log"
}

# Main menu
echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

case $choice in
    1) archive_log "heart_rate" ;;
    2) archive_log "temperature" ;;
    3) archive_log "water_usage" ;;
    *) echo "Invalid choice"; exit 1 ;;
esac


