#!/bin/bash
set -xe

# go build

cp nut_exporter.service /lib/systemd/system/nut_exporter.service
systemctl daemon-reload
systemctl enable nut_exporter
systemctl start nut_exporter.service
systemctl status nut_exporter
