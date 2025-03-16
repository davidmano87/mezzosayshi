{
  description = "A simple Python environment with uv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      default = pkgs.stdenv.mkDerivation rec {
        pname = "mezzosayshi";
        version = "0.0.7";
        src = ./.;
        buildInputs = [ pkgs.python3 pkgs.python3Packages.uv ];
        buildPhase = ''
          export HOME=$(pwd)
          mkdir -p $out/bin
          uv venv --python=${pkgs.python3}/bin/python3
          uv export --only-group=build | uv pip install --requirements=-
          uvx shiv -c mezzosayshi -o $out/bin/mezzosayshi -p '/usr/bin/env python3' .
        '';
        meta = with pkgs.lib; {
          description = "Mezzo says hi 👋";
          longDescription = ''
            Mezzo says hi 👋
          '';
          license = licenses.mit;
          maintainers = with maintainers; [ me ];
        };
      };
    });

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/mezzosayshi";
      };
    });
  };
}
