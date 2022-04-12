{ config }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  "*" = {
    al = mkLiteral "#00000000";
    fg = mkLiteral "${config.colors.foreground}";
    bg = mkLiteral "${config.colors.background}";
    ac = mkLiteral "${config.colors.color12}";
  };

  "window" = {
    transparency = "real";
    background-color = mkLiteral "@bg";
    text-color = mkLiteral "@fg";
    border = mkLiteral "0px";
    border-color = mkLiteral "@ac";
    border-radius = mkLiteral "0px";
    width = mkLiteral "35%";
    location = mkLiteral "center";
    x-offset = 0;
    y-offset = 0;
  };

  "prompt" = {
    enabled = true;
    padding = mkLiteral	"0.30% 1% 0% -0.5%";
    background-color = mkLiteral "@al";
    text-color= mkLiteral "@bg";
  };

  "entry" = {
    background-color = mkLiteral "@al";
    text-color = mkLiteral "@bg";
    placeholder-color = mkLiteral "@bg";
    expand = true;
    horizontal-align = 0;
    placeholder = "Search";
    padding = mkLiteral "0.10% 0% 0% 0%";
    blink = true;
  };

  "inputbar" = {
	  children = mkLiteral "[ prompt, entry ]";
    background-color = mkLiteral "@fg";
    text-color = mkLiteral "@bg";
    expand = false;
	  border = mkLiteral "0% 0% 0% 0%";
    border-radius = mkLiteral "0px";
	  border-color = mkLiteral "@ac";
    margin = mkLiteral "0% 0% 0% 0%";
    padding = mkLiteral "1.5%";
  };

  "listview" = {
    background-color = mkLiteral "@al";
    padding = mkLiteral "10px";
    columns = 2;
    lines = 10;
    spacing = mkLiteral "0%";
    cycle = false;
    dynamic = true;
    layout = mkLiteral "vertical";
  };

  "mainbox" = {
    background-color = mkLiteral "@al";
	  border = mkLiteral "0% 0% 0% 0%";
    border-radius = mkLiteral "0% 0% 0% 0%";
	  border-color = mkLiteral "@ac";
    children = mkLiteral "[ inputbar, listview ]";
    spacing = mkLiteral "0%";
    padding = mkLiteral "0%";
  };

  "element" = {
    background-color = mkLiteral "@al";
    text-color = mkLiteral "@fg";
    orientation = mkLiteral "horizontal";
    border-radius = mkLiteral "0%";
    padding = mkLiteral "1% 0.5% 1% 0.5%";
  };

  "element-icon" = {
    background-color = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
    horizontal-align = mkLiteral "0.5";
    vertical-align = mkLiteral "0.5";
    size = mkLiteral "24px";
    border = mkLiteral "0px";
  };

  "element-text" = {
    background-color= mkLiteral	"@al";
    text-color =	mkLiteral	"inherit";
    expand = true;
    horizontal-align = 0;
    vertical-align = mkLiteral "0.5";
    margin = mkLiteral "0% 0.25% 0% 0.25%";
  };

  "element selected" = {
    background-color = mkLiteral "@ac";
    text-color = mkLiteral "@bg";
    border = mkLiteral "0% 0% 0% 0%";
    border-radius = mkLiteral "0px";
    border-color = mkLiteral "@bg";
  };

}

