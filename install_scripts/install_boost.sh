#!/bin/bash

BOOST_SRC=/src/boost
BOOST_DIR=/opt

mkdir -p $BOOST_SRC \
	&& curl -o $BOOST_SRC/boost.tar.gz -L https://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz/download \
	&& tar --gz -C $BOOST_DIR -xf $BOOST_SRC/boost.tar.gz

export BOOST_ROOT=$BOOST_DIR/boost_1_55_0
