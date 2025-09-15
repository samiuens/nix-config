{ lib, ... }:

let
  loadUserConfig =
    userName:
    let
      userFile = ../config/users/${userName}.nix;
      userConfig = if builtins.pathExists userFile then import userFile else { };
      userData = userConfig.${userName} or { };
    in
    userData
    // {
      applications = userData.applications or [ ];
      configurations = userData.configurations or [ ];
      services = userData.services or [ ];
      nickname = userData.nickname or userName;
      type = userData.type or "user";
    };

  createUserConfigs =
    userNames:
    builtins.listToAttrs (
      map (userName: {
        name = userName;
        value = loadUserConfig userName;
      }) userNames
    );

  filterUsersByType =
    userNames: userType:
    builtins.filter (
      userName:
      let
        userConfig = loadUserConfig userName;
      in
      userConfig.type or "user" == userType
    ) userNames;

  getSudoUsers = userNames: filterUsersByType userNames "sudo";
  getNormalUsers = userNames: filterUsersByType userNames "user";
  getAllUsers = userNames: userNames;

  createSudoUsersSet =
    userNames:
    builtins.listToAttrs (
      map (userName: {
        name = userName;
        value = loadUserConfig userName;
      }) (getSudoUsers userNames)
    );

  createNormalUsersSet =
    userNames:
    builtins.listToAttrs (
      map (userName: {
        name = userName;
        value = loadUserConfig userName;
      }) (getNormalUsers userNames)
    );

  createAllUsersSet =
    userNames:
    builtins.listToAttrs (
      map (userName: {
        name = userName;
        value = loadUserConfig userName;
      }) userNames
    );

  getPrimaryUser = userNames: if builtins.length userNames > 0 then builtins.head userNames else null;

  getPrimarySudoUser =
    userNames:
    let
      sudoUsersList = getSudoUsers userNames;
    in
    if builtins.length sudoUsersList > 0 then builtins.head sudoUsersList else null;

  debugUserConfigs =
    userNames:
    builtins.mapAttrs (
      userName: userConfig:
      builtins.trace "Loaded config for ${userName}: ${builtins.toJSON userConfig}" userConfig
    ) (createUserConfigs userNames);

  loadHostSpecificApps =
    hostname:
    let
      hostAppsFile = ../config/hostSpecificApps.nix;
      hostApps = if builtins.pathExists hostAppsFile then import hostAppsFile else { };
    in
    hostApps.userApplicationOverrides or { };

  getUserApplicationsForHost =
    userName: hostname: platform:
    let
      userConfig = loadUserConfig userName;
      hostSpecificApps = loadHostSpecificApps hostname;
      userHostApps = hostSpecificApps.${userName} or { };
      platformApps = userHostApps.${platform} or [ ];
    in
    userConfig.applications ++ platformApps;

  getUserApplicationsWithHostOverrides =
    userName: hostConfig:
    let
      userConfig = loadUserConfig userName;
      hostOverrides = hostConfig.userApplicationOverrides or { };
      additionalApps = hostOverrides.${userName} or [ ];
    in
    userConfig.applications ++ additionalApps;

in
{
  inherit
    loadUserConfig
    createUserConfigs
    filterUsersByType
    getSudoUsers
    getNormalUsers
    getAllUsers
    createSudoUsersSet
    createNormalUsersSet
    createAllUsersSet
    getPrimaryUser
    getPrimarySudoUser
    debugUserConfigs
    loadHostSpecificApps
    getUserApplicationsForHost
    getUserApplicationsWithHostOverrides
    ;
}
