#! /bin/zsh
#
# debを消す処理も欲しい

download(){
	# 依存先を調べて，インストールされてないものを再起的にダウンロード
    apt-cache depends $1 |
    grep Depends |
    awk '{print $2}' | 
    while read i; do
		# インストール済みじゃなかったら
        if [[ -z "$(dpkg -l | awk '{print $2}' | grep $i)" ]]; then
            download $i $2
        fi
    done
	version=$(apt-cache show $1 | grep Version | sed 's/^Version..//g')
	# これいる？
	wait
	# current directoryにダウンロード
    apt download $1
	# $2にインストール
	dpkg -x "$1"*"$version"*deb $2
}

download $1 $2
