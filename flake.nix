{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    helix-editor.url = "github:easimer/helix?ref=edb9ffcf";
    helix-editor.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      vscode-server,
      helix-editor,
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
    in
    {
      nixosConfigurations = {
        zen-hyperv = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          system = "x86_64-linux";
          modules = [
            ./hosts/zen-hyperv
            add-home
          ];
        };
        hell-hyperv = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          system = "x86_64-linux";
          modules = [
            ./hosts/hell-hyperv
            add-home
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
