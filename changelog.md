# Changelog - VanGoghFlow.github.io

All notable changes to the Van Gogh Flow portfolio and documentation site will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased] - 2026-10-12

### Added
- Initialized `VanGoghFlow.github.io` portfolio showcase repository for the Van Gogh Flow project.
- Gathered core visual assets into `assets/`:
  - Official Van Gogh Flow logo (`vangoghflow_logo.png`, `vangoghflow_logo.jpg`)
  - Live Wayland demonstration GIF (`vangoghflow_demo.gif`)
  - Wayland procedural visualizer gallery screenshots (`aurora.png`, `starfield.png`, `matrix.png`, `fireflies.png`)
  - Real-time macOS Metal overlay screenshot (`vangoghflow_macos_screenshot.png`)
  - Psychological flow model illustration (`FocusVsDiffused.jpeg`)
- Researched technical foundations across all four iterations:
  - Iteration 1: Windows 10 C# / WinForms / CEF / Win32 layered click-through
  - Iteration 2: Linux X11 C11 / GTK+ 3.0 / WebKit2GTK / Cairo input shapes
  - Iteration 3: Linux Wayland Modern C++17 / EGL / GLES2 / `zwlr_layer_shell_v1` / GLSL shader plugins
  - Iteration 4: macOS Objective-C++ / AppKit / Apple Metal / Quartz Compositor / MSL shader plugins
- Researched upcoming 5th iteration:
  - STM32MP2 heterogeneous dual Cortex-A35 + Cortex-M33 architecture
  - Hardware display compositing via LTDC + LVDS peripheral with Resource Isolation Framework (RIF) multi-core plane sharing
- Created interactive, responsive portfolio website `index.html` with GitHub Primer light mode styling matching `benjaminpritchard.github.io`.
- Added comprehensive repository documentation `README.md`.
- Added automated GitHub Pages deployment script `deploy.sh`.
