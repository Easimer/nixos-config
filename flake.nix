{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    nixpkgs-26-05.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager-26-05.url = "github:nix-community/home-manager/release-26.05";
    home-manager-26-05.inputs.nixpkgs.follows = "nixpkgs-26-05";

    pomodoro = {
      url = "git+https://git.easimer.net/easimer/pomodoro.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      vscode-server,
      nixpkgs-26-05,
      home-manager-26-05,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      add-home = {
        imports = [ home-manager.nixosModules.home-manager ];
        config = {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs outputs; };
          home-manager.users.easimer = import ./home;
        };
      };
      add-home-26-05 = {
        imports = [ home-manager-26-05.nixosModules.home-manager ];
        config = {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs outputs; };
          home-manager.users.easimer = import ./home;
        };
      };
    in
    {
      nixosConfigurations = {
        zen-hyperv = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/zen-hyperv
            add-home
          ];
        };
        hell-hyperv = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/hell-hyperv
            add-home
          ];
        };
        blin = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t440s
            ./hosts/blin
            add-home
          ];
        };
        frost = nixpkgs-26-05.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t14
            ./hosts/frost
            add-home-26-05
          ];
        };
      };
      homeConfigurations = {
        home = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home
          ];
        };
      };
    };
}
