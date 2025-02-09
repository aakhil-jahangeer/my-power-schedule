# Power Scheduler

This repository provides separate scripts to schedule power-off and power-on events for **Linux** and **Windows** systems.

### Features
- **Linux**: Schedule system shutdown and Wake-on-LAN (WOL).
- **Windows**: Schedule system shutdown and Wake-on-LAN (WOL).

## Prerequisites

### Linux:
- `cron` should be installed and running for scheduling shutdown.
- To use Wake-on-LAN functionality, ensure that your system supports it and that the `wakeonlan` tool is installed:
```bash
sudo apt install wakeonlan
