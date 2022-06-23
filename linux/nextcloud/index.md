# nextcloud 

## 安装
docker pull nextcloud
## 导入新增文件夹
- `sudo -u www php /www/wwwroot/qzrobot.top/occ files:scan --all` 扫描所有用户的所有文件
- `sudo -u www php /www/wwwroot/qzrobot.top/occ user:list` 列出所有用户
- `sudo -u www php /www/wwwroot/qzrobot.top/occ files:scan admin` 为用户admin扫描文件
- `sudo -u www php /www/wwwroot/qzrobot.top/occ files:scan --path="/admin/files/书籍"` 指向用户admin的书籍文件夹
- `sudo -u www php /www/wwwroot/qzrobot.top/occ upgrade` 升级
## 设置定时任务
- `sudo -u www php cron.php`
## 解除上传速度限制
`sudo -u www php /www/wwwroot/qzrobot.top/occ config:app:set files max_chunk_size --value 0`

## 修复丢失的索因
`sudo -u www php /www/wwwroot/qzrobot.top/occ db:add-missing-columns`
`sudo -u www php /www/wwwroot/qzrobot.top/occ db:add-missing-indices`
`sudo -u www php /www/wwwroot/qzrobot.top/occ db:add-missing-primary-keys`
## 检查ONLYOFFICE连接状态
`sudo -u www php /www/wwwroot/qzrobot.top/occ onlyoffice:documentserver --check`

## 解决软连接错误
`ln -s /www/wwwroot/qzrobot.top/subfolder_name/ocm-provider/ /www/wwwroot/qzrobot.top`
`ln -s /www/wwwroot/qzrobot.top/subfolder_name/ocs-provider/ /www/wwwroot/qzrobot.top`

## 在重置数据备份或数据库备份后，应当先使用
`sudo -u www php /www/wwwroot/qzrobot.top/occ maintenance:data-fingerprint`
## 更新数据库mimetype并刷新文件缓存
`sudo -u www php /www/wwwroot/qzrobot.top/occ maintenance:mimetype:update-db`
## 更新mimetypelist.js 
`sudo -u www php /www/wwwroot/qzrobot.top/occ maintenance:mimetype:update-js`
## 修复安装
`sudo -u www php /www/wwwroot/qzrobot.top/occ maintenance:repair`
