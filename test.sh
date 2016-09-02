#!/bin/bash
DIR=$( dirname "$0" )
prove -I$DIR/lib $DIR/t || prove -v -I$DIR/lib $DIR/t
