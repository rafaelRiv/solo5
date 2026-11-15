{
  description = "A flake to compile hvt",
  input = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };
  output = { self, nixpkgs }@input {
    let system = "aarch64-darwin"; 
        pkgs = nixpkgs.legacyPackage.${system};
    in {
      packages.${system}.default = pkgs.hello;
    };
  };
}
