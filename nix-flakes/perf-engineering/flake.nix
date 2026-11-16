{
  description = "Performance engineering shell for Rust, C, and C++";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [
              # C and C++ toolchains and build tools.
              gcc
              clang
              cmake
              ninja
              pkg-config
              gdb
              lldb

              # Rust toolchain.
              cargo
              rustc
              rustfmt
              clippy

              # Profiling and benchmarking tools.
              linuxPackages.perf
              valgrind
              heaptrack
              gperftools
              flamegraph
              cargo-flamegraph
              hyperfine
            ];
            shellHook = ''
              echo "Rust $(rustc --version)"
              echo "GCC $(gcc --version | head -n1)"
              echo "Clang $(clang --version | head -n1)"
              echo "perf $(perf --version)"
            '';
          };
        });
    };
}
