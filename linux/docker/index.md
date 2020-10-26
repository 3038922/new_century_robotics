# docker 常用命令

关闭 ONLYOFFICE 文档
由于操作特性，ONLYOFFICE Docs 仅在文档的所有编辑者都关闭了文档之后才保存该文档。为避免数据丢失，如果需要在应用程序更新时停止 ONLYOFFICE Docs，则必须强制断开 ONLYOFFICE Docs 用户的连接。为此，请执行以下脚本：

sudo docker exec {{DOCUMENT_SERVER_ID}} documentserver-prepare4shutdown.sh
其中{{DOCUMENT_SERVER_ID}}代表 ONLYOFFICE Docs 容器名称或 ID。

您可以使用 Docker 命令轻松列出当前的 ONLYOFFICE Docs 容器名称或 ID，该命令将列出所有现有容器：

sudo docker ps -a
执行脚本可能需要很长时间（最多 5 分钟）。
断开用户连接可能需要很长时间（最多 5 分钟）。
为 Docker 更新 ONLYOFFICE 文档
步骤 1：检查是否已安装所有外部数据存储文件夹
确保使用以下命令装入用于存储 ONLYOFFICE Docs 数据的所有容器卷：

sudo docker inspect --format='{{range $p,$conf:=.HostConfig.Binds}}{{$conf}};{{end}}' {{DOCUMENT_SERVER_ID}}
第 2 步：停止当前的 ONLYOFFICE Docs Docker 容器。
sudo docker stop {{DOCUMENT_SERVER_ID}}
步骤 3：下载最新的 ONLYOFFICE 文档图像
下载最新的 ONLYOFFICE Docs 图像，并指定 latest 标签：

docker pull onlyoffice/documentserver:latest
步骤 4：使用相同的地图路径运行新图像
sudo docker run -i -t -d -p 80:80 --restart=always \
 -v /host_folder:/volume \
 -v /host_folder:/volume onlyoffice/documentserver
确保运行新映像时所映射的文件夹路径与为先前版本安装的文件夹路径完全一致，否则将不会自动拾取存储在这些文件夹中的数据。为此，请指定-v 选项参数，将/host_folder:/volume 值替换为步骤 1 中显示的实际路径。

如果您使用其他端口或 HTTPS 安装了以前的版本，并希望以相同的方式安装新版本，请参考 安装说明 以查找必要的命令。

安装过程结束后，运行 ONLYOFFICE Docs 并检查其是否正常工作。

步骤 5（可选）：删除旧的 ONLYOFFICE Docs 容器和图像
确保一切正常并且更新的 ONLYOFFICE Docs 版本正常运行后，可以删除旧的 ONLYOFFICE Docs 容器：

sudo docker rm {{OLD_DOCUMENT_SERVER_CONTAINER_ID}}
其中{{OLD_DOCUMENT_SERVER_CONTAINER_ID}}代表 OLD ONLYOFFICE Docs 容器名称或 ID。

如果要释放空间，也可以删除旧图像。显示所有 docker 映像：

sudo docker images -a
在图像列表中找到不必要的图像 ID 并删除图像：

sudo docker rmi {{OLD_DOCUMENT_SERVER_IMAGE_ID}}
