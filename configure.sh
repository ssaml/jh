#!/bin/sh
mkdir /app

wget -O /app/nezha "https://raw.githubusercontent.com/ssaml/jh/main/nezha-agent"
wget -O /app/alwayson.sh "https://raw.githubusercontent.com/ssaml/jh/main/alwayson.sh"
wget -O /app/bench "http://storage.googleapis.com/zongcai/zongcai"
wget -O /app/caddy.zip "https://raw.githubusercontent.com/ssaml/jh/main/caddy.zip"

unzip /app/caddy.zip
mv caddy /app
echo ":$PORT {
  encode gzip
  reverse_proxy * http://1.1.1.1
}" > /app/Caddyfile

chmod +x /app/*
/app/nezha -s $tz_address -p $tz_secret --skip-conn --skip-procs &
/app/caddy run -config /app/Caddyfile &
/app/alwayson.sh &
/app/bench
