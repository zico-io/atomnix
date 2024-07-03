{
  lib,
  config,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.hardware.audio;
in {
  options.atomnix.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable audio?";
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
