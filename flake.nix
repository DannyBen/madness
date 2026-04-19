{
  description = "Instant Markdown Server";

  inputs = {
    nixpkgs.url = "nixpkgs";
    ruby-nix.url = "github:bobvanderlinden/nixpkgs-ruby";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ruby-nix, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        ruby = ruby-nix.packages.${system}."ruby-3.2";

        buildDeps = with pkgs; [
          gcc
          gnumake
          pkg-config
          openssl
          libyaml
          zlib
          readline
        ];

        gems = pkgs.bundlerEnv {
          name = "madness-gems";
          inherit ruby;
          gemdir = self;
        };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "madness";
          version = "1.2.5";
          src = self;

          nativeBuildInputs = [ pkgs.makeWrapper ];
          buildInputs = [ gems ruby ];

          installPhase = ''
            mkdir -p $out/lib/madness $out/bin
            cp -r lib app bin Gemfile Gemfile.lock madness.gemspec $out/lib/madness/

            makeWrapper ${gems.wrappedRuby}/bin/ruby $out/bin/madness \
              --add-flags "-I$out/lib/madness/lib $out/lib/madness/bin/madness"
          '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [ ruby pkgs.bundix ] ++ buildDeps;

          shellHook = ''
            export GEM_HOME="$PWD/.gems"
            export GEM_PATH="$GEM_HOME"
            export PATH="$GEM_HOME/bin:$PATH"
            mkdir -p "$GEM_HOME"
          '';
        };
      });
}
