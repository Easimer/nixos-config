{ }:
{
  DisableTelemetry = true;
  DisableFirefoxStudies = true;
  DisablePocket = true;

  GenerativeAI = {
    Enabled = false;
    Chatbot = false;
    LinkPreviews = false;
    TabGroups = false;
  };

  FirefoxHome = {
    SponsoredTopSites = false;
  };

  "3rdparty" = {
    Extensions = {
      "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        environment = {
          base = "https://vault.easimer.net";
        };
      };
    };
  };

  ExtensionSettings = {
    "*".installation_mode = "blocked";
    "uBlock0@raymondhill.net" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      installation_mode = "force_installed";
      private_browsing = true;
      default_area = "menupanel";
    };
    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
      installation_mode = "force_installed";
      private_browsing = true;
      default_area = "navbar";
    };
    "{6b733b82-9261-47ee-a595-2dda294a4d08}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/yomitan/latest.xpi";
      installation_mode = "force_installed";
      private_browsing = true;
      default_area = "menupanel";
    };
    "{3f1aff6b-0363-410f-b81b-9a286ffb4b10}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/have-a-fox-dream/latest.xpi";
      installation_mode = "force_installed";
      private_browsing = true;
      default_area = "menupanel";
    };
  };
}
