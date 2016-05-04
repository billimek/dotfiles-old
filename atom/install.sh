#!/bin/sh
echo "  Installing atom packages"
apm install -v --packages-file ~/.atom/packages.list

#apm list --installed --bare > ~/.atom/packages.list or
#apm star --installed
#apm stars --install
