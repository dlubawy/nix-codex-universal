system: inputs:
let
  allPackages = {
    aarch64-darwin =
      pkgs:
      let
        openaiResponses = inputs.openai-responses.packages.aarch64-darwin.default;
        ollama = (import inputs.nixpkgs-unstable { system = "aarch64-darwin"; }).ollama;
      in
      {
        default = pkgs.callPackage ./codex-universal {
          inherit pkgs openaiResponses ollama;
          containerPkgs = (
            import inputs.nixpkgs-unstable {
              system = "aarch64-linux";
            }
          );
        };
        openai-responses = openaiResponses;
        ollama = ollama;
      };
    x86_64-darwin =
      pkgs:
      let
        openaiResponses = inputs.openai-responses.packages.x86_64-darwin.default;
      in
      {
        default = pkgs.callPackage ./codex-universal {
          inherit pkgs openaiResponses;
          containerPkgs = (
            import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
            }
          );
        };
        openai-responses = openaiResponses;
      };
    aarch64-linux =
      pkgs:
      let
        openaiResponses = inputs.openai-responses.packages.aarch64-linux.default;
      in
      {
        default = pkgs.callPackage ./codex-universal {
          inherit pkgs openaiResponses;
          containerPkgs = pkgs;
        };
        openai-responses = openaiResponses;
      };
    x86_64-linux =
      pkgs:
      let
        openaiResponses = inputs.openai-responses.packages.x86_64-linux.default;
      in
      {
        default = pkgs.callPackage ./codex-universal {
          inherit pkgs openaiResponses;
          containerPkgs = pkgs;
        };
        openai-responses = openaiResponses;
      };
  };
in
if builtins.hasAttr system allPackages then
  allPackages.${system}
else
  # TODO: make this cleaner
  pkgs:
  allPackages.aarch64-darwin pkgs
  // allPackages.x86_64-darwin pkgs
  // allPackages.aarch64-linux pkgs
  // allPackages.x86_64-linux pkgs
