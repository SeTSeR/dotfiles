self: old:
let
  imports = import ../nix/sources.nix;
  cacosPkg = { gcc8Stdenv, fetchgit, pkgconfig, boost, cmake, curl, gcc8, git }:
  let
    boostpkg = boost.override { enableStatic = true; };
    stdenv = gcc8Stdenv;
  in stdenv.mkDerivation rec {
    name = "cacos";

    src = fetchgit {
      url = "https://github.com/BigRedEye/cacos";
      rev = "v1.0.0";
      sha256 = "0av84475dxamvmf8slqp2h6p2y4j08nm94qjc6rvxcqbp54bn1zi";
      fetchSubmodules = true;
    };

    nativeBuildInputs = [ cmake pkgconfig ];
    buildInputs = [ boostpkg curl gcc8 git ];

    cmakeFlags = [ "-DCMAKE_USE_CONAN=OFF -DCMAKE_BUILD_TYPE=Release" ];

    enableParallelBuilding = true;

    meta = {
      homepage = "https://github.com/BigRedEye/cacos";
      description = "Ejudge client and local testing system";
      license = stdenv.lib.licenses.mit;
    };
  };

  # https://gitlab.com/rycee/nur-expressions/blob/master/pkgs/firefox-addons/default.nix
  buildFirefoxXpiAddon =
  { pname, version, addonId, url, sha256, meta, ... }:
  { stdenv, fetchurl }:
      stdenv.mkDerivation {
        name = "${pname}-${version}";

        inherit meta;

        src = fetchurl {
          inherit url sha256;
        };

        preferLocalBuild = true;
        allowSubstitutes = false;

        buildCommand = ''
          dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
          mkdir -p "$dst"
          install -v -m644 "$src" "$dst/${addonId}.xpi"
        '';
      };

  # https://github.com/wiedzmin/nixos-config/blob/999e2c67e5d203771467c6c5ff2436b49aec6385/nix/firefox-addons/default.nix
  buildFirefoxXpiAddonFromArchPkg = { pname, version, addonId, url, sha256, meta, ... }:
  { stdenv, fetchurl }:
    stdenv.mkDerivation {
      name = "${pname}-${version}";

      inherit meta;

      src = fetchurl { inherit url sha256; };

      sourceRoot = ".";

      preferLocalBuild = true;
      allowSubstitutes = false;

      installPhase = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$sourceRoot/usr/lib/firefox/browser/extensions/${addonId}.xpi" "$dst/${addonId}.xpi"
      '';
    };

  bitwardenPkg = buildFirefoxXpiAddon {
    pname = "bitwarden";
    version = "1.4.2.2";
    addonId = "hello@bitwarden.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/3475993/bitwarden_free_password_manager-1.42.2-an+fx.xpi?src=";
    sha256 = "0bnlj6cf7hrdmd5wr9lgh4fk8x90zqxbwvxkjg6cywkplcnl0byx";
    meta = with self.stdenv.lib; {
      homepage = "bitwarden.com";
      description = "A secure and free password manager for all of your devices.";
      platforms = platforms.all;
    };
  };

  seleniumPkg = buildFirefoxXpiAddon {
    pname = "selenium-ide";
    version = "3.16.1";
    addonId = "ide@selenium.dev";
    url = "https://addons.mozilla.org/firefox/downloads/file/3459412/selenium_ide-3.16.1-fx.xpi?src=";
    sha256 = "0hxrcf3gnyknxpcn8zrgik7lh8yglkjj52fcv96k1vrkww20v2k8";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/SeleniumHQ/selenium-ide";
      description = "Selenium IDE is an integrated development environment for Selenium tests. It is implemented as a Firefox extension, and allows you to record, edit, and debug tests.";
      license = licenses.gpl2;
      platforms = platforms.all;
    };
  };

  tridactylPkg = buildFirefoxXpiAddonFromArchPkg rec {
    pname = "tridactyl";
    version = "1.17.1-1";
    addonId = "tridactyl.vim@cmcaine.co.uk";
    url = "https://archive.archlinux.org/packages/f/firefox-tridactyl/firefox-tridactyl-${version}-any.pkg.tar.xz";
    sha256 = "174jkqq1pmma70is1b6xksc267wjqaf9xlijgg8mrqjj8bb4b6z0";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/tridactyl/tridactyl";
      description = "Vim, but in your browser. Replace Firefox's control mechanism with one modelled on Vim.";
      license = licenses.asl20;
      platforms = platforms.all;
    };
  };

  tstPkg = buildFirefoxXpiAddon {
    pname = "treestyletab";
    version = "3.3.6";
    addonId = "treestyletab@piro.sakura.ne.jp";
    url = "https://addons.mozilla.org/firefox/downloads/file/3511277/tree_style_tab_-3.3.6-fx.xpi?src=";
    sha256 = "09849frhc12w94ig7m405lrgcmr434a6204dazg4nmrmh8rckizr";
    meta = with self.stdenv.lib; {
      homepage = "https://piro.sakura.ne.jp/xul/_treestyletab.html.en";
      description = "Show tabs like a tree.";
      license = licenses.gpl2;
      platforms = platforms.all;
    };
  };

  ublockPkg = buildFirefoxXpiAddon {
    pname = "ublock-origin";
    version = "1.25.0";
    addonId = "uBlock0@raymondhill.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/3509800/ublock_origin-1.25.0-an+fx.xpi?src=";
    sha256 = "0pyna4c2b2ffh8ifjj4c8ga9b73g37pk432nyinf8majyb1fq6rc";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/gorhill/uBlock#ublock-origin";
      description = "Finally, an efficient blocker. Easy on CPU and memory.";
      license = licenses.gpl3;
      platforms = platforms.all;
    };
  };

  uMatrixPkg = buildFirefoxXpiAddon {
    pname = "umatrix";
    version = "1.4.0";
    addonId = "uMatrix@raymondhill.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/3396815/umatrix-1.4.0-an+fx.xpi?src=search";
    sha256 = "1ixz5j432rhwiqs91i3qh30s3ss30zv0l08apjibhwj1qsjhy7wr";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/gorhill/uMatrix";
      description = "Point & click to forbid/allow any class of requests made by your browser. Use it to block scripts, iframes, ads, facebook, etc.";
      license = licenses.gpl3;
      platforms = platforms.all;
    };
  };
  jitsiDrv = { makeDesktopItem }:
  old.jitsi.overrideAttrs (oldAttrs: {
    jitsiItem = makeDesktopItem {
      name = "Jitsi";
      exec = "jitsi";
      comment = "VoIP and Instant Messaging client";
      desktopName = "Jitsi";
      genericName = "Instant Messaging";
      categories = "Network;";
    };
  });
in {
  cacos = self.pkgs.callPackage cacosPkg { };

  tdesktopWideBaloons = old.tdesktop.overrideAttrs (oldAttrs: {
    patches = [
      "${
        builtins.fetchGit {
          url = "https://github.com/msva/mva-overlay";
          rev = "e5121619c9814b36284146dbe3dae92cf41a7c25";
        }
      }/net-im/telegram-desktop/files/patches/9999/conditional/wide-baloons/0001_baloons-follows-text-width-on-adaptive-layout.patch"
    ] ++ oldAttrs.patches;
  });

  bitwarden = self.callPackage bitwardenPkg {};
  selenium = self.callPackage seleniumPkg {};
  treestyletab = self.callPackage tstPkg {};
  tridactyl = self.callPackage tridactylPkg {};
  ublock = self.callPackage ublockPkg {};
  umatrix = self.callPackage uMatrixPkg {};
  jitsi = self.callPackage jitsiDrv {};
  inherit (import imports.niv {}) niv;
  stable = import imports.nixpkgs-stable { config.allowUnfree = true; };
}
