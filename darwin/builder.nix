{ ... }: {
  nix.linux-builder.enable = true;
  nix.linux-builder.maxJobs = 8;
  nix.linux-builder.config = {
    virtualisation.darwin-builder.diskSize = 60 * 1024;
    virtualisation.darwin-builder.memorySize = 16 * 1024;
    virtualisation.cores = 8;
  };

  launchd.daemons.linux-builder.serviceConfig = {
    StandardOutPath = "/var/log/linux-builder.log";
    StandardErrorPath = "/var/log/linux-builder.log";
  };

}
