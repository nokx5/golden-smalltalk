{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

with pkgs;
assert hostPlatform.isx86_64;

let
  mkCustomShell = mkShell.override { stdenv = stdenvNoCC; };

  vscodeExt = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      bbenoist.nix
      eamodio.gitlens
    ] ++
    vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "emacs-mcx";
        publisher = "tuttieee";
        version = "0.31.0";
        sha256 = "McSWrOSYM3sMtZt48iStiUvfAXURGk16CHKfBHKj5Zk=";
      }
    ];
  };

in
mkShell {
  buildInputs = [ gnu-smalltalk ] ++ lib.optionals (hostPlatform.isLinux) [ glibcLocales ];
  nativeBuildInputs = [
    bashCompletion
    bashInteractive
    cacert
    git
    gnumake
    nixpkgs-fmt
  ] ++ lib.optionals (hostPlatform.isLinux) [ emacs-nox vscodeExt ];

  LANG = "en_US.UTF-8";

  shellHook = ''
    export HOME=$(pwd)
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
  '';
}
