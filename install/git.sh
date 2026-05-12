#!/bin/bash

info "Checking Git configuration..."

GIT_NAME=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if [ -n "$GIT_NAME" ] && [ -n "$GIT_EMAIL" ]; then
    ok "Git is already configured (${GIT_NAME} <${GIT_EMAIL}>)."
    return 0
fi

warn "Git is not fully configured."

if ask "Configure Git user and email globally?" "Y"; then
    if [ -z "$GIT_NAME" ]; then
        echo -ne "\033[1;34m[ ?? ]\033[0m Enter your name: "
        read -r input_name
        git config --global user.name "$input_name"
        ok "Name configured: $input_name"
    fi
    
    if [ -z "$GIT_EMAIL" ]; then
        echo -ne "\033[1;34m[ ?? ]\033[0m Enter your email: "
        read -r input_email
        git config --global user.email "$input_email"
        ok "Email configured: $input_email"
    fi

	info "Setting main as default branch"
	git config --global init.defaultBranch main
else
    warn "Continuing without configuring Git."
fi
