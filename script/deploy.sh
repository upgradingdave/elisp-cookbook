#!/bin/bash

emacs -Q -L ./ -batch -l script/deploy.el -f deploy
