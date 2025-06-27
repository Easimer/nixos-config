{
  inputs,
  ...
}:
{
  imports = [
    inputs.vscode-server.nixosModules.default
  ];

  config = {
    services.vscode-server.enable = true;
  };
}
