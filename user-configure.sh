#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Warning: Running as root!"
else
    echo "Setting up manjarpo-zsh-config for user $USER."
fi

set -e

touch ~/.zshrc

tmp=$(mktemp)
cat /etc/skel/.zshrc | cat - ~/.zshrc >$tmp && mv $tmp ~/.zshrc

cat <<EOF
Done!

To change the default shell to zsh run: "chsh $USER -s /bin/zsh"

Don't forget to use a supported font.
(like https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)
EOF
