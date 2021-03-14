# nextcloud 

## 安装

## 导入新增文件夹
- `sudo -u www php /www/wwwroot/nextcloud/occ files:scan --all` 扫描所有用户的所有文件
- `sudo -u www php /www/wwwroot/nextcloud/occ user:list` 列出所有用户
- `sudo -u www php /www/wwwroot/nextcloud/occ files:scan admin` 为用户admin扫描文件
- `sudo -u www php /www/wwwroot/nextcloud/occ files:scan --path="/admin/files/书籍"` 指向用户admin的书籍文件夹
## 设置定时任务
 sudo --user www /www/server/php/80/bin/php cron.php