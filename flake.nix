{
  description = "A simple Python environment with uv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Or a stable version like nixpkgs-24.05
  };

  outputs = { self, nixpkgs }: let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);

  in {
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs { inherit system; };
    in {
      default = pkgs.mkShell {
        buildInputs = [ pkgs.python3 pkgs.python3Packages.uv ];
        shellHook = ''echo "Dev shell for ${system} with uv installed."'';
      };
    });

    packages = forAllSystems (system: let
      pkgs = import nixpkgs { inherit system; };
    in {
      default = pkgs.writeShellScriptBin "mezzosayshi" ''
        if [ ! -d ".venv" ]; then
          echo "Setting up virtual environment..."
          uv venv --python=${pkgs.python3}/bin/python3
          uv pip install -r pyproject.toml
        fi
        mezzosayshi
      '';
    });

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/mezzosayshi";
      };
    });
  };
}