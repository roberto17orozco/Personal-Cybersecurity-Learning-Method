# I.- Threat Intelligente Auto Updater

## 1.- Project purpose.
This project delivers an internal SOC tool designed to automatically collect, standardize, and update Indicators of Compromise (IOCs) from trusted threat‑intelligence sources such as OTX, MalwareBazaar, and ThreatFox. Its purpose is to maintain continuously refreshed threat data that can be fed directly into SIEM and IDS platforms, enhancing early detection capabilities while reducing the manual workload for analysts. `

## 2. Project structure

Before starting writing code, make sure the project has a functional structure, like this one:
```text  
Threat_Intelligence_Auto_Updater/
│
├── src/
│   ├── main.py
│   ├── config.py
│   │
│   ├── fetchers/
│   │   ├── otx_fetcher.py
│   │   ├── malwarebazaar_fetcher.py
│   │   ├── threatfox_fetcher.py
│   │   └── __init__.py
│   │
│   ├── normalizers/
│   │   ├── normalize_otx.py
│   │   ├── normalize_malwarebazaar.py
│   │   ├── normalize_threatfox.py
│   │   └── __init__.py
│   │
│   └── utils/
│       ├── file_writer.py
│       ├── logger.py
│       └── __init__.py
│
├── data/
│   ├── raw/          ← generated automatically (raw JSON)
│   └── processed/    ← generated automatically (normalized CSV/JSON)
│
├── logs/             ← generated automatically (updater.log)
│
├── tests/
│   ├── test_otx_fetcher.py
│   ├── test_normalizer.py
│   └── test_file_writer.py
│
├── README.md
└── requirements.txt
```



### 2.1.- src/ - Source Code
This directory contains all the core logic of the project.
It includes the main execution script, configuration settings, API fetchers, data normalizers, and utility modules.
Evetything that defines how the tool works internally lives here.
- fetcher: a fetcher is a component that downloads raw data from an external source. In the context of this project a fetcher is a module responsible for retrieving raw threat-intelligence data from an external API.
- normalizer: a normalizer is a component that cleans and restructures raw data into a consistent format. In the context of this project a normalizer is a module that transforms raw API data into a unified IOC format.

### 2.2.- data/ - Input and Output Data
This folder stores all **IOC** data handled by the tool.
- data/raw/: Contains raw JSON files downloaded directly from threat-intelligence APIs. These files are generated **automatically** when the fetcher modules run.

- data/processed/: Contains normalized **IOC** datasets in **CSV** and **JSON** formats. These file are also generated automatically after the normalization stage.

### 2.3.- logs/ - Execution Logs
This directory stores the application's log file (updater.log).
It records execution details, errors, API responses, and general runtime information.
Useful for debugging, auditing, and monitoring the tool's behavior.

### 2.4.- tests/ - Unit Tests
This folder contains test scripts for validating the functionality of fetchers, normalizers, and utility modules.
It ensures that each component behaves correctly and helps maintain code reliability as the project grows.
