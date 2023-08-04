{ pkgs, ... }:
let
  mpv = "${pkgs.mpv}/bin/mpv";
  glow = "${pkgs.glow}/bin/glow";
  pandoc = "${pkgs.pandoc}/bin/pandoc";
in
{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    browser = "${pkgs.firefox}/bin/firefox";
    urls = [
      {
        url = "https://hnrss.org/newest";
        title = "Hacker News";
        tags = [ "tech" ];
      }

      # Reddit
      {
        url = "https://www.reddit.com/r/neovim/.rss";
        title = "/r/neovim";
        tags = [ "neovim" "reddit" ];
      }

      # Youtube
      {
        title = "Computerphile";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9-y-6csu5WGm29I7JiwpnA";
        tags = [ "tech" "youtube" ];
      }

      { tags = ["jobs"]; url = "https://www.kyb.tuebingen.mpg.de/feeds/jobs.rss"; }
      { tags = ["jobs"]; url = "https://www.ab.mpg.de/feeds/jobs.rss"; }
      { tags = ["jobs"]; url = "https://www.cbs.mpg.de/feeds/jobs.rss"; }
      { tags = ["jobs"]; url = "https://www.ds.mpg.de/feeds/jobs.rss"; }
      { tags = ["jobs"]; url = "https://www.social.mpg.de/feeds/jobs.rss"; }
    ];
    extraConfig = ''
      # misc
      refresh-on-startup yes

      # display
      feed-sort-order unreadarticlecount-asc
      text-width      72

      # unbind keys
      unbind-key ENTER
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K

      # bind keys - vim style
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit
      bind-key g home
      bind-key G end

      # colorscheme
      color listnormal        white black
      color listnormal_unread white black
      color listfocus         white black bold reverse
      color listfocus_unread  white black bold reverse
      color info              white black reverse bold
      color background        white black
      color article           white black

      html-renderer "${pandoc} --from=html -t markdown_github-raw_html"
      pager "${glow} --pager --width 72"

      # macros
      macro v set browser "${mpv} %u" ; open-in-browser ; set browser "firefox %u" -- "Open video on mpv"
    '';
  };
}
