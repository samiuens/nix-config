{ pkgs }:

with pkgs;
let
  shared-packages = import ./shared.nix { inherit pkgs; };
in
shared-packages
++ [
  # A
  # B
  # C
  # D
  # E

  # F
  firefox

  # G
  git

  # H
  # I

  # J
  just

  # K
  # L
  # M

  # N
  nixfmt-rfc-style
  neovim

  # O
  # P
  # Q
  # R

  # S
  statix

  # T
  # U

  # V
  vscodium

  # W
  # X
  # Y
  # Z
]
