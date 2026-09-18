#!/bin/bash

info "Checking Git configuration..."

GIT_NAME=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if [ -z "$GIT_NAME" ]; then
    echo -ne "\033[1;34m[ ?? ]\033[0m Enter your name: "
    read -r input_name
    git config --global user.name "$input_name"
    ok "Name configured: $input_name"
else
    ok "Git name already set (${GIT_NAME})."
fi

if [ -z "$GIT_EMAIL" ]; then
    echo -ne "\033[1;34m[ ?? ]\033[0m Enter your email: "
    read -r input_email
    git config --global user.email "$input_email"
    ok "Email configured: $input_email"
else
    ok "Git email already set (${GIT_EMAIL})."
fi

info "Setting main as default branch"
git config --global init.defaultBranch main

info "Configuring auto setup remote"
git config --global push.autoSetupRemote true

if command -v gh >/dev/null 2>&1; then
    info "Configuring GitHub CLI as credential helper"
    git config --global credential.https://github.com.helper ""
    git config --global credential.https://github.com.helper "!/usr/bin/gh auth git-credential"
    git config --global credential.https://gist.github.com.helper ""
    git config --global credential.https://gist.github.com.helper "!/usr/bin/gh auth git-credential"
fi
