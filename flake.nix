{
  description = "Mezzo says hi 👋";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);

  in forAllSystems (system:
  let
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.default = pkgs.python311.pkgs.buildPythonPackage {
      pname = "mezzosayshi";
      version = "0.0.5";
      src = pkgs.lib.cleanSource ./.;
      format = "pyproject";
      nativeBuildInputs = [ pkgs.uv ];
    };

    apps.default = {
      type = "app";
      program = "${self.packages.${system}.default}/bin/mezzosayshi";
    };

    devShells.default = pkgs.mkShell {
      buildInputs = [
        pkgs.python311
        pkgs.uv
      ];
      shellHook = "uv venv --system-site-packages .venv";
    };
  });
}
