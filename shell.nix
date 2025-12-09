{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python3
    pkgs.watchexec
  ];

  shellHook = ''
    echo "🎨 Blog environment ready!"
    
    echo ""
    echo "Available commands:"
    echo "  ./serve.sh              - Serve _site/ with auto-rebuild"
    echo "  ./build.sh              - Generate HTML files with avon"
    echo "  ./deploy.sh             - Build and push _site/ to gh-pages branch"
    echo ""
  '';
}

