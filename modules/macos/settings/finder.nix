{ hostConfig, ... }:
let
  userName = hostConfig.users."samiuensay".username;
in
{
  system.defaults = {
    finder = {
      AppleShowAllFiles = false;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      NewWindowTarget = "Other";
      NewWindowTargetPath = "file:///Users/${userName}/Documents";
      ShowPathbar = true;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
    };
  };
}
