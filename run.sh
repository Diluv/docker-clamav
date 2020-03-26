#!/bin/sh
set -m

# Fetch latest data
freshclam

freshclam -d &
clamd