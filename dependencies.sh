# TODO: detect and toggle between bash and zsh

add-apt-repository -y ppa:deadsnakes/ppa
apt update
apt install -y python3.9 python3.9-dev python3-pip python3-venv

# Install pre-requisite libraries
apt install -y libncurses-dev libxml2-dev libxmlsec1-dev \
libxmlsec1-openssl libxslt1-dev libpq-dev pkg-config gettext make build-essential \
libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev

# Install JDK
apt install -y openjdk-17-jre

# Install Postgress Client (optional)
apt install -y postgresql-client

# Install & Configure pyenv
apt install -y curl
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo 'export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"' >> $HOME/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.bashrc
# reboot shell to read the pyenv configuration
exec $SHELL

pyenv install 3.9.18
pyenv global 3.9.18
pyenv virtualenv 3.9.18 hq
pyenv local hq

# configure HQ
git submodule update --init --recursive
git-hooks/install.sh
pip install -r requirements/dev-requirements.txt
cp localsettings.example.py localsettings.py
mkdir sharedfiles

