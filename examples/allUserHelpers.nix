# Beispiel: Alle neuen Benutzer-Helper-Funktionen
{ lib, hostConfig, ... }:

let
  userHelpers = import ../../lib/userHelpers.nix { inherit lib; };

  # === LISTE-FUNKTIONEN (Strings) ===

  # Alle Benutzer als Liste
  allUsers = userHelpers.getAllUsers hostConfig.users;
  # Ergebnis: ["samiuensay", "samiarda"]

  # Sudo-Benutzer als Liste
  sudoUsers = userHelpers.getSudoUsers hostConfig.users;
  # Ergebnis: ["samiuensay"]

  # Normale Benutzer als Liste
  normalUsers = userHelpers.getNormalUsers hostConfig.users;
  # Ergebnis: ["samiarda"]

  # Primary User als String
  primaryUser = userHelpers.getPrimaryUser hostConfig.users;
  # Ergebnis: "samiuensay"

  # Primary Sudo User als String
  primarySudoUser = userHelpers.getPrimarySudoUser hostConfig.users;
  # Ergebnis: "samiuensay"

  # === SET-FUNKTIONEN (Objekte) ===

  # Alle Benutzer als Set
  allUsersSet = userHelpers.createAllUsersSet hostConfig.users;
  # Ergebnis: {
  #   samiuensay = {nickname = "Sami Arda Ünsay"; type = "sudo"; ...};
  #   samiarda = {nickname = "samiarda (Work)"; type = "user"; ...};
  # }

  # Sudo-Benutzer als Set
  sudoUsersSet = userHelpers.createSudoUsersSet hostConfig.users;
  # Ergebnis: {
  #   samiuensay = {nickname = "Sami Arda Ünsay"; type = "sudo"; ...};
  # }

  # Normale Benutzer als Set
  normalUsersSet = userHelpers.createNormalUsersSet hostConfig.users;
  # Ergebnis: {
  #   samiarda = {nickname = "samiarda (Work)"; type = "user"; ...};
  # }

in
{
  # Beispiel-Verwendung für SSH
  services.openssh = {
    enable = true;
    # Nur sudo-Benutzer dürfen sich anmelden
    allowedUsers = sudoUsers;
  };

  # Beispiel-Verwendung für Gruppen
  users.groups.admin = {
    members = sudoUsers;
  };

  # Beispiel-Verwendung für spezielle Konfigurationen
  services.syncthing = lib.optionalAttrs (primarySudoUser != null) {
    enable = true;
    user = primarySudoUser;
  };

  # Beispiel-Verwendung mit Sets
  systemd.services.custom-service = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = primaryUser;
      Group = "users";
    };
  };
}
