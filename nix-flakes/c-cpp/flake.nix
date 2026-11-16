{
  description = "Small C and C++ development shell";

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
            packages = with pkgs; [ gcc cmake ninja pkg-config gdb ];
            shellHook = ''
              echo "GCC $(gcc --version | head -n1)"
              echo "CMake $(cmake --version | head -n1)"
            '';
          };
        });
    };
}
