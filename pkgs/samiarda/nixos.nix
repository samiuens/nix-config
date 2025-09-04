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
  # G
  # H
  # I
  # J
  # K
  # L
  # M
  # N
  # O
  # P
  # Q
  # R
  # S
  # T
  # U
  # V
  # W
  # X
  # Y
  # Z
]
