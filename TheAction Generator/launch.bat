@echo off
for %%v in (profiles\DungeonSlice\*.simc) do python -m actiongenerator -p %%v
for %%v in (profiles\Tier25\*.simc) do python -m actiongenerator -p %%v
for %%v in (profiles\Tier26\*.simc) do python -m actiongenerator -p %%v
for %%v in (profiles\PRShadow\*.simc) do python -m actiongenerator -p %%v
