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
  join = concatStringsSep " ";
  cfg = config.services.denopsSharedServer;
in
{
  options = import ./options.nix { inherit pkgs; };

  config = mkIf cfg.enable {
    systemd.services.denopsSharedServer = {
      description = "Denops Shared Server";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Restart = "always";
        ExecStart = join (
          [
            "${getBin cfg.denoPackage}/bin/deno"
            "run"
          ]
          ++ cfg.denoArgs
          ++ [
            "${denops-vim}/${cfg.cliPath}"
            "--hostname=${cfg.hostName}"
            "--port=${toString cfg.port}"
          ]
        );
      };
    };
  };
}
