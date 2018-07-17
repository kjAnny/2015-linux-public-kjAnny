# vimtutor 学习

## vimtutor 操作录制
[https://asciinema.org/a/WhSOWChv79e7vvzgtJmF5Gi3y](https://asciinema.org/a/WhSOWChv79e7vvzgtJmF5Gi3y)

## 自查清单

1. 你了解vim有哪几种工作模式？

    - 正常模式 (Normal-mode)
    - 插入模式 (Insert-mode)
    - 命令模式 (Command-mode)
    - 可视模式 (Visual-mode)

2. Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？

    - 一次向下移动光标10行：10 j
    - 快速移动到文件开始行：gg
    - 快速移动到文件结束行：G
    - 快速跳转到文件中的第N行：N G

3. Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？

    - 删除单个字符：把光标放到要删除的字符上，按‘x’键
    - 删除单个单词：dw
    - 从当前光标位置一直删除到行尾：d$
    - 删除单行：dd
    - 删除当前行开始向下数N行：Ndd

4. 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？

    - 快速插入N个空行：`N i <Enter> <Esc> <Esc>`
    - 快速输入80个-：`80 i - <Esc> <Esc>`

5. 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？

    - 撤销最近一次编辑操作:u
    - 重做最近一次被撤销的操作:Ctrl+R

6. vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？

    - 剪切粘贴单个字符：v dl p
    - 剪切粘贴单个单词：v dw p
    - 剪切粘贴单行：v dd p
    - 复制粘贴单个字符：v yl p
    - 复制粘贴单个单词：v yw p
    - 复制粘贴单行：v yy p

7. 为了编辑一段文本你能想到哪几种操作方式（按键序列）？

    - 使用vim打开文本：vim filename
    - 进入插入模式，然后插入文本，退出插入模式：`i 插入文本 <Esc>`
    - 复制或剪切粘贴
    - 保存并退出：:wq!

8. 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？

    - 查看当前正在编辑的文件名：normal模式下 :f
    - 查看当前光标所在行的行号：Ctrl+G

9. 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？

    - 关键词搜索：/[words]
    - 设置忽略大小写的情况下进行匹配搜索：:set ic
    - 高亮显示：:set hls is
    - 对匹配到的关键词进行批量替换

        - *#,#s/old/new/g* 其中，#,#是要更改的行号的范围
        - *:%s/old/new/g* 更改全文件中的所有事件。
        - *:%s/old/new/gc* 更改全文件中的所有事件,并给出替换与否的提示。

10. 在文件中最近编辑过的位置来回快速跳转的方法？

    - Ctrl+O（以前）、Ctrl+I（以后）

11. 如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }

     - 把光标定位到各种括号的匹配项：把光标放到(, [, or {对应匹配的),], or }上，按‘%’

12. 在不退出vim的情况下执行一个外部程序的方法？

     - :!+command

13. 如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？

    - :help 快捷键名称
    - 在两个不同的分屏窗口中移动光标：Ctrl+w

## 参考链接

[asciinema getting-started](https://asciinema.org/docs/getting-started)

[https://github.com/CUCCS/2015-linux-public-BiancaGuo/blob/%E5%AE%9E%E9%AA%8C%E4%BA%8C/%E5%AE%9E%E9%AA%8C%E4%BA%8C/Vimtutor%E5%AD%A6%E4%B9%A0.md](https://github.com/CUCCS/2015-linux-public-BiancaGuo/blob/%E5%AE%9E%E9%AA%8C%E4%BA%8C/%E5%AE%9E%E9%AA%8C%E4%BA%8C/Vimtutor%E5%AD%A6%E4%B9%A0.md)