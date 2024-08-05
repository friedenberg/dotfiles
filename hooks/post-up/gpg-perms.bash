#! /bin/bash -x

chown -R $(whoami) ~/.gnupg/
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg

chown -R $(whoami) ~/.ssh/
chmod 600 ~/.ssh/*
chmod 700 ~/.ssh
