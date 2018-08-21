#! /bin/bash

export ARCH_DIR=output/$1
export INSTALL_DIR=assets/$1

cp $ARCH_DIR/* $INSTALL_DIR/

rm -f $INSTALL_DIR/assets.txt; for f in $(ls $INSTALL_DIR); do echo "$f $(date +%s -r $INSTALL_DIR/$f)" >> $INSTALL_DIR/assets.txt; done
