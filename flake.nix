{
  description = "DesktopPet Qt 6.12.0 development environment";

  inputs.nixpkgs.url =
    "tarball+https://github.com/NixOS/nixpkgs/archive/e7fccb1ad3ed.tar.gz";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };

      qtEnv = pkgs.qt6.env "desktop-pet-qt-6.12.0" (
        with pkgs.qt6; [
          qtbase
          qtdeclarative
        ]
      );

    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          # Qt
          qtEnv

          # IDE
          pkgs.qtcreator

          # Build tools
          pkgs.cmake
          pkgs.ninja
          pkgs.pkg-config

          # C++ compiler and debugger
          pkgs.gcc
          pkgs.gdb

          # Graphics
          pkgs.libglvnd
        ];

        shellHook = ''
          echo "=================================="
          echo " DesktopPet Development Environment"
          echo " Target Qt: 6.12.0"
          echo "=================================="
        '';
      };
    };
}
