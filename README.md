# nur-packages

**mtanda [NUR](https://github.com/nix-community/NUR) repository**

![Build](https://github.com/mtanda/nur-packages/workflows/Build/badge.svg)

## Packages

<!-- packages-table-start -->
| Package | Version | Description |
|---------|---------|-------------|
| deck | v1.24.0 | Create presentations by combining Markdown content with Google Slides design |
| diffyml | v1.7.1 | A fast, structural YAML diff tool |
| difit | v5.0.6 | A lightweight CLI tool to display Git diffs in GitHub-style web viewer |
| fff-mcp | 0.9.6 | The fastest and most accurate file search toolkit for AI agents (MCP server) |
| github-comment | v6.3.2 | CLI to create and hide GitHub comments |
| leaf | 1.26.0 | A friendly terminal Markdown previewer |
| mo | 1.5.6 | CLI tool that opens .md files in a browser with live-reload, syntax highlighting, Mermaid and LaTeX support |
| tfcmt | v4.14.7 | Tfcmt enhances mercari/tfnotify in many ways, including Terraform >= v0.15 support and advanced formatting options |
| vde-layout | v1.1.1 | CLI that reproduces tmux or WezTerm terminal layouts from YAML presets |
| yashiki | yashiki-v0.14.0 | macOS tiling window manager daemon and CLI |
| yashiki-layout-byobu | yashiki-v0.14.0 | Accordion layout engine for yashiki |
| yashiki-layout-tatami | yashiki-v0.14.0 | Master-stack layout engine for yashiki |
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
