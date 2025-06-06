#!/bin/bash

# Error handling function
fail() {
    echo "ERROR: $1" >&2
    exit 1
}

# Function to analyze a specific log file
analyze_log() {
    local log_type=$1
    local log_file="hospital_data/active_logs/${log_type}.log"
    local report_file="hospital_data/reports/analysis_report.txt"
    
    # Check if log file exists
    [ -f "$log_file" ] || fail "Log file $log_file not found"
    
    # Create reports directory if it doesn't exist
    mkdir -p "reports" || fail "Cannot create reports directory"
    
    # Get current timestamp for report
    local analysis_time=$(date +"%Y-%m-%d %H:%M:%S")
    
    echo "Analyzing $log_file..."
    
    # Check if log file has data
    if [ ! -s "$log_file" ]; then
        echo "Warning: Log file $log_file is empty"
        echo "=== Analysis Report - $analysis_time ===" >> "$report_file"
        echo "Log Type: $log_type" >> "$report_file"
        echo "Status: No data available" >> "$report_file"
        echo "" >> "$report_file"
        return
    fi
    
    # Write report header
    echo "=== Analysis Report - $analysis_time ===" >> "$report_file"
    echo "Log Type: $log_type" >> "$report_file"
    echo "" >> "$report_file"
    
    # Count occurrences of each device and get first/last timestamps
    echo "Device Statistics:" >> "$report_file"
    
    # Extract unique devices from the log file
    devices=$(awk '{print $3}' "$log_file" | sort | uniq)
    
    for device in $devices; do
        # Count total occurrences
        count=$(grep -c "$device" "$log_file")
        
        # Get first occurrence timestamp
        first_entry=$(grep "$device" "$log_file" | head -1 | awk '{print $1, $2}')
        
        # Get last occurrence timestamp  
        last_entry=$(grep "$device" "$log_file" | tail -1 | awk '{print $1, $2}')
        
        # Write to report
        echo "  Device: $device" >> "$report_file"
        echo "    Total Entries: $count" >> "$report_file"
        echo "    First Entry: $first_entry" >> "$report_file"
        echo "    Last Entry: $last_entry" >> "$report_file"
        echo "" >> "$report_file"
    done
    
    # Add summary statistics
    total_entries=$(wc -l < "$log_file")
    unique_devices=$(echo "$devices" | wc -w)
    
    echo "Summary:" >> "$report_file"
    echo "  Total Entries: $total_entries" >> "$report_file"
    echo "  Unique Devices: $unique_devices" >> "$report_file"
    echo "  Analysis Date: $analysis_time" >> "$report_file"
    echo "========================================" >> "$report_file"
    echo "" >> "$report_file"
    
    echo "Analysis complete! Results appended to $report_file"
}

# Main menu
echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
read -p "Enter choice (1-3): " choice

# Validate input and call analysis function
case $choice in
    1) analyze_log "heart_rate" ;;
    2) analyze_log "temperature" ;;
    3) analyze_log "water_usage" ;;
    *) echo "Invalid choice. Please enter 1, 2, or 3."; exit 1 ;;
esac
