{
  pkgs,
  lib,
  hostname,
  ...
}:
{
  imports = lib.optionals pkgs.stdenv.isDarwin [ ./macos-hotfix.nix ];

  programs.firefox = {
    enable = true;
    package = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux pkgs.firefox)
      (lib.mkIf pkgs.stdenv.isDarwin null)
    ];

    policies = {
      ExtensionSettings =
        with builtins;
        let
          extension = shortId: extensionId: {
            name = extensionId;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
        listToAttrs [
          # shortId: firefox extension store url;
          # extensionId: get by visiting "about:debugging#/runtime/this-firefox";
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org")
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
          (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
        ];
    };

    profiles.samiuensay =
      let
        profileSettings = {
          "identity.fxaccounts.account.device.name" = hostname;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.main.tools" = "syncedtabs,history,bookmarks";
          "sidebar.visibility" = "always";
          "content.notify.interval" = 100000;
          "gfx.canvas.accelerated.cache-size" = 512;
          "gfx.content.skia-font-cache-size" = 20;
          "browser.cache.disk.enable" = false;
          "browser.sessionhistory.max_total_viewers" = 4;
          "media.memory_cache_max_size" = 65536;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "image.mem.decode_bytes_at_a_time" = 32768;
          "network.trr.mode" = 3;
          "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
          "network.cookie.cookieBehavior" = 1;
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.enabled" = false;
          "network.dnsCacheExpiration" = 3600;
          "network.ssl_tokens_cache_capacity" = 10240;
          "network.http.speculative-parallel-limit" = 0;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.places.speculativeConnect.enabled" = false;
          "network.prefetch-next" = false;
          "network.predictor.enabled" = false;
          "layout.spellcheckDefault" = 0;
          "layout.css.grid-template-masonry-value.enabled" = true;
          "browser.contentblocking.category" = "custom";
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.allow_list.baseline.enabled" = true;
          "privacy.trackingprotection.allow_list.convenience.enabled" = true;
          "privacy.fingerprintingProtection" = true;
          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          "privacy.globalprivacycontrol.enabled" = true;
          "privacy.userContext.enabled" = true;
          "dom.security.https_only_mode" = true;
          "security.OCSP.enabled" = 0;
          "security.pki.crlite_mode" = 2;
          "security.csp.reporting.enabled" = false;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.tls.enable_0rtt_data" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "browser.sessionstore.interval" = 60000;
          "browser.startup.page" = 3;
          "browser.privatebrowsing.resetPBM.enabled" = true;
          "privacy.history.custom" = true;
          "browser.urlbar.trimHttps" = true;
          "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "browser.search.suggest.enabled" = true;
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.groupLabels.enabled" = false;
          "browser.formfill.enable" = false;
          "network.IDN_show_punycode" = true;
          "signon.autofillForms" = false;
          "signon.rememberSignons" = false;
          "signon.formlessCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;
          "signon.generation.enabled" = false;
          "signon.management.page.breach-alerts.enabled" = false;
          "signon.firefoxRelay.feature" = "disabled";
          "network.auth.subresource-http-auth-allow" = 1;
          "editor.truncate_user_pastes" = false;
          "security.mixed_content.block_display_content" = true;
          "pdfjs.enableScripting" = false;
          "extensions.enabledScopes" = 5;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "privacy.userContext.ui.enabled" = true;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "permissions.default.desktop-notification" = 2;
          "permissions.default.geo" = 2;
          "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
          "browser.search.update" = false;
          "permissions.manager.defaultsUrl" = "";
          "extensions.getAddons.cache.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "datareporting.usage.uploadEnabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.aboutwelcome.enabled" = false;
          "browser.profiles.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.compactmode.show" = true;
          "browser.privateWindowSeparation.enabled" = false;
          "browser.ml.enable" = false;
          "browser.ml.chat.enabled" = false;
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.timeout" = 0;
          "browser.urlbar.trending.featureGate" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
          "extensions.pocket.enabled" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "browser.download.manager.addToRecentDocs" = false;
          "browser.download.open_pdf_attachments_inline" = true;
          "browser.bookmarks.openInTabClosesMenu" = false;
          "browser.menu.showViewImageInfo" = true;
          "findbar.highlightAll" = true;
          "layout.word_select.eat_space_to_next_word" = false;
          "apz.overscroll.enabled" = true;
          "general.smoothScroll" = true;
          "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
          "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = "2";
          "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
          "general.smoothScroll.currentVelocityWeighting" = "1";
          "general.smoothScroll.stopDecelerationWeighting" = "1";
          "mousewheel.default.delta_multiplier_y" = 200;
        };
      in
      {
        id = 0;
        name = "samiuensay";
        isDefault = true;
        bookmarks = [
          {
            name = "Proton Mail";
            url = "https://mail.proton.me";
            keyword = "";
          }
        ];
        settings = profileSettings;
        search = {
          default = "ddg";
          privateDefault = "ddg";
          engines = {
            nix-packages = {
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            bing.metaData.hidden = true;
            ecosia.metaData.hidden = true;
            wikipedia.metaData.hidden = true;
            google.metaData.alias = "@g";
          };
          force = true;
        };
      };
  };
}
