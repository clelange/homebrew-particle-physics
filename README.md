# My homebrew tap

A list of tools that I tend to install on new computers, which aren't part of the standard [Homebrew Formulae](https://formulae.brew.sh/).

See also https://github.com/davidchall/homebrew-hep for additional useful formulae.

## Installation

This is a [Homebrew Tap](https://docs.brew.sh/Taps).

```shell
brew tap clelange/particle-physics
```

Then you can install any of the available formulae below using `brew install <formula>`.

## Available formulae

- `voms-clients`: Virtual Organization Membership Service clients for grid computing
- `wlcg-voms`: VOMS configuration files for various WLCG Virtual Organizations (ALICE, ATLAS, CMS, LHCb, etc.)

## Usage

### wlcg-voms

After installation, the VOMS configuration files are available in:
- `$(brew --prefix)/opt/wlcg-voms/etc/grid-security/vomsdir/` 
- `$(brew --prefix)/opt/wlcg-voms/etc/vomses/`

To use with VOMS client tools, you may need to:

1. Create symbolic links to system locations (requires sudo):
   ```shell
   sudo mkdir -p /etc/grid-security
   sudo ln -s $(brew --prefix)/opt/wlcg-voms/etc/grid-security/vomsdir /etc/grid-security/vomsdir
   sudo ln -s $(brew --prefix)/opt/wlcg-voms/etc/vomses /etc/vomses
   ```

2. Or configure your environment:
   ```shell
   export X509_VOMS_DIR=$(brew --prefix)/opt/wlcg-voms/etc/grid-security/vomsdir
   export VOMS_USERCONF=$(brew --prefix)/opt/wlcg-voms/etc/vomses
   ```

## Adding formulae

See the [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook) for more information.
