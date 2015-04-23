#!/usr/bin/env bash
find . -name "*.json" -exec ccl-import-backup --force -c replace -f {} \;
