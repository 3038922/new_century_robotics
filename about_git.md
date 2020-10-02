## git 命令

![avatar](./pic/git常用操作.png)

- 更新远程分支列表 `git remote update origin --prune`
- 查看所有分支 `git branch -a`
- 切换到主分支: `git checkout master`
- 把主分支内容下载下来: `git pull origin master`
- 把分支从镜像上下载下来 `git pull mirror dev`
- 把分支合并到 master:`git merge xxxx`
- 删除本地分支: `git branch -D temp`
- 删除远程分支: `git push origin --delete temp`
- 查看所有分支: `git branch -a`
- 查看所有远程仓库， `git remote`
- 查看指定远程仓库地址 `git remote xxx`
- 设置新的远程服务器路径 `git remote set-url origin ares@192.168.31.199:/home/ares/git/towerTakeOver.git`
- 添加一个远程库 `git remote add mirror git@192.168.31.193:3038922/myStudy.git`
- 添加另外一个远程库 `git remote set-url --add origin git@192.168.31.193:3038922/myStudy.git`
- 查看远程库及地址 `git remote -v`
- 删除远程仓库地址 `git remote rm origin`
- git 服务器搭建 `mkdir cadlib.git` `git init --bare xxx.git`
- git 服务器启动 `service ssh start`
- 强制服务器端覆盖本地

  ```sh
  git fetch --all
  git reset --hard origin/master
  git pull
  ```

* gitignore 没起作用!

```sh
git rm -r --cached .
git add .
git commit -m 'update .gitignore'
```

- .git 文件夹过大

```sh
  git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch lib/json_vc71_libmtd.lib' --prune-empty --tag-name-filter cat -- --all
  git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
  git reflog expire --expire=now --all
  git gc --aggressive --prune=now
  git push --force --verbose --dry-run
  git push --force
```

- .git 合并其他分支的某一文件夹
  '''sh
  git checkout release include/ncrapi/userConfig/**
  git checkout master firmware/**
  '''
- .git 强制覆盖分支

```sh
  git checkout release                         //将当前分支切换到主分支
  git reset --hard dev                           //将主分支重置为 test 分支
  git push origin release -f             //将重置后的 master 分支强制推送到远程仓库
```

- git 本地 tag 和远程 tag 对应不上 vscode 里 pull 不下代码

```sh
! [rejected]          dataSource0424 -> dataSource0424  (would clobber existing tag)
用git ls-remote -t 查看远程tags                 git tag -l查看本地tag
然后用 git tag -d xxx删除本地tag
最后远程拉取远程tags   git fetch origin --prune-tags
删除远程tags git push origin --delete tag 标签名
```
