# Small Nix development flakes

Each directory is an independent development environment. Copy the directory
you need into a project, then enter it with:

```sh
nix develop
```

Available templates:

- `python` — Python runtime, uv, pip, and virtual environments
- `typescript` — Node.js and TypeScript
- `go` — Go toolchain
- `rust` — Cargo, Rust, rustfmt, and Clippy
- `vhdl` — GHDL simulator
- `c-cpp` — GCC, CMake, Ninja, pkg-config, and GDB
- `terraform` — Terraform CLI
- `perf-engineering` — Rust and C/C++ toolchains plus perf, Valgrind,
  Heaptrack, FlameGraph, and benchmarking tools

The flakes support Linux on x86_64 and ARM64. Update the `nixpkgs` input
revision if you need newer packages.
