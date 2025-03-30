{
  description = "Printable 3d Models";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = pkgs.lib;
        nutsnbolts = pkgs.fetchFromGitHub {
          owner = "JohK";
          repo = "nutsnbolts";
          rev = "c16d745606ff3d069021809289137d77e19281d8";
          hash = "sha256-n/O0bTiUyWqHQFkK2QgsKXAdL6ibGrWZEZNf5xymPtc=";
        };
        stl_files = pkgs.stdenv.mkDerivation {
          name = "3d_models_stl";
          src = ./.;
          buildPhase = ''
            export OPENSCADPATH="${lib.strings.makeSearchPathOutput "out" "" [ nutsnbolts ]}"
            mkdir $out
            for in_file in *.scad; do
              out_file="$out/''${in_file%.*}.stl"
              ${lib.getExe pkgs.openscad} -q -o "$out_file" "$in_file"
            done
          '';
        };
      in
      {
        packages = {
          default = stl_files;
        };
        devShells.default = pkgs.mkShell {
          shellHook = ''
            export OPENSCADPATH="${lib.strings.makeSearchPathOutput "out" "" [ nutsnbolts ]}"
          '';
          packages = [
            pkgs.openscad
            pkgs.openscad-lsp
          ];
        };
      }
    );
}
