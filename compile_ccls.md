`cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="c:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/bin;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/lib;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.27.29110/lib/x64;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.27.29110/lib/onecore/x64;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.27.29110/bin/Hostx64/x64"`

`cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER="clang-cl" -DCMAKE_PREFIX_PATH="C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/bin;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/lib;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/lib/clang/10.0.0/lib/windows;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/lib/site-packages"`

cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/lib;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/lib/clang/10.0.0/include;C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/lib/clang/10.0.0/lib/windows"

C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/lib
C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/lib;
C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/lib/clang/10.0.0

cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="c:/llvm/Release;c:/llvm/Release/tools/clang;c:/llvm;c:/llvm/tools/clang"

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm" -DLLVM_INCLUDE_DIR="C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/lib/clang/10.0.0/include" -DLLVM_BUILD_INCUDE_DIR="C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/lib/clang/10.0.0/include"
