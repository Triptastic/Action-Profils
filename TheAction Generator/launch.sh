#!/usr/bin/env bash

python -m actiongenerator -p $(ls profiles/DungeonSlice/*.simc)
python -m actiongenerator -p $(ls profiles/Tier25/*.simc)
python -m actiongenerator -p $(ls profiles/Tier26/*.simc)