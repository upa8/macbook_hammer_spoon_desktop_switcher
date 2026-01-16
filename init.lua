------------------------------------------------------------
-- Monitor Focus Switching + Mission Control Follow + HUD
-- Hotkeys:
--   Ctrl+Alt+Cmd + ]  -> Focus next monitor
--   Ctrl+Alt+Cmd + [  -> Focus previous monitor
--   Ctrl+Alt+Cmd + 1  -> Jump to monitor 1
--   Ctrl+Alt+Cmd + 2  -> Jump to monitor 2
--   Ctrl+Alt+Cmd + 3  -> Jump to monitor 3
--   Ctrl+Alt+Cmd + /  -> Show current monitor HUD
------------------------------------------------------------

local hyper = {"ctrl", "alt", "cmd"}

------------------------------------------------------------
-- Subtle Monitor HUD (Toast)
------------------------------------------------------------
hs.alert.defaultStyle = {
  strokeWidth      = 0,
  radius           = 10,
  textSize         = 18,
  fadeInDuration   = 0.05,
  fadeOutDuration  = 0.15,
  padding          = 12,
  atScreenEdge     = 2,   -- bottom
}

local function sortedScreens()
  local screens = hs.screen.allScreens()
  table.sort(screens, function(a, b)
    local fa, fb = a:fullFrame(), b:fullFrame()
    if fa.x == fb.x then return fa.y < fb.y end
    return fa.x < fb.x
  end)
  return screens
end

local function screenIndex(screen)
  local screens = sortedScreens()
  for i, s in ipairs(screens) do
    if s:id() == screen:id() then
      return i, #screens
    end
  end
  return 0, #screens
end

local function showMonitorHUD(screen)
  local i, total = screenIndex(screen)
  local name = screen:name() or "Display"
  hs.alert.closeAll(0.05)
  hs.alert.show(string.format("🖥 %d/%d  %s", i, total, name), nil, screen, 0.7)
end

------------------------------------------------------------
-- Focus a screen (ensures Mission Control follows)
------------------------------------------------------------
local function focusScreen(targetScreen)
  if not targetScreen then return end

  -- Move mouse to target screen center (Mission Control follows mouse screen)
  local f = targetScreen:fullFrame()
  local p = { x = f.x + (f.w / 2), y = f.y + (f.h / 2) }
  hs.mouse.setAbsolutePosition(p)

  -- Focus the top-most visible standard window on that screen (best behavior)
  local wins = hs.window.orderedWindows()
  for _, w in ipairs(wins) do
    if w:isStandard() and w:isVisible() and w:screen() == targetScreen then
      w:focus()
      showMonitorHUD(targetScreen)
      return
    end
  end

  -- If no window exists, click once to force focus onto that monitor
  hs.eventtap.leftClick(p)
  showMonitorHUD(targetScreen)
end

------------------------------------------------------------
-- Next / Previous monitor switching
------------------------------------------------------------
hs.hotkey.bind(hyper, "]", function()
  local nextScreen = hs.mouse.getCurrentScreen():next()
  focusScreen(nextScreen)
end)

hs.hotkey.bind(hyper, "[", function()
  local prevScreen = hs.mouse.getCurrentScreen():previous()
  focusScreen(prevScreen)
end)

------------------------------------------------------------
-- Jump directly to monitor 1/2/3 (based on physical left->right sort)
------------------------------------------------------------
hs.hotkey.bind(hyper, "1", function()
  local screens = sortedScreens()
  focusScreen(screens[1])
end)

hs.hotkey.bind(hyper, "2", function()
  local screens = sortedScreens()
  focusScreen(screens[2])
end)

hs.hotkey.bind(hyper, "3", function()
  local screens = sortedScreens()
  focusScreen(screens[3])
end)

------------------------------------------------------------
-- Show current monitor HUD anytime
------------------------------------------------------------
hs.hotkey.bind(hyper, "/", function()
  showMonitorHUD(hs.mouse.getCurrentScreen())
end)

------------------------------------------------------------
-- Optional: quick reload hotkey
-- Ctrl+Alt+Cmd + R -> Reload config
------------------------------------------------------------
hs.hotkey.bind(hyper, "R", function()
  hs.reload()
  hs.alert.show("✅ Hammerspoon Reloaded", 0.6)
end)
