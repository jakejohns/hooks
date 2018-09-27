#!/bin/bash

hook_src="https://raw.githubusercontent.com/jakejohns/hooks/master/post-receive"


hook="./git/hooks/post-receive"

mkdir ./{git,staging,production}
git init --bare ./git
rm ./git/hooks/*
wget -O "$hook" "$hook_src"
chmod +x "$hook"
