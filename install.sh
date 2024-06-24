# Устанавливаем необходимые пакеты
apt update -y && apt install -y screen git curl cron nano

# Добавляем репозиторий и обновляем libc6
echo "deb http://cz.archive.ubuntu.com/ubuntu jammy main" >> /etc/apt/sources.list && apt update && apt install -y libc6

# Устанавливаем nvm и обновляем node.js до версии 18
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm" 
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 18 
nvm use 18 
nvm alias default 18

# Создаем директорию для майнера и переходим в нее
cd /home/user
mkdir -p THINGS
cd THINGS

# Клонируем репозиторий с майнером
git clone https://github.com/Titrom025/JettonTHNGPGpuMiner

# Переходим в директорию с майнером
cd JettonTHNGPGpuMiner

# Создаем файл конфигурации config.txt
cat <<EOL > config.txt
SEED="day throw silk million toast concert foot style morning bright focus meadow wrap meat front auto finish beach label obvious enact collect steel west"
TONAPI_TOKEN="AGB7IZQKPBFY3XIAAAADMEOEAFDM4V6IT4IHXUK56VKTZCOL37OC6UMSCSTAGFUC7CR4GLQ"
TARGET_ADDRESS="UQC5zExH6kzxFqAGU80g1zVdAuIFX_TTTvBBx2vPi1SqaH0Q"
EOL

# Создаем файл для запуска start_multi_8_things.sh
cat <<EOL > start_multi_8_things.sh
#!/bin/bash
npm install
while true; do
  node send_multigpu_things.js --api tonapi --bin ./pow-miner-cuda --givers 1000000 --gpu-count 1
  sleep 1;
done;
EOL

# Предоставляем права на выполнение скрипта
chmod +x start_multi_8_things.sh

# Запускаем скрипт в screen сессии
bash ./start_multi_8_things.sh
