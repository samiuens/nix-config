{
  moduleConfig,
  configDir,
  username,
}:

let
  importModuleConfig =
    moduleName:
    let
      moduleDir = "${configDir}/${moduleName}";
      sharedConfig = "${moduleDir}/shared.nix";
      userConfig = "${moduleDir}/${username}.nix";
      sharedExists = builtins.pathExists sharedConfig;
      userExists = builtins.pathExists userConfig;
    in
    if sharedExists then
      import sharedConfig
    else if userExists then
      import userConfig
    else
      builtins.trace "WARN: No configuration file found for '${moduleName}' in directory '${moduleDir}'." null;

  configs = builtins.listToAttrs (
    map (moduleName: {
      name = moduleName;
      value = importModuleConfig moduleName;
    }) moduleConfig
  );
in
builtins.filter (x: x != null) (map importModuleConfig moduleConfig)
