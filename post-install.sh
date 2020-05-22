#!/bin/bash

cp /etc/skel/.bashrc /root/
echo "export PATH=\$PATH:/usr/lib/node_modules/aws-cdk/bin/" >> /root/.bashrc
bash
