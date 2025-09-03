{ pkgs }:

with pkgs;
let
  shared-packages = import ./shared.nix { inherit pkgs; };
in
shared-packages
++ [
  # A
  # anki

  # B
  bitwarden

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
  obsidian

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
  yubioath-flutter

  # Z
  zettlr
]
