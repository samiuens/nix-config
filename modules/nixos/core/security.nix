{
  services.pcscd.enable = true; # enable support for yubikey
  security.pam.services.login.enableGnomeKeyring = true;
}
