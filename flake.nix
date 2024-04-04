{
  description = "Mikko Räsänen's NixOS configuration";

  inputs = {
    nixos-stable.url = github:nixos/nixpkgs/nixos-23.11;
    nixos-unstable.url = github:NixOS/nixpkgs/nixos-unstable;

    nixpkgs.follows = "nixos-unstable";

    # a collection of NixOS modules covering hardware quirks
    nixos-hardware.url = github:NixOS/nixos-hardware/master;

    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixos-unstable";

    hyprland.url = github:hyprwm/Hyprland;

    nixos-wsl.url = github:nix-community/NixOS-WSL;
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs: {
    nixosConfigurations  = {
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.wsl
        
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./configuration.nix
        ];
      };
    };
  };
}
