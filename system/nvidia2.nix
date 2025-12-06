{
  lib,
  ...
}:

{
  hardware.nvidia.prime = {
    intelBusId = lib.mkForce "PCI:0:2:0";
    nvidiaBusId = lib.mkForce "PCI:2:0:0";

    sync = true;
  };
}
