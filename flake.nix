{
  description = "AtomNix snowfall";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:zico-io/nixvim";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      snowfall.namespace = "atomnix";
      channels-config.allowUnfree = true;

      src = ./.;

      systems.modules.nixos = with inputs; [
        stylix.nixosModules.stylix
      ];

      # homes.modules = with inputs; [
      # ];
    };
}
