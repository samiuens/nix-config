{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nix4vscode.overlays.default
  ];
}
