echo '[INFO] Don't forget to set your user name and email in the git config!'
# Prompt for name
echo "Please enter your name:"
read name

# Prompt for email
echo "Please enter your email:"
read email

# Set the values in git config
git config --global user.name "$name"
git config --global user.email "$email"

echo "[INFO] Git config has been set with the following values:"
echo "[INFO] Name: $(git config --global user.name)"
echo "[INFO] Email: $(git config --global user.email)"
