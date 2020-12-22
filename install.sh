#提示“Permission denied” ,是因为权限不够，增加权限，在命令终端里输入：chmod +x install.sh回车

echo 开始安装Pods

pod repo update TBMtimePodSpec

pod cache clean TBMtimeBaseControll --all
pod cache clean TBMtimeCommon --all



rm -rf Pods/TBMtimeBaseControll
rm -rf Pods/TBMtimeCommon


rm -f *.lock

pod install

echo 安装结束
