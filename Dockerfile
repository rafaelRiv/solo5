  FROM nixos/nix:latest
  WORKDIR /workspace
  COPY conf/nix.conf /etc/nix/nix.conf
  COPY ./ /workspace
  CMD ["zsh"]
