#!/bin/bash

# Create directory with appropriate permissions
sudo install -d -m 0755 /etc/apt/keyrings

# Import repository signing key
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

# Verify fingerprint
gpg -q --import /etc/apt/keyrings/packages.mozilla.org.asc
fingerprints=$(gpg --fingerprint 35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3 | grep "Key fingerprint" | cut -d "=" -f 2)
if [ "$fingerprints" == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3" ]; then
    echo -e "\nThe key fingerprint matches ($fingerprints).\n"
else
    echo -e "\nVerification failed: the fingerprint ($fingerprints) does not match the expected one.\n"
fi

# Add repository
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

# Configure package pinning
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla > /dev/null

# Update package lists and install Firefox
sudo apt-get update && sudo apt-get install firefox -y

# Download and execute Rustup installer
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --profile complete --default-toolchain nightly

# Set path and source cargo environment variables
echo 'source $HOME/.cargo/env' >> ~/.bashrc
source ~/.bashrc
source $HOME/.cargo/env
# Download Go
wget https://golang.org/dl/go1.16.6.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.16.6.linux-amd64.tar.gz
rm go1.16.6.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

# Download Node.js
wget https://nodejs.org/dist/v16.2.0/node-v16.2.0-linux-x64.tar.xz
sudo tar -xJf node-v16.2.0-linux-x64.tar.xz -C /usr/local --strip-components=1
rm node-v16.2.0-linux-x64.tar.xz

# Install XFE
wget -O ~/xfe.deb "https://sourceforge.net/projects/xfe/files/xfe/1.46.1/xfe_1.46.1-1rb_amd64.deb/download"
sudo apt install -y ~/xfe.deb
rm ~/xfe.deb

# Download Ruby
wget https://cache.ruby-lang.org/pub/ruby/3.3/ruby-3.3.1.tar.gz
tar -xzvf ruby-3.3.1.tar.gz
cd ruby-3.3.1
./configure
make
sudo make install
cd ..
rm -rf ruby-3.3.1*

# Download Lua
curl -L -R -O https://www.lua.org/ftp/lua-5.4.6.tar.gz
tar zxf lua-5.4.6.tar.gz
cd lua-5.4.6
make linux test
sudo make install
cd ..
rm -rf lua-5.4.6*

# Download Perl
wget https://www.cpan.org/src/5.0/perl-5.38.2.tar.gz
tar -xzf perl-5.38.2.tar.gz
cd perl-5.38.2
./Configure -des -Dprefix=/usr/local
make
sudo make install
cd ..
rm -rf perl-5.38.2*

