# win10

## 编译 ccls

1. `cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="c:/ncrRobotics/llvm/Release; c:/ncrRobotics/llvm/Release/tools/clang;c:/ncrRobotics/llvm;c:/ncrRobotics/llvm/tools/clang"`
2. `ninja -C Release`
