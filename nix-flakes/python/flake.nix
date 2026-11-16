{
  description = "Small Python development shell";

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
            packages = with pkgs; [ python3 python3Packages.pip ];
            shellHook = ''
              echo "Python $(python --version)"
              echo "Create an environment with: python -m venv .venv"
            '';
          };
        });
    };
}
