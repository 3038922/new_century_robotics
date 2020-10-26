## win10

### 编译 llvm

1. `cmake -Hllvm -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS=clang`
2. `ninja -C Release clangFormat clangFrontendTool clangIndex clangTooling clang`

### 编译 ccls

1. `cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="c:/llvm/Release;c:/llvm/Release/tools/clang;c:/llvm;c:/llvm/tools/clang"`
2. `ninja -C Release`
