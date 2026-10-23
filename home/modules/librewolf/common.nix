{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelementry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
      ExtensionSettings = {
        #uBlock-Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        #BitWarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/5125667/bitwarden_password_manager/latest.xpi";
          installation_mode = "force_installed";
        };
        #Improve_Youtube
        "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4884091/youtube_addon/latest.xpi";
          installation_mode = "force_installed";
        };
        #Sponser_Block
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4897574/sponsorblock/latest.xpi";
          install_mode = "force_installed";
        };
        #Qwant_Search-Engine
        "qwant-search-firefox@qwant.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4345028/qwant_the_search_engine/latest.xpi";
          install_mode = "force_installed";
        };
      };
    };
  };
  environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
}
