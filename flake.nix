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
        stl_files = pkgs.stdenv.mkDerivation {
          name = "3d_models_stl";
          src = ./.;
          buildPhase = ''
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
          packages = [
            pkgs.openscad
            pkgs.openscad-lsp
          ];
        };
      }
    );
}
