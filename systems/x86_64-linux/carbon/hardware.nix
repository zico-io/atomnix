{
  config,
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod" "thinkpad_acpi"];
      # verbose = false;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = ["kvm-intel"];
    # kernelParams = ["quiet" "ude.log_priority=3"];
    # consoleLogLevel = 3;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c5d16234-e171-40b9-9c60-1a6cb8294b5f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5872-2460";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
