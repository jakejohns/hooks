#!/usr/bin/env bash

hook_src="https://raw.githubusercontent.com/jakejohns/hooks/master/post-receive"
hook_dest="./git/hooks/post-receive"

mkdir ./{git,staging,production}
git init --bare ./git
rm ./git/hooks/*
wget -O "$hook_dest" "$hook_src"
chmod +x "$hook_dest"
