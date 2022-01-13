FROM node:latest as builder
WORKDIR /app
COPY package.json .
RUN npm install（yarn)
COPY . .
RUN npm run build
# 注意在以上的代码里面执行了两次copy，第一次只是拷贝了package.json文件，第二次拷贝了全部的文件。当你的应用需要持续化部署的时候，会很有意义。比如你的每次提交，都能通过CD部署到dev环境，这时候你可能就需要考虑，是不是我每次提交都需要重新安装依赖。可能在你没有更改package.json文件的时候，你并不希望它执行很耗时的npm install，而且在我们的开发中更改package.json文件的频率并不高。
# docker的cache机制，能帮你避免不必要的依赖安装的耗时。当你在你的部署机上第一次构建这个镜像的之后，镜像保存在你的本地，第二次构建的时候，他会根据你COPY指令中对应的内容是否与上一次构建的内容一致来决定是否要启用上一次执行的cache，如果检查到COPY package.json .这一层中，package.json文件和上次没有任何改变，那么接下来的RUN npm install这一层就会使用上一次执行的cache。
# 所有的指令执行完，就完成了在镜像中打包，所有的静态文件都会在/app/build目录下。