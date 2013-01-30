#!/bin/bash

emacs -L ./ -batch -l ert -l test/cookbook-tests.el -f ert-run-tests-batch-and-exit

