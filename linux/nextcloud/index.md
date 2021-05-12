# nextcloud 

## 安装
docker pull nextcloud
## 导入新增文件夹
- `docker exec --user www-data nextcloud php occ files:scan --all` 扫描所有用户的所有文件
- `docker exec --user www-data nextcloud php occ user:list` 列出所有用户
- `docker exec --user www-data nextcloud php occ files:scan admin` 为用户admin扫描文件
- `docker exec --user www-data nextcloud php occ files:scan --path="/admin/files/书籍"` 指向用户admin的书籍文件夹
- `docker exec --user www-data nextcloud php occ upgrade` 升级
## 设置定时任务
- `docker exec --user www-data nextcloud php cron.php`
## 解除上传速度限制
`docker exec --user www-data nextcloud php occ config:app:set files max_chunk_size --value 0`

## 修复丢失的索因
`docker exec --user www-data nextcloud php occ db:add-missing-indices`
## 检查ONLYOFFICE连接状态
`docker exec --user www-data nextcloud php occ onlyoffice:documentserver --check`

## 常用软件安装
- `docker exec --user root nextcloud apt update`
- `docker exec --user root nextcloud apt install libmagickcore-6.q16-6-extra ffmpeg smbclient -y`
- `docker exec --user root nextcloud service apache2 restart`
- `docker exec --user root nextcloud service php7.4-fpm restart`
