# Windows Setup

## Store packages

[Firefox](https://www.microsoft.com/store/productId/9NZVDKPMR9RD)

[Windows Terminal](https://www.microsoft.com/store/productId/9N0DX20HK701)

[PowerShell](https://www.microsoft.com/store/productId/9MZ1SNWT0N5D)

[Windows Subsystem for Linux](https://www.microsoft.com/store/productId/9P9TQF7MRM4R)

[Debian](https://www.microsoft.com/store/productId/9MSVKQC78PK6)

[Visual Studio Code](https://apps.microsoft.com/store/detail/XP9KHM4BK9FZ7Q)

## Winget Packages

```
winget install -e --id Git.Git `
winget install -e --id OpenJS.NodeJS
winget install -e --id LLVM.LLVM
winget install -e --id Helix.Helix
winget install -e --id Rustlang.Rustup
winget install -e --id pnpm.pnpm
winget install -e --id Microsoft.WindowsTerminal
winget install -e --id Debian.Debian

```

## PNPM setup

```
pnpm setup
pnpm install -g `
typescript `
typescript-language-server `
vscode-langservers-extracted `
dockerfile-language-server-nodejs `
svelte-language-server `
typescript-svelte-plugin
```
