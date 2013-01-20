#!/bin/sh

cd ~/.vim/bundle/Command-T/ruby/command-t
ruby ./extconf.rb && make clean && make
cd -
