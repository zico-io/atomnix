{
  description = "atomNix flake config.";

  nixConfig = {
    extra-substituters = ["https://hyprland.cachix.org"];
    extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:/nixos/nixos-hardware/master";
    snowfall-lib.url = "github:snowfallorg/lib";
    disko.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim.url = "github:zico-io/nixvim";

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "atomnix";
          title = "atomNix";
        };
        namespace = "atomnix";
      };
    };
  in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };

      overlays = with inputs; [
        # hyprland.overlays.default
        nur.overlay
      ];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.default
        impermanence.nixosModules.impermanence
        stylix.nixosModules.stylix
        nur.nixosModules.nur
      ];

      homes.modules = with inputs; [
        impermanence.nixosModules.home-manager.impermanence
        nix-colors.homeManagerModules.default
      ];
    };
}
