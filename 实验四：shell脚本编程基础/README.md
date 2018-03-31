# shell脚本编程基础（实验）

## 任务一

### 对图片处理相关命令
```bash
# 输出文件类型
file --mime-type -b file_name

# 使用图像处理convert命令，首先要安装imagemagick
sudo  apt install imagemagick

# 对图片进行图片质量压缩
convert -quality value input_file output_file

# 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
convert input_file -resize geometry output_file

# 添加文字水印
mogrify -gravity SouthEast -fill black -draw 'text 0,0 'text'' inputfile

# 重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
mv file.jpg add_file.jpg

# 将png/svg图片统一转换为jpg格式图片
convert file.png file.jpg
```

## 任务二
![](images/1.PNG)

## 任务三
帮助文档
![](images/2.PNG)

统计访问来源主机TOP 100和分别对应出现的总次数
![](images/3.PNG)

统计访问来源主机TOP 100 IP和分别对应出现的总次数
![](images/4.PNG)

统计最频繁被访问的URL TOP 100
![](images/5.PNG)

统计不同响应状态码的出现次数和对应百分比
![](images/6.PNG)

分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
![](images/8.PNG)

给定URL输出TOP 100访问来源主机
![](images/7.PNG)

## 参考链接
[利用ImageMagicK给图片加水印](http://www.netingcn.com/imagemagick-mark.html)

[正则表达式](http://www.runoob.com/regexp/regexp-syntax.html)
