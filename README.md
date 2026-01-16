# Mac Multi-Monitor Keyboard Switcher (Hammerspoon)

A tiny **Hammerspoon** config that lets you switch between **multiple external monitors** on macOS using **keyboard only** — with:

✅ Monitor focus switching (Next / Previous)  
✅ Mission Control follows the switched monitor  
✅ A subtle HUD popup showing which monitor is active  
✅ Direct jump to Monitor 1 / 2 / 3  
✅ Hotkey to show “Current Monitor” anytime  

---

## Why this exists

macOS does not provide a reliable built-in keyboard shortcut to **focus a specific monitor**.

Even though macOS supports switching Spaces with keyboard, **Mission Control and Space switching only work on the currently focused display** — and the focused display is often tied to the mouse pointer.

This project fixes that by:
1. Moving focus to the target monitor
2. Moving the mouse to that monitor (so Mission Control follows)
3. Showing a subtle HUD indicator on the target monitor

---

## Demo Features

### ✅ Switch monitors using keyboard
- `Ctrl + Alt + Cmd + ]` → Focus **Next** monitor
- `Ctrl + Alt + Cmd + [` → Focus **Previous** monitor

### ✅ Jump directly to a monitor
- `Ctrl + Alt + Cmd + 1` → Jump to **Monitor 1**
- `Ctrl + Alt + Cmd + 2` → Jump to **Monitor 2**
- `Ctrl + Alt + Cmd + 3` → Jump to **Monitor 3**

> Monitor order is based on physical layout sorted left → right.

### ✅ Subtle Monitor HUD
Every switch shows a small popup like:

`🖥 2/3  LG UltraFine`

### ✅ Show current monitor anytime
- `Ctrl + Alt + Cmd + /` → Shows current active monitor

### ✅ Reload config quickly
- `Ctrl + Alt + Cmd + R` → Reload Hammerspoon config

---

## Requirements

- macOS
- 2+ monitors (works best with 2 or 3)
- [Hammerspoon](https://www.hammerspoon.org/) installed

---

## Setup Instructions

### 1) Enable separate Spaces per display
Go to:

**System Settings → Desktop & Dock → Mission Control →**
✅ **Displays have separate Spaces**

> macOS may require a logout/login once after enabling this.

---

### 2) Install Hammerspoon
Download and install Hammerspoon from:  
https://www.hammerspoon.org/

If macOS blocks it (Gatekeeper):
- Right-click the app → **Open**
- Or go to **System Settings → Privacy & Security → Open Anyway**

---

### 3) Give permissions (Important)
Go to:

**System Settings → Privacy & Security → Accessibility →**
✅ Enable **Hammerspoon**

Without this, monitor focus switching will not work correctly.

---

### 4) Add the config file

Create the config folder and file:

```bash
mkdir -p ~/.hammerspoon
touch ~/.hammerspoon/init.lua
open ~/.hammerspoon/init.lua
