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
      userConfig = "${moduleDir}/${username}.nix";
      userExists = builtins.pathExists userConfig;
      sharedConfig = "${moduleDir}/shared.nix";
      sharedExists = builtins.pathExists sharedConfig;
    in
    if userExists then
      import userConfig
    else if sharedExists then
      import sharedConfig
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
