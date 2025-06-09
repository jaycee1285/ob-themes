{
  description = "Collection of Openbox themes by jaycee1285";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.default = pkgs.stdenvNoCC.mkDerivation {
        pname = "ob-themes";
        version = "unstable-${self.shortRev or "unknown"}";
        src = ./.;

        installPhase = ''
          mkdir -p $out/share/themes
          shopt -s dotglob
          cp -r $src/* $out/share/themes/
          shopt -u dotglob
        '';

        meta = with pkgs.lib; {
          description = "Jaycee1285 Openbox themes collection";
          homepage = "https://github.com/jaycee1285/ob-themes";
          license = licenses.gpl3Only;
          platforms = platforms.linux;
        };
      };
    };
}
