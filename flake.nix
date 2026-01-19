{
  description = "momemo project flake (flutter)";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];
      perSystem =
        {
          # config,
          # self',
          # inputs',
          pkgs,
          system,
          ...
        }:
        # let
        # androidComposition = pkgs.androidenv.composeAndroidPackages {
        #   cmdLineToolsVersion = "8.0";
        #   platformToolsVersion = "36.0.2";
        #   # Flutter requires Android SDK 36 and the Android BuildTools 28.0.3
        #   buildToolsVersions = [
        #     "28.0.3"
        #   ];
        #   platformVersions = [
        #     "36"
        #   ];
        #   cmakeVersions = [ "3.22.1" ];

        #   # Application Binary Interface
        #   abiVersions = [
        #     "x86_64"
        #     "armeabi-v7a"
        #     "arm64-v8a"
        #   ];

        #   includeNDK = false;
        #   includeSystemImages = true;

        #   systemImageTypes = [
        #     "default"
        #   ];
        #   includeEmulator = true;
        #   useGoogleAPIs = true;
        # };

        # androidSDK = androidComposition.androidsdk;
        # in
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            config.android_sdk.accept_license = true;
          };

          devShells.default = pkgs.mkShell {
            # Environment Variables
            # ANDROID_HOME = "${androidSDK}/libexec/android-sdk";
            # ANDROID_SDK_ROOT = "${androidSDK}/libexec/android-sdk";
            # JAVA_HOME = pkgs.jdk17.home;
            FLUTTER_ROOT = pkgs.flutter;
            DART_ROOT = "${pkgs.flutter}/bin/cache/dart-sdk";
            # GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/33.0.2/aapt2";
            # QT_QPA_PLATFORM = "wayland;xcb";
            # LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
            # pkgs.vulkan-loader
            # pkgs.libGL
            # ]}";

            # or buildInputs?
            packages =
              with pkgs;
              let
                flutter-dev-fswatcher = writeShellScriptBin "ffswatcher" ''
                  while true; do
                    find lib/ -name '*.dart' | entr -d -p kill -USR1 $(cat /tmp/momemo-flutter.pid 2>/dev/null) || true
                    sleep 0.1
                  done
                '';

                flutter-dev-run = writeShellScriptBin "frun" ''
                  flutter run --pid-file /tmp/momemo-flutter.pid
                '';
              in
              [
                # androidSDK
                flutter

                jdk17
                # qemu_kvm
                # gradle
                # libGL
                # vulkan-loader

                # File Watcher
                entr

                # Custom Scripts
                flutter-dev-run
                flutter-dev-fswatcher
              ];

            shellHook = ''
              if [ -z "$PUB_CACHE" ]; then
                export PATH="$PATH:$HOME/.pub-cache/bin"
              else
                export PATH="$PATH:$PUB_CACHE/bin"
              fi

              echo "To enable auto hot-reload on fs changes (useful when developing without IDE):" 
              echo "1. Run frun (just a flutter run alias that creates a .pid file)"
              echo "2. Run ffswatcher (in separate terminal probably)"
            '';
          };
        };
    };
}
