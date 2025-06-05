#!/bin/bash

# Referência:
# Icones: 
# - https://emojipedia.org/
# - https://getemoji.com/

# Verifica dependência do fzf
if ! command -v fzf &> /dev/null; then
  echo -e "\u274C O utilitário 'fzf' não está instalado. Instale com: git clone https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install"
  git clone https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install && source ~/.bashrc
fi

if ! command -v file &> /dev/null; then
  echo -e "\u274C O utilitário 'file' não está instalado. Instale com: sudo yum install file"
  sudo yum install -y file
fi

# Obtém IP público do ambiente atual
MY_IP=$(curl -s ifconfig.me)
echo -e "\U0001F4E1 Seu IP público atual: $MY_IP"

# Pega lista de instâncias EC2 com status, nome, ID e IP público
echo -e "\U0001F50D Buscando instâncias EC2..."
INSTANCES=$(aws ec2 describe-instances \
  --query "Reservations[].Instances[].[State.Name, Tags[?Key=='Name']|[0].Value, InstanceId, PublicIpAddress]" \
  --output text)

if [ -z "$INSTANCES" ]; then
  echo -e "\u274C Nenhuma instância EC2 encontrada na região atual."
  exit 1
fi

# Mostra instâncias com fzf
CHOICE=$(echo "$INSTANCES" | awk '{printf "[%s] %-20s %-20s %-15s\n", $1, $2, $3, $4}' | fzf --prompt="Selecione a instância EC2: ")

if [ -z "$CHOICE" ]; then
  echo -e "\u274C Nenhuma instância selecionada."
  exit 1
fi

# Extrai campos
INSTANCE_STATE=$(echo "$CHOICE" | awk '{gsub(/[\[\]]/, "", $1); print $1}')
INSTANCE_NAME=$(echo "$CHOICE" | awk '{print $2}')
INSTANCE_ID=$(echo "$CHOICE" | awk '{print $3}')
INSTANCE_IP=$(echo "$CHOICE" | awk '{print $4}')

if [ "$INSTANCE_STATE" != "running" ]; then
  echo -e "\u26A0\ufe0f A instância não está em execução (status: $INSTANCE_STATE)."
  exit 1
fi

echo -e "\u2705 Instância selecionada: $INSTANCE_NAME ($INSTANCE_ID) - IP: $INSTANCE_IP"

# Descobre o SG
SG_ID=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].SecurityGroups[0].GroupId" \
  --output text)

echo -e "\U0001F510 Security Group: $SG_ID"

# Tenta adicionar regra de acesso
aws ec2 authorize-security-group-ingress \
  --group-id "$SG_ID" \
  --protocol tcp \
  --port 22 \
  --cidr "$MY_IP/32" 2>/dev/null

echo -e "\u2705 Liberação de SSH para $MY_IP/32 (pode já existir)"

# Identifica as chaves SSH reais (sem depender da extensão)
echo -e "\U0001F511 Buscando chaves privadas no ~/.ssh..."
SSH_KEY=$(find ~/.ssh -type f ! -name "*.pub" | while read file; do
  if file "$file" | grep -q "private key"; then
    echo "$file"
  fi
done | fzf --prompt="Selecione a chave SSH: ")

if [ -z "$SSH_KEY" ]; then
  echo -e "\u274C Nenhuma chave selecionada."
  exit 1
fi

chmod 400 "$SSH_KEY"

echo -e "\U0001F680 Conectando na instância com a chave:"
echo -e "    \U0001F510 $SSH_KEY"
ssh -i "$SSH_KEY" ec2-user@"$INSTANCE_IP"