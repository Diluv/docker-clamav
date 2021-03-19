#!/bin/sh
set -m

freshclam

freshclam -d &
clamd