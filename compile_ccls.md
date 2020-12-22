# win10

## 编译 ccls

1. `cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="c:/llvm/Release; c:/llvm/Release/tools/clang;c:/llvm;c:/llvm/tools/clang"`
2. `ninja -C Release`
