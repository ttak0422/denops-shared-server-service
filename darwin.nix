self:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf concatStringsSep getBin;
  inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) denops-vim;
  cfg = config.services.denopsSharedServer;
in
{
  options = import ./options.nix { inherit pkgs; };
  config = mkIf cfg.enable {
    launchd.user.agents.denopsSharedServer = {
      path = [ config.environment.systemPath ];
      serviceConfig = {
        ProgramArguments =
          [
            "${getBin cfg.denoPackage}/bin/deno"
            "run"
          ]
          ++ cfg.denoArgs
          ++ [
            "${denops-vim}/${cfg.cliPath}"
            "--hostname=${cfg.hostName}"
            "--port=${toString cfg.port}"
          ];
        KeepAlive = true;
        RunAtLoad = true;
      };
    };
  };
}
