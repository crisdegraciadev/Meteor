#!/bin/bash

# One time setup script. Used to link burrito binaries with tauri project.

cd tauri/src-tauri

ln -s ../../burrito_out/meteor_desktop_linux meteor_backend-x86_64-unknown-linux-gnu
ln -s ../../burrito_out/meteor_desktop_macos meteor_backend-aarch64-apple-darwin
ln -s ../../burrito_out/meteor_desktop_windows.exe meteor_backend-x86_64-pc-windows-msvc.exe
