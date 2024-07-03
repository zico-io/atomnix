{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [];

  boot.initrd.availableKernelModules = ["virtio_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/mnt/wsl" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/usr/lib/wsl/drivers" = {
    device = "none";
    fsType = "9p";
  };

  fileSystems."/lib/modules" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/lib/modules/5.15.146.1-microsoft-standard-WSL2" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e1cf7e89-3ce0-4088-946c-5c2a386e4f23";
    fsType = "ext4";
  };

  fileSystems."/mnt/wslg" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/mnt/wslg/distro" = {
    device = "none";
    fsType = "none";
    options = ["bind"];
  };

  fileSystems."/usr/lib/wsl/lib" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/mnt/wslg/doc" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/mnt/wslg/.X11-unix" = {
    device = "/mnt/wslg/.X11-unix";
    fsType = "none";
    options = ["bind"];
  };

  fileSystems."/mnt/c" = {
    device = "C:\134";
    fsType = "9p";
  };

  fileSystems."/mnt/d" = {
    device = "D:\134";
    fsType = "9p";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/8d1dc67e-dd3e-4e29-8f0b-67b9ed32e291";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
