# nur-packages

**mtanda [NUR](https://github.com/nix-community/NUR) repository**

![Build](https://github.com/mtanda/nur-packages/workflows/Build/badge.svg)

## Packages

<!-- packages-table-start -->
| Package | Version | Description |
|---------|---------|-------------|
| difit | v5.0.6 | A lightweight CLI tool to display Git diffs in GitHub-style web viewer |
<!-- packages-table-end -->

## Usage

Add this repository to your flake inputs:

```nix
{
  inputs.nur-packages = {
    url = "github:mtanda/nur-packages";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

Then use the packages:

```nix
home.packages = [
  inputs.nur-packages.packages.${system}.difit
];
```
