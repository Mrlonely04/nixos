{
   programs.virt-manager.enable = true;
   
   users.groups.libvirtd.members = ["nykta"];

   virtualisation.libvirtd.enable = true;

   virtualisation.spiceUSBRedirection.enable = true;
}
