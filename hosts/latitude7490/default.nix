{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system
    ../../modules/system/user.nix
    ../../modules/security
    ../../modules/desktop
    ../../modules/development
  ];

  fileSystems."/data" = {
    device = "/dev/disk/by-label/DATA";

    fsType = "exfat";

    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "nofail"
      "x-systemd.device-timeout=5s"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.sammy = import ../../home;
  };
}
