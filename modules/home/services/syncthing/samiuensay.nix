{ hostname, ... }:
{
  services.syncthing =
    let
      syncthingOptions = {
        gui = {
          address = "127.0.0.1:8384";
          theme = "black";
        };
        listenAddresses = [ "tcp://${hostname}:22000" ];
        urAccepted = -1;
        globalAnnounceEnabled = false;
        localAnnounceEnabled = false;
      };

      mkDevice = name: ip: id: {
        name = name;
        value = {
          addresses = [ "tcp://${ip}:22000" ];
          inherit id;
        };
      };

      mkFolderValue =
        {
          name,
          keepDays,
          customPath ? "~/Sync/${name}",
        }:
        {
          enable = true;
          id = name;
          label = name;
          path = customPath;
          type = "sendreceive";
          devices = deviceNames;
          versioning = {
            type = "simple";
            params.keep = keepDays;
          };
        };
      deviceNames = builtins.attrNames devices;

      devices = builtins.listToAttrs [
        (mkDevice "smi-nixos" "100.64.0.1"
          "FKHRG66-YMUNPTY-TQXAE6N-NSCFPUA-UWIRVSN-EUYTAVY-6QNDCCA-3WKHRA5"
        )
        (mkDevice "smi-win" "100.64.0.2" "TKPYJRB-WOFKOUN-74VPIMO-PRYPNMS-5SEYRI7-YL2YBHX-N7B6VME-U7JLFQG")
        (mkDevice "smi-mac" "100.64.0.3" "L7QG4FE-WLUOWV7-B7VJNWK-GMZCWIT-S2ZPN6L-XPHUI4B-RQ4HKAM-3XB4YQB")
        (mkDevice "smi-iphone" "100.64.0.4"
          "JL6JUVM-ULRQMSV-2DKM6HP-YCRJKU4-SDLAS6H-FSMLWB2-7Z5C74R-CWDSJQQ"
        )
      ];
      folders = builtins.listToAttrs (
        map (f: {
          name = f.name;
          value = mkFolderValue f;
        }) folderDefs
      );
      folderDefs = [
        {
          name = "keepassxc";
          keepDays = "14";
        }
        {
          name = "obsidian-vault";
          keepDays = "5";
          customPath = "~/Sync/Sami Arda's Vault";
        }
      ];
    in
    {
      enable = true;
      settings = {
        options = syncthingOptions;
        devices = devices;
        folders = folders;
      };
    };
}
