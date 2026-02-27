#!/bin/bash

# Delete folder to avoid caching issues
rm -rf ~/.local/share/.burrito

# Build the desktop app for 3 main platforms. Windows needs other command.
# For more info about windows builds check: [https://mrpopov.com/posts/elixir-liveview-single-binary/]
MIX_ENV=prod mix assets.deploy  
MIX_ENV=prod mix release meteor_desktop 

cd tauri && NO_STRIP=true cargo tauri build --bundles appimage
cd .. && mix phx.digest.clean --all
