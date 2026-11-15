{
  description = "A flake to compile hvt";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };
  outputs = { self, nixpkgs }@input:
    let system = "aarch64-linux"; 
        pkgs = nixpkgs.legacyPackages.${system};
        solo5 = pkgs.stdenv.mkDerivation rec {
          name = "Solo 5";
          src = ./.;
          nativeBuildInputs = [ pkgs.pkg-config ];
          buildInputs = [
            pkgs.libseccomp 
          ];
          configurePhase = ''
            ./configure.sh --prefix=$out
          '';
          buildPhase = ''
            make
          '';
          postPatch = ''
            printf '/**/\n' >/dev/null
            cat > include/version.h.distrib <<EOF
              /* Automatically generated, do not edit */

              #ifndef __VERSION_H__
              #define __VERSION_H__

              #define SOLO5_VERSION "0.13.1"

              #endif
            EOF
          '';
        };
    in {
      packages.${system}.default = solo5;
    };
}
