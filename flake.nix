{
  description = "DesktopPet development environment";

  inputs.nixpkgs.url =
    "tarball+https://github.com/NixOS/nixpkgs/archive/e7fccb1ad3ed.tar.gz";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };

      qt = pkgs.kdePackages;
      qtVersion = qt.qtbase.version;

      qtEnv = qt.env "desktop-pet-qt-${qtVersion}" [
        qt.qtbase
        qt.qtdeclarative
      ];

    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          #IDE
          pkgs.qtcreator

          # Qt
          qtEnv

          # Build tools
          pkgs.cmake
          pkgs.ninja
          pkgs.pkg-config

          # C++ compiler and debugger
          pkgs.gcc
          pkgs.gdb

          # OpenGL development files (headers, libOpenGL/libGLX, gl.pc)
          pkgs.libglvnd
        ];

        shellHook = ''
          export CMAKE_PREFIX_PATH="${qtEnv}''${CMAKE_PREFIX_PATH:+:$CMAKE_PREFIX_PATH}"
          export QML2_IMPORT_PATH="${qtEnv}/lib/qt-6/qml''${QML2_IMPORT_PATH:+:$QML2_IMPORT_PATH}"
          export QT_PLUGIN_PATH="${qtEnv}/lib/qt-6/plugins''${QT_PLUGIN_PATH:+:$QT_PLUGIN_PATH}"

          echo "=================================="
          echo " DesktopPet Development Environment"
          echo " Qt: ${qtVersion}"
          echo "=================================="
        '';
      };
    };
}
