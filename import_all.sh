#!/usr/bin/env bash
find . -name "*.json" -exec ctm-import-backup --force -c replace -f {} \;
