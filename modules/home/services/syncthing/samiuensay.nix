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
          "EFWFRV4-W6XLNXE-GVNV47A-VB63EZX-AENVBWS-F22VO42-DR4PF5O-PZIVBQE"
        )
        (mkDevice "smi-mac" "100.64.0.2" "L7QG4FE-WLUOWV7-B7VJNWK-GMZCWIT-S2ZPN6L-XPHUI4B-RQ4HKAM-3XB4YQB")
        (mkDevice "smi-iphone" "100.64.0.3"
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
