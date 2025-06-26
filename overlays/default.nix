{ inputs, ... }:
{
  modifications = final: prev: {
    helix = inputs.helix-master;
  };
}
