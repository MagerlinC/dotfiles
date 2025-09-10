#!/bin/zsh
echo "Exporting GPG signing key"
gpg --export $1 >public.key
gpg --export-secret-keys $1 >private.key
echo "GPG signing key exported to public.key and private.key. Copy them to the target machine and run gpg --import private.key"
