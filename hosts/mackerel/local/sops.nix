{ nixpkgs, inputs, ... }: {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.sshKeyPaths = [ "/home/winter/.ssh/id_ed25519" ];

  sops.secrets.kavita_token = {
    owner = "kavita";
  };
}
