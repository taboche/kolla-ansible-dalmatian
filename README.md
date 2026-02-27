#!/bin/bash

if [ "$2" = "prepare" ] && [ "$3" = "begin" ]; then
    xml=$(cat)
    echo "$xml" | sed "/<\/domain>/i\
  <qemu:commandline>\
    <qemu:arg value='-fw_cfg'/>\
    <qemu:arg value='name=opt/ovmf/X-PciMmio64Mb,string=131072'/>\
  </qemu:commandline>"
else
    cat
fi