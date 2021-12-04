# win10

## 编译ninja
1. 下载 ninja git clone git://github.com/ninja-build/ninja.git && cd ninja
2. 切换分支 git checkout release
3. 执行 python configure.py --bootstrap

## 编译 llvm

1. `cmake -Hllvm -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS=clang`
2. 选额部分编译 `ninja -C Release clangFormat clangFrontendTool clangIndex clangTooling clang llvm-rc`
3. 完全编译 `ninja -C Release` clang11 似乎不支持 win10 msvc

## 编译 ccls

1. `cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="c:/ncrRobotics/llvm/Release; c:/ncrRobotics/llvm/Release/tools/clang;c:/ncrRobotics/llvm;c:/ncrRobotics/llvm/tools/clang;c:/ncrRobotics/llvm/Release/lib"`

`cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="c:/ncrRobotics/llvm/Release"`

2. `ninja -C Release`

## visual studio 本地化
构建离线包 `C:\ncrRobotics\temp\vs2021\vs_Community.exe --layout "C:\ncrRobotics\temp\vs2021" --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.VisualStudio.Workload.NativeCrossPlat --add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset --add Microsoft.VisualStudio.Component.VC.Llvm.Clang --includeRecommended --lang zh-CN`
安装离线包 `C:\ncrRobotics\temp\vs2021\vs_Community.exe --noweb --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.VisualStudio.Workload.NativeCrossPlat --add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset --add Microsoft.VisualStudio.Component.VC.Llvm.Clang --includeRecommended`