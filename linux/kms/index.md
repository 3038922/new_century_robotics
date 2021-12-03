- 通过KMS服务器就可以激活自己的windows和office了，注意：一般激活的周期是180天，以后我们再次通过服务器激活就行了。

## win 激活
`slmgr /skms 10.255.0.99:1688` 设置成自己的服务器和端口号
`slmgr /ato` 激活

## office 激活
`cscript ospp.vbs /sethst:10.255.0.99` 设置IP
`cscript ospp.obs /setprt:1688` 设置端口
`cscript ospp.vbs /act` 激活命令