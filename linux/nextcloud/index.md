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