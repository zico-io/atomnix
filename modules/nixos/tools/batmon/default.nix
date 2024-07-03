{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.batmon;
in {
  options.atomnix.tools.batmon = with types; {
    enable = mkBoolOpt false "Enable battery monitor daemon?";
  };

  config = mkIf cfg.enable {
    systemd.user.services.battery_monitor = {
      wants = ["display-manager.service"];
      wantedBy = ["graphical-session.target"];
      script = ''
        prev_val=100
        check () { [[ $1 -ge $val ]] && [[ $1 -lt $prev_val ]]; }
        notify () {
          ${pkgs.libnotify}/bin/notify-send -a Battery "$@" \
            -h "int:value:$val" "Discharging" "$val%, $remaining"
        }
        while true; do
          IFS=: read _ bat0 < <(${pkgs.acpi}/bin/acpi -b)
          IFS=\ , read status val remaining <<<"$bat0"
          val=''${val%\%}
          if [[ $status = Discharging ]]; then
            echo "$val%, $remaining"
            if check 30 || check 25 || check 20; then notify
            elif check 15 || [[ $val -le 10 ]]; then notify -u critical
            fi
          fi
          prev_val=$val
          # Sleep longer when battery is high to save CPU
          if [[ $val -gt 30 ]]; then sleep 10m; elif [[ $val -ge 20 ]]; then sleep 5m; else sleep 1m; fi
        done
      '';
    };
  };
}
