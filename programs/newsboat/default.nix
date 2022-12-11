{ config, pkgs, ... }:

{
  programs.newsboat = {
    enable = true;
    browser = "${pkgs.firefox}/bin/firefox";
    urls = [
        { tags = ["jobs"]; url = "https://www.kyb.tuebingen.mpg.de/feeds/jobs.rss"; }
        { tags = ["jobs"]; url = "https://www.ab.mpg.de/feeds/jobs.rss"; }
        { tags = ["jobs"]; url = "https://www.cbs.mpg.de/feeds/jobs.rss"; }
        { tags = ["jobs"]; url = "https://www.ds.mpg.de/feeds/jobs.rss"; }
        { tags = ["jobs"]; url = "https://www.social.mpg.de/feeds/jobs.rss"; }
    ];
  };
}
