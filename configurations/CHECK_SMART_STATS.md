# Check SMART Stats

HDDs and SSDs have SMART stats to give insights into the health of the drive. I used [Smartmontools](https://help.ubuntu.com/community/Smartmontools) to run drive diagnostics and view the stats.

1. Install - `sudo apt-get install smartmontools`
2. Check drive for compatibility - `sudo smartctl -i /dev/sda`

- Replace `/dev/sda` with the path to whatever drive you are looking to check
- If SMART is available but needs enabled - `sudo smartctl -s on /dev/sda`

3. Run extended test - `sudo smartctl -t long /dev/sda`
4. View test stats - `sudo smartctl -l selftest /dev/sda`
