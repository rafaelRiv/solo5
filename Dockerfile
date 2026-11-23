  FROM nixos/nix:latest
  WORKDIR /workspace
  COPY conf/nix.conf /etc/nix/nix.conf
  COPY ./ /workspace
  RUN nix profile install nixpkgs#iproute2 nixpkgs#nettools
  CMD ["zsh"]
