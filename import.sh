mv ./id* ~/.ssh/
chmod 600 "id\w*$"
mv keys.txt ~/.config/sops/age/
gpg --import ./public.key
gpg -allow-secret-key-import --import ./private.key

