{ inputs, ... }:

final: prev: {
  packages.${prev.system}.default = inputs.fenix.packages.${prev.system}.minimal.toolchain;
}
