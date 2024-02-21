{ pkgs, ...}:

let
  acPath = "/sys/class/power_supply/AC";
  bat0Path = "/sys/class/power_supply/BAT0";
  bat1Path = "/sys/class/power_supply/BAT1";
  catCmd = "/run/current-system/sw/bin/cat";
in
  pkgs.writeShellScriptBin "batterycomb" ''
  ac=0
  battery_level_0=0
  battery_level_1=0
  battery_max_0=0
  battery_max_1=0

  if [ -f "${acPath}/online" ]; then
      ac=$(${catCmd} "${acPath}/online")
  fi

  if [ -f "${bat0Path}/energy_now" ]; then
      battery_level_0=$(${catCmd} "${bat0Path}/energy_now")
  fi

  if [ -f "${bat0Path}/energy_full" ]; then
      battery_max_0=$(${catCmd} "${bat0Path}/energy_full")
  fi

  if [ -f "${bat1Path}/energy_now" ]; then
      battery_level_1=$(${catCmd} "${bat1Path}/energy_now")
  fi

  if [ -f "${bat1Path}/energy_full" ]; then
      battery_max_1=$(${catCmd} "${bat1Path}/energy_full")
  fi

  battery_level=$(("$battery_level_0 + $battery_level_1"))
  battery_max=$(("$battery_max_0 + $battery_max_1"))

  battery_percent=$(("$battery_level * 100"))
  battery_percent=$(("$battery_percent / $battery_max"))

  if [ "$ac" -eq 1 ]; then
      icon="󰂄"
      echo "$icon $battery_percent%"
  else
      if [ "$battery_percent" -eq 100 ]; then
          icon="󰁹"
      elif [ "$battery_percent" -gt 90 ]; then
          icon="󰂂"
      elif [ "$battery_percent" -gt 80 ]; then
          icon="󰂁"
      elif [ "$battery_percent" -gt 70 ]; then
          icon="󰂀"
      elif [ "$battery_percent" -gt 60 ]; then
          icon="󰁿"
      elif [ "$battery_percent" -gt 50 ]; then
          icon="󰁾"
      elif [ "$battery_percent" -gt 40 ]; then
          icon="󰁽"
      elif [ "$battery_percent" -gt 30 ]; then
          icon="󰁼"
      elif [ "$battery_percent" -gt 20 ]; then
          icon="󰁻"
      elif [ "$battery_percent" -gt 10 ]; then
          icon="󰁺"
      else
          icon=""
      fi

      echo "$icon $battery_percent%"
  fi
''
