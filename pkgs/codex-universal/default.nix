{
  pkgs,
  containerPkgs,
  openai-responses,
  ollama,
  spec-kit,
  ...
}:
let
  inherit (pkgs) symlinkJoin;
  inherit
    (import ./codex-universal.nix {
      inherit
        pkgs
        containerPkgs
        openai-responses
        ollama
        ;
    })
    codex-log
    codex-enter
    codex-start
    ;
in
symlinkJoin {
  name = "codex-universal";
  paths = with pkgs; [
    codex
    codex-log
    codex-enter
    codex-start
    spec-kit
    ollama
    podman
  ];
}
