#!/bin/bash

for i in {1..100}; do
    lscpu | grep 'CPU MHz'
    sleep 0.2
done
