{inputs, ...}: final: prev: {
  sf-mono-liga = prev.stdenvNoCC.mkDerivation rec {
    pname = "sf-mono-liga";
    version = "dev";
    src = inputs.sf-mono-liga-src;
    dontConfigure = true;
    installPhase = ''
      mkdir -p $out/share/fonts/opentype
      cp -R $src/*.otf $out/share/fonts/opentype/
    '';
  };
}
