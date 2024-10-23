```bash
touch "${HOME}/.hushlogin"

sudo apt-get update \
  && sudo apt-get upgrade -y \
  && sudo apt-get autoremove -y

sudo apt-get install -y \
  apt-transport-https \
  build-essential \
  curl \
  dnsutils \
  dotnet-sdk-8.0 \
  gnupg2 \
  net-tools \
  unzip

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/joshuaw/.bashrc

brew install \
  awscli \
  azcopy \
  azure-cli \
  gcc \
  go \
  helm \
  jq \
  k9s \
  kind \
  kubectx \
  kubernetes-cli \
  kustomize \
  node \
  python \
  starship \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform

sudo snap install powershell --classic
```
