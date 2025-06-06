# Hospital Monitoring System - Group 1

## Setup
```bash
# 1. Clone repository
git clone https://github.com/Christian-pprogrammer/Coding-lab_Group1.git
cd Coding-lab_Group1

# 2. Create directory structure
mkdir -p hospital_data/{active_logs,archived_logs,reports}

# 3. Make scripts executable
chmod +x archive_logs.sh analyze_logs.sh

## Running the system

# Terminal 1 - Heart Rate
python3 heart_rate_monitor.py start

# Terminal 2 - Temperature
python3 temperature_recorder.py start

# Terminal 3 - Water Usage
python3 water_consumption.py start

# Run the archive script and select the option of your choice
./archive_logs.sh

# Run the analyze script and select the option of your choice as well
./analyze_logs.sh

# Check the reports after analysis
cat hospital_data/reports/analysis_report.txt

# View active logs
tail -f hospital_data/active_logs/heart_rate.log

```

## Group Members
- SONIA KEZA (s.keza1@alustudent.com)  
- Darlene Ayinkamiye (d.ayinkamiy@alustudent.com)  
- Abatoni Mugabo Lea (I.abatoni@alustudent.com)  
- Christian MPANO (c.mpano1@alustudent.com)  
- Waliyat Badmus (w.badmus@alustudent.com)
