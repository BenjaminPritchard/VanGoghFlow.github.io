<p align="center">
  <img src="assets/vangoghflow_logo.png" alt="Van Gogh Flow Logo" width="200" style="border-radius: 20px; box-shadow: 0 8px 24px rgba(0,0,0,0.15);" />
</p>

<h1 align="center">Van Gogh Flow</h1>

<p align="center">
  <b>The 7-Year Evolution of Ambient Desktop Compositing & Flow States</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Portfolio%20Showcase-blue.svg" alt="Portfolio" />
  <img src="https://img.shields.io/badge/Author-Benjamin%20Pritchard-yellow.svg" alt="Author" />
  <img src="https://img.shields.io/badge/Generations-4%20Completed%20%2B%201%20Upcoming-green.svg" alt="Generations" />
  <img src="https://img.shields.io/badge/License-MIT-purple.svg" alt="License" />
</p>

---

## 🌌 Overview & Vision

**Van Gogh Flow** is an open-source engineering research and software project created by **Benjamin Pritchard** ([Kundalini Software](https://www.kundalinisoftware.com/van-gogh-flow/)).

It explores the intersection of two distinct domains:
1. **The Psychology of Human Flow States**: Modulating between *focused-mode execution* and *diffuse-mode creative ideation* using subtle, organic peripheral motion inspired by Vincent van Gogh's rhythmic brushstrokes (*The Starry Night*).
2. **Display Server Compositing**: Interfacing directly with operating system window managers (Win32 DWM, Linux X11, Wayland Layer Shell, macOS Quartz/WindowServer, and upcoming STM32MP2 hardware silicon) to guarantee **100% click-through, non-interfering GPU surfaces**.

Over the course of seven years (2019–2026), Van Gogh Flow evolved through **four complete software iterations**, progressing from heavy browser wrappers streaming YouTube videos to ultra-lean native procedural GPU shaders running at native monitor refresh rates.

---

## 🧠 Flow States & Brain Modes: Modulating Attention

In technical problem-solving—whether composing counterpoint, designing hardware board support packages (BSPs), or writing systems software—the brain relies on two alternating modes of cognition:

* **Focused Mode**: Characterized by tight analytical focus within the prefrontal cortex. You are actively stepping through registers, tracking pointer lifetimes, or diagnosing logic bugs.
* **Diffuse Mode**: Characterized by resting-state, panoramic neural network activation. The mind steps back, connects disparate concepts, perceives big-picture architectures, and synthesizes novel breakthroughs.

<p align="center">
  <img src="assets/FocusVsDiffused.jpeg" alt="Focused Mode vs. Diffuse Mode Thinking" width="600" />
  <br />
  <em>Figure 1: Neural activation patterns between Focused Mode (pinball ricochets tightly localized) and Diffuse Mode (wide exploratory subconscious associations across the entire brain). From Kundalini Software research archives.</em>
</p>

### The "Volume Keys" Metaphor
Rather than requiring the user to switch apps, minimize windows, or look away from their work, Van Gogh Flow treats screen opacity like an audio volume dial:
* **Hyper-Focused Execution**: Dial opacity down (2% – 5%) or toggle off. The screen remains crisp and distraction-free.
* **Diffuse Ideation & Problem-Solving**: Dial opacity up (15% – 30%). The workspace softens into swirling cosmic plasma ribbons and gentle celestial particles, relaxing hyper-vigilance and stimulating associative thinking.

---

## 🖥️ What is a Compositor? (And Why Windowing Architecture Matters)

To understand how Van Gogh Flow works under the hood, it helps to understand how graphical user interfaces have fundamentally changed over the past two decades.

### Legacy Windowing: Shared Framebuffers & Redraw Storms (Win32 & Classic X11)
In classical windowing systems (Win32 Windows 95 through XP, and non-composited X11):
* Windows painted their pixels directly into a **shared screen buffer**.
* When you moved, dragged, or resized a window, the OS calculated "dirty regions" and bombarded obscured windows with redraw messages (`WM_PAINT`, `InvalidateRect`, or X11 `Expose` events).
* If a program locked up or lagged, it missed redraw messages—producing the infamous **"Windows Solitaire trail"** smeared across the screen.
* Full-screen desktop transparency was practically impossible without severe CPU thrashing and visual tearing.

### Modern Compositors: 3D Scene Directors (Wayland, macOS Quartz, Windows DWM)
Modern desktop environments completely inverted this model:
* **Every application renders into its own private, off-screen GPU texture.** No program ever draws into another's memory.
* The **Compositor** acts like a real-time 3D game engine. Every VSync tick (60Hz, 120Hz ProMotion, 144Hz+), it takes all off-screen textures, arranges them in 3D layers, blends them using GPU hardware alpha channels, and presents the composite frame to the monitor.
* **Result**: Zero tearing, zero redraw storms, and zero ghosting.

```mermaid
flowchart TD
    subgraph Traditional["Traditional Windowing (Win32 WM_PAINT / Classic X11)"]
        direction TB
        Buffer["Shared Screen Buffer (Direct Screen Memory)"]
        App["App Window (Draws directly to glass)"]
        App -->|"InvalidateRect / WM_PAINT"| Buffer
        Buffer -.->|"Lagging apps miss redraw -> Solitaire Ghosting!"| Smear["Window Tearing & Smeared Trails"]
    end

    subgraph Modern["Modern Compositors (Wayland / macOS Quartz / Win10 DWM)"]
        direction TB
        T1["Code Editor (Private GPU Texture)"] --> Comp["Compositor Engine (GPU Hardware Alpha Blending)"]
        T2["Web Browser (Private GPU Texture)"] --> Comp
        T3["Van Gogh Flow HUD (Translucent GPU VRAM)"] --> Comp
        Comp --> Monitor["Display Panel (Tear-Free, VSync Synchronized)"]
    end
```

Because modern display servers natively blend off-screen textures on the GPU, **Van Gogh Flow** can float full-screen visualizers across your entire desktop with absolute transparency, native display refresh rates, and zero disruption to the applications underneath.

---

## 🎨 The Four Completed Iterations

```mermaid
flowchart LR
    subgraph I1["1st Iteration (2019)<br/>VanGoghFlow"]
        direction TB
        A1["Windows 10 DWM"]
        A2["WS_EX_TRANSPARENT"]
        A3["CefSharp / CEF"]
        A4["YouTube Streams"]
    end

    subgraph I2["2nd Iteration (2021)<br/>VanGoghFlowGTK3"]
        direction TB
        B1["Linux X11 Compositors"]
        B2["GTK3 + WebKit2GTK"]
        B3["Cairo Input Shapes"]
        B4["libappindicator3 Tray"]
    end

    subgraph I3["3rd Iteration (2026)<br/>vangoghflow_wayland"]
        direction TB
        C1["Direct Wayland Client"]
        C2["zwlr_layer_shell_v1"]
        C3["Native EGL & GLES2"]
        C4["Procedural GLSL Shaders"]
    end

    subgraph I4["4th Iteration (2026)<br/>VanGoghFlow_macOS"]
        direction TB
        D1["AppKit & Quartz Engine"]
        D2["ignoresMouseEvents = YES"]
        D3["Native Apple Metal MSL"]
        D4["Spaces-Persistent HUD"]
    end

    I1 -->|"Port to Linux"| I2
    I2 -->|"AI Leap (Gemini)"| I3
    I3 -->|"Cross-Platform Port (Gemini)"| I4
```

### 1. Iteration 1: [VanGoghFlow (Windows 10)](https://github.com/BenjaminPritchard/VanGoghFlow) — June 2019
* **Platform**: Windows 10 (64-bit)
* **Language & Windowing**: C# (.NET Framework 4.7.2), WinForms, Win32 API
* **Renderer**: CefSharp wrapper around the Chromium Embedded Framework (CEF)
* **Author**: Handcrafted by **Benjamin Pritchard**
* **Click-Through Mechanism**: Overrode `CreateParams` with Win32 extended window styles:
  ```csharp
  cp.ExStyle |= 0x80000;  /* WS_EX_LAYERED     */
  cp.ExStyle |= 0x20;     /* WS_EX_TRANSPARENT */
  cp.ExStyle |= 0x80;     /* WS_EX_TOOLWINDOW  */
  ```
* **Controls**: Global hotkeys via Win32 `RegisterHotKey`: `Ctrl+Alt+N`/`P` (next/prev video), `Ctrl+Alt+I`/`D` (opacity up/down).

### 2. Iteration 2: [VanGoghFlowGTK3 (Linux X11)](https://github.com/BenjaminPritchard/VanGoghFlowGTK3) — August 2021
* **Platform**: Linux (X11 with compositing window managers: Muffin, Compiz, Mutter)
* **Language & Framework**: Pure C (C11), Clang, GTK+ 3.0, WebKit2GTK (`webkit2gtk-4.0`)
* **Author**: Handcrafted by **Benjamin Pritchard**
* **Click-Through Mechanism**: Configured RGBA visual support via `gdk_screen_get_rgba_visual()` and masked input via Cairo:
  ```c
  cairo_rectangle_int_t rect = {0, 0, 0, 0};
  cairo_region_t *shape = cairo_region_create_rectangle(&rect);
  gdk_window_input_shape_combine_region(gdk_window, shape, 0, 0);
  cairo_region_destroy(shape);
  ```
* **Controls**: Global XInput keyboard hooks (`F3`/`F4` as opacity volume keys) and `libappindicator3` system tray menu.

### 3. Iteration 3: [VanGoghFlow_Wayland (Linux Wayland)](https://github.com/BenjaminPritchard/VanGoghFlow_Wayland) — October 2026
* **Platform**: Linux Wayland (wlroots compositors: Wayfire, Sway, Hyprland, Labwc)
* **Language & Architecture**: Modern C++ (C++17), Direct Wayland Client, EGL, OpenGL ES 2.0
* **Author**: Co-Engineered by **Benjamin Pritchard & Google Gemini** (1-Day Generation)
* **Key Breakthroughs**:
  * **Discarded Web Engines Entirely**: Replaced Chromium/WebKit and YouTube video network streams with pure, mathematical GLSL fragment/vertex shaders running at native monitor refresh rates with < 25 MB RAM.
  * **`zwlr_layer_shell_v1` Protocol**: Binds directly to `ZWLR_LAYER_SHELL_V1_LAYER_OVERLAY`, sitting above all tiled, floating, and fullscreen windows.
  * **100% Click-Through Guarantee**: Bypasses UI toolkits (GTK/Qt) that overwrite input masks during layout passes. Interfacing directly with `wayland-client` allows setting a permanent empty `wl_region` (`wl_surface_set_input_region(surface, empty_region)`).

### 4. Iteration 4: [VanGoghFlow_macOS (macOS)](https://github.com/BenjaminPritchard/VanGoghFlow_macOS) — October 2026
* **Platform**: macOS 12 Monterey through macOS 15+ Sequoia (Apple Silicon & Intel)
* **Language & Framework**: Objective-C++ / Modern C++17, AppKit, Apple Metal, MetalKit, QuartzCore
* **Author**: Co-Engineered by **Benjamin Pritchard & Google Gemini** (Same-Day Generation)
* **Key Breakthroughs**:
  * **Native Apple Metal Pipeline**: Procedural shaders execute directly on Apple Silicon unified memory with synchronized ProMotion (120Hz) frame pacing.
  * **WindowServer Click-Through**: Enforces `[window setIgnoresMouseEvents:YES]` at the window server level. Every pointer event falls through without waking the HUD.
  * **Spaces Persistence**: Configured with `NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorStationary`. The HUD remains pinned across virtual desktop swipes and Exposé/Mission Control transitions.
  * **Runtime MSL Compilation**: Compiles shaders in memory via `newLibraryWithSource:options:error:`, enabling zero-dependency command-line builds.

---

## ⚡ Handwritten Foundations vs. AI-Generated Velocity

The architectural progression across the four generations highlights a remarkable paradigm shift in software development:

* **Iterations 1 & 2 (2019 & 2021)**: Handcrafted line-by-line over weeks of research. Benjamin navigated undocumented Win32 extended window quirks, deciphered Cairo XFixes shape combine algorithms, and packaged heavy web runtimes.
* **Iterations 3 & 4 (October 2026)**: **Conceived, architected, and fully generated in a single day using Google Gemini**. Because Benjamin possessed deep foundational knowledge of compositing managers, layer shell protocols, and graphics pipelines, he was able to guide Gemini to synthesize two complete, robust native systems binaries (Wayland C++/GLES2 and macOS Objective-C++/Metal) in less than 24 hours.

---

## 🔌 The Modular Plugin Architecture

Both the Wayland and macOS implementations share an extensible, self-registering plugin architecture:

```mermaid
flowchart TD
    Host["Host Application Driver (Wayland / macOS)"] --> Interface["Plugin Virtual Interface (plugin.hpp)"]
    Interface --> P1["aurora (GLSL/MSL Plasma)"]
    Interface --> P2["starfield (3D Point Sprites)"]
    Interface --> P3["matrix (Green Digital Rain)"]
    Interface --> P4["fireflies (Soft Bioluminescent Orbs)"]
```

Every plugin implements three lifecycle methods:
1. `bool init(int width, int height)`: Compiles GPU shaders and initializes geometry buffers.
2. `void resize(int width, int height)`: Adjusts viewports and updates resolution uniforms.
3. `void render(float dt, float master_opacity)`: Clears background with `(0, 0, 0, 0)` alpha and dispatches procedural shader passes.

Self-registration into the global registry occurs automatically at static initialization via `REGISTER_PLUGIN(MyPluginClass)`.

---

## 🌠 Visualizer Showcase

<p align="center">
  <img src="assets/vangoghflow_demo.gif" alt="Wayland Live Demo" width="700" style="border-radius: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);" />
  <br />
  <em>Real-time screen capture of Van Gogh Flow cycling through plugins over a Linux Wayland desktop</em>
</p>

<p align="center">
  <img src="assets/vangoghflow_macos_screenshot.png" alt="macOS Real-Time Metal HUD" width="700" style="border-radius: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);" />
  <br />
  <em>Real-time capture of Van Gogh Flow running transparently across macOS with Apple Metal shaders</em>
</p>

| Plugin | Screenshot | Aesthetic Description |
| :--- | :---: | :--- |
| **`aurora`** | <img src="assets/aurora.png" width="280" /> | Flowing cosmic plasma ribbons and undulating waves inspired by Vincent van Gogh's *The Starry Night*. |
| **`starfield`** | <img src="assets/starfield.png" width="280" /> | 3D warp-speed particles with multi-colored twinkling point sprites accelerating toward the viewer. |
| **`matrix`** | <img src="assets/matrix.png" width="280" /> | Cyberpunk digital rain cascades with glowing phosphor-green trails and leading glyphs. |
| **`fireflies`** | <img src="assets/fireflies.png" width="280" /> | Luminous drifting bioluminescent particles and floating neon embers with soft radial halos. |

---

## 📊 Comprehensive Comparison Matrix

| Feature | Iteration 1 (2019)<br/>Windows | Iteration 2 (2021)<br/>Linux GTK3 | Iteration 3 (2026)<br/>Wayland | Iteration 4 (2026)<br/>macOS | Iteration 5 (Next)<br/>STM32MP2 Embedded |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Operating System** | Windows 10 (64-bit) | Linux (X11) | Linux (Wayland) | macOS 12+ | Embedded Linux + Bare Metal |
| **Language** | C# (.NET 4.7.2) | Pure C (C11) | Modern C++ (C++17) | Objective-C++ / C++17 | C/C++ (Linux) + Bare Metal C (M33) |
| **Authoring** | Handcrafted | Handcrafted | **AI-Generated in 1 day** | **AI-Generated in 1 day** | Embedded Systems Engineering |
| **Graphics Engine** | Chromium (CefSharp) | WebKit2GTK | EGL + OpenGL ES 2.0 | Apple Metal (MSL) | Silicon LTDC Layers + LVDS/DSI |
| **Visual Source** | YouTube Streams | YouTube Streams | Procedural GLSL Shaders | Procedural Metal Shaders | Real-time Heterogeneous Planes |
| **Compositor Target** | Windows DWM | Muffin / Compiz / Mutter | `zwlr_layer_shell_v1` | Quartz / WindowServer | Hardware LTDC Scan-Out (RIF) |
| **RAM Footprint** | ~350 MB | ~280 MB | **< 25 MB** | **< 35 MB** | **Zero Linux GPU Overhead** |
| **Binary Size** | ~120 MB | ~65 MB | **< 250 KB** | **< 300 KB** | Microcontroller footprint |
| **Input Pass-Through** | `WS_EX_TRANSPARENT` | Cairo Shape Combine | Direct Empty `wl_region` | `ignoresMouseEvents = YES` | Physical Display Hardware Planes |

---

## 🚀 What's Next: Embedded Linux & Real-Time Multicore Compositing on STM32MP2

The upcoming fifth iteration transitions Van Gogh Flow from personal computers to dedicated industrial microprocessors: **the STMicroelectronics STM32MP2 platform** (specifically the STM32MP25 family).

This edition bridges Benjamin Pritchard's core technical backgrounds:
* **Embedded Linux Engineering**: Mainline kernel drivers, Yocto/Buildroot BSPs, OpenSTLinux, and Wayland/Weston graphics stacks.
* **Deterministic Real-Time Firmware**: Bare-metal Arm Cortex-M firmware, low-latency interrupt handling, and motor/instrumentation control.
* **Hardware Compositing**: Utilizing on-chip display controllers to composite heterogeneous processor streams in silicon.

### Hardware Compositing via LTDC & RIF (Resource Isolation Framework)
On the STM32MP2, a dual-core **64-bit Arm Cortex-A35** application processor runs alongside a dedicated **400 MHz Arm Cortex-M33** real-time secure microcontroller.

Rather than running complex software frame-buffer copying between cores, the **LCD-TFT Display Controller (LTDC)** composites display layers **directly in silicon**:

```mermaid
flowchart TD
    subgraph MP2["STMicroelectronics STM32MP2 (Heterogeneous Multicore SoC)"]
        direction TB

        subgraph A35["Cortex-A35 (Dual 64-bit Cores)"]
            OS["Embedded Linux (OpenSTLinux / Yocto)"]
            HMI["Main HMI / Dashboard / Network GUI"]
            HMI -->|"Linux DRM/KMS Driver"| L1["LTDC Layer 1 & 2 (Base Graphic Plane)"]
        end

        subgraph RIF["Resource Isolation Framework (RIF Firewall)"]
            direction LR
            CID1["CID1: Linux Domain (A35)"]
            CID2["CID2: Real-Time Domain (M33)"]
        end

        subgraph M33["Cortex-M33 (400 MHz Real-Time Core)"]
            RT["Bare-Metal Firmware / FreeRTOS"]
            VGF["Van Gogh Flow Procedural Engine"]
            VGF -->|"Direct Memory Access"| L3["LTDC Layer 3 (Overlay Graphic Plane)"]
        end

        subgraph LTDC["LTDC (LCD-TFT Display Controller Peripheral)"]
            Blender["Hardware Pixel Alpha Blender (Real-Time Scan-Out)"]
            L1 --> Blender
            L3 --> Blender
        end

        Blender --> LVDS["Internal LVDS / MIPI-DSI Interface"]
    end

    LVDS --> Panel["Physical LVDS Industrial Display Panel (Real-Time Blended Composite)"]
```

1. **Hardware Layer Allocation**:
   * **Cortex-A35 (Linux)** drives the primary HMI application (system dashboards, network metrics) mapped to LTDC Layers 1 and 2.
   * **Cortex-M33 (Bare Metal)** drives the Van Gogh Flow procedural overlay mapped to LTDC Layer 3.
2. **RIF Hardware Firewalls**:
   * The STM32MP2's **Resource Isolation Framework (RIF)** enforces hardware peripheral isolation using Context Identification (CID1 for Cortex-A35, CID2 for Cortex-M33).
   * RIF grants exclusive hardware ownership of Layer 3 registers and designated SRAM/DDR framebuffers to the M33, preventing Linux processes from modifying or corrupting the real-time layer.
3. **Zero-Jitter Silicon Blending**:
   * The LTDC hardware blends both streams in real-time during raster scan-out to the internal LVDS display interface.
   * Even if Embedded Linux experiences 100% CPU spikes or kernel latency, the M33's ambient flow visualizer updates deterministically at real-time speeds with zero dropped frames.

*Coming soon: Firmware repositories, LTDC device tree overlays, and benchmarks on STM32MP2 evaluation boards.*

---

## 📜 Repositories & Credits

* **Wayland Edition**: [BenjaminPritchard/VanGoghFlow_Wayland](https://github.com/BenjaminPritchard/VanGoghFlow_Wayland)
* **macOS Edition**: [BenjaminPritchard/VanGoghFlow_macOS](https://github.com/BenjaminPritchard/VanGoghFlow_macOS)
* **Linux GTK3 Edition**: [BenjaminPritchard/VanGoghFlowGTK3](https://github.com/BenjaminPritchard/VanGoghFlowGTK3)
* **Windows 10 Original**: [BenjaminPritchard/VanGoghFlow](https://github.com/BenjaminPritchard/VanGoghFlow)
* **Portfolio Showcase**: [BenjaminPritchard.github.io](https://benjaminpritchard.github.io/)

### License
All Van Gogh Flow projects are licensed under the **MIT License**.
Copyright &copy; 2019–2026 **Benjamin Pritchard** / Kundalini Software.
