{ pkgs }:
let
  inherit (pkgs.lib) types mkOption mkEnableOption;
in
{
  services.denopsSharedServer = {
    enable = mkEnableOption "enable denops-shared-server";
    package = mkOption {
      type = types.package;
      default = pkgs.deno;
    };
    port = mkOption {
      type = types.int;
      default = 32123;
    };
    hostName = mkOption {
      type = types.str;
      default = "127.0.0.1";
    };
    denoArgs = mkOption {
      type = with types; listOf str;
      default = [
        "-A"
        "--no-lock"
      ];
    };
  };
}
