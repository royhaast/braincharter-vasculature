#!/bin/bash

BRAINCHARTER_SRC=/src/braincharter
BRAINCHARTER_DIR=/opt/braincharter

git clone https://github.com/braincharter/vasculature.git $BRAINCHARTER_DIR \
	&& mkdir $BRAINCHARTER_SRC \
	&& cd $BRAINCHARTER_SRC \
	&& cmake $BRAINCHARTER_DIR/cplusplus_frangi_iter \
	&& make -j4

cp $BRAINCHARTER_SRC/itkVEDMain $BRAINCHARTER_DIR/itkVEDMain

export PATH=$BRAINCHARTER_DIR:/$PATH
