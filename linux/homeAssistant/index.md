# homeAssistant
## install 
`docker run --init -d --restart=always --name="homeassistant" -e "TZ=Asia/Shanghai" -p 8091:8123 -v /app/homeAssistant/config/:/config -v /etc/localtime:/etc/localtime:ro homeassistant/home-assistant:stable`
