{
  description = "Python development shell with uv";

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
              python3
              uv
              python3Packages.pip
              python3Packages.virtualenv
            ];
            shellHook = ''
              echo "Python $(python --version)"
              echo "uv $(uv --version)"
              echo "Create an environment with: uv venv"
              echo "Install dependencies with: uv sync"
            '';
          };
        });
    };
}
