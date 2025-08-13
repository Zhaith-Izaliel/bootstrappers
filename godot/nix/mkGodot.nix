{
  stdenv,
  godot_4,
  copyDesktopItems,
  godot_4-export-templates,
  lib,
}: {
  pname,
  version,
  src,
  preset,
  desktopItems ? [],
  exportMode ? "release", # release / debug / pack
}: let
  exportMode' = lib.optionalString (lib.assertOneOf "exportMode" exportMode ["release" "debug" "pack"]) exportMode;
  templatesVersion = builtins.replaceStrings ["-"] ["."] (lib.getVersion godot_4.name);
in
  stdenv.mkDerivation {
    inherit pname version src desktopItems;

    buildInputs = [
      copyDesktopItems
      godot_4
    ];

    postPatch = ''
      patchShebangs scripts
    '';

    buildPhase = ''
      runHook preBuild

      export HOME=$TMPDIR

      # Remove custom_template path if it doesn't point to the nix store
      sed -i -e \
        '/custom_template/!b' -e '/\/nix\/store/b' -e 's/"[^"]*"/""/g' -e 't' \
        export_presets.cfg

      echo "${templatesVersion}"
      mkdir -p $HOME/.local/share/godot/export_templates/
      ln -s ${godot_4-export-templates} $HOME/.local/share/godot/export_templates/${templatesVersion}

      mkdir -p $out/share/${pname}
      godot4 --headless --export-${exportMode'} "${preset}" \
        $out/share/${pname}/${pname}

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      platform=$(awk -F'=' '
          $1 == "name" && $2 == "\"${preset}\"" {
              getline;
              if ($1 == "platform") {
                  gsub(/"/, "", $2);
                  print $2;
                  exit;
              }
          }' export_presets.cfg)


      mkdir -p $out/bin
      ln -s $out/share/${pname}/${pname} $out/bin

      if [ "$platform" == "Linux/X11" ]; then
        patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 \
          $out/share/${pname}/${pname}
      elif [ "$platform" == "Windows Desktop" ]; then
        mv $out/share/${pname}/${pname} $out/share/${pname}/${pname}.exe
      fi

      runHook postInstall
    '';
  }
