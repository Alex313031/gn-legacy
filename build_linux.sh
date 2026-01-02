#!/bin/bash

# Copyright (c) 2025 Alex313031.

export HERE=${PWD}

${HERE}/gn gen ${HERE}/out/Debug &&

${HERE}/ninja -C ${HERE}/out/Debug -t clean &&

${HERE}/ninja -C ${HERE}/out/Debug all -v -d stats -j8 $@
