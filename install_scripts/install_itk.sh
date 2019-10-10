#!/bin/bash

ITK_SRC=/src/itk
ITK_DIR=/opt/itk

mkdir -p $ITK_SRC \
	&& curl -L https://sourceforge.net/projects/itk/files/itk/4.9/InsightToolkit-4.9.1.tar.gz/download \
	| tar xz -C $ITK_SRC --strip-components 1 \
	&& mkdir -p $ITK_DIR \
	&& cd $ITK_DIR \
	&& cmake $ITK_SRC \
	&& make -j4 \
	&& make install

export ITK_DIR=$ITK_DIR
