{ pkgs, ... }:
let
  inherit (pkgs) writeShellApplication symlinkJoin;
  spec-kit = pkgs.stdenv.mkDerivation {
    name = "spec-kit";
    src = pkgs.fetchFromGitHub {
      owner = "github";
      repo = "spec-kit";
      rev = "v0.0.51";
      hash = "sha256-7Co59ZrGpTkLI1s3XFsoai1Cx84rzqkz46EiajO5kwY=";
    };
    buildInputs = with pkgs; [
      git
      python3Minimal
      uv
    ];
    dontPatchShebangs = true;
    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/specify
      cp -R ./* $out/share/specify

      runHook postInstall
    '';
  };
  specify-init = writeShellApplication {
    name = "specify-init";
    runtimeInputs = with pkgs; [
      uv
      git
    ];
    text = ''
      uvx --from file://${spec-kit}/share/specify specify init --ai codex --script sh --ignore-agent-tools "$@"
    '';
  };
in
symlinkJoin {
  name = "spec-kit";
  paths = [
    spec-kit
    specify-init
    pkgs.uv
  ];
}
