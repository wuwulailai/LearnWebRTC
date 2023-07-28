mkdir webrtc
cd webrtc
# git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
#需要设置一个临时的环境变量或者写到.bash_profile或者.zshrc里
export WORKSPACE=$(pwd)
PATH=$WORKSPACE/depot_tools:$PATH

cd depot_tools
# 挂了V 下载还挺快的
fetch --nohooks webrtc
# 这里拉了半天代码
gclient sync

#代码管理  
git config branch.autosetupmerge always
#创建自己的分支
git branch rtc_study
#切到自己的分支
git checkout rtc_study

#生成xcode工程
cd src
#加上ios_enable_code_signing=false 和 rtc_include_tests=false 可避免报错Assignment had no effect
gn gen out/ios --args='target_os="ios" target_cpu="arm64" is_component_build=false ios_enable_code_signing=false rtc_include_tests=false' --ide=xcode 
#编译项目生成.framework动态库
ninja -C out/ios AppRTCMobile
# 编译.a静态库
ninja -C out/ios webrtc