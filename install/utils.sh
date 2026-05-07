#!/bin/bash
# install/utils.sh

C_DEF='\033[0m'
C_BLU='\033[1;34m'
C_GRN='\033[1;32m'
C_RED='\033[1;31m'
C_YEL='\033[1;33m'

info() { echo -e "${C_BLU}[INFO]${C_DEF} $1"; }
ok()   { echo -e "${C_GRN}[ OK ]${C_DEF} $1"; }
err()  { echo -e "${C_RED}[ERR!]${C_DEF} $1"; }
warn() { echo -e "${C_YEL}[WARN]${C_DEF} $1"; }

ask() {
    local prompt="$1"
    local default="$2"
    local reply
    
    if [[ "$default" == "Y" ]]; then
        echo -ne "${C_BLU}[ ?? ]${C_DEF} $prompt [Y/n]: "
    else
        echo -ne "${C_BLU}[ ?? ]${C_DEF} $prompt [y/N]: "
    fi
    
    read -r reply
    [[ -z "$reply" ]] && reply=$default
    
    if [[ "$reply" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}