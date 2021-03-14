# win10

## 编译 llvm

1. `cmake -Hllvm -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS=clang`
2. 选额部分编译 `ninja -C Release clangFormat clangFrontendTool clangIndex clangTooling clang llvm-rc`
3. 完全编译 `ninja -C Release` clang11 似乎不支持 win10 msvc