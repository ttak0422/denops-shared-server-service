{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf concatStringsSep getBin;
  cfg = config.services.denopsSharedServer;
in
{
  options = import ./options.nix { inherit pkgs; };
  config = mkIf cfg.enable {
    launchd.user.agents.denopsSharedServer = {
      script = concatStringsSep " " (
        [
          "${getBin cfg.denoPackage}/bin/deno"
          "run"
        ]
        ++ cfg.denoArgs
        ++ [
          "${cfg.cliPath}"
          "--hostname=${cfg.hostName}"
          "--port=${toString cfg.port}"
        ]
      );
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
      };
    };
  };
}
