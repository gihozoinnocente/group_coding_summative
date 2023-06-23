#!/usr/bin/env bash
# Creates shell script to back up the directory in part a
host="a0dfc11ba139.a982e858.alu-cod.online"
user="a0dfc11ba139"
pwd="899c79fc532cd0591af1"
source="0323-RW-SOFEN-8120120-5_q1"
dstn="/home/sftp-student/03033/summative"
sshpass -p $pwd scp -r $source $user@$host:$dstn
