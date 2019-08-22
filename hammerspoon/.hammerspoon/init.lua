-- Hammerspoon configuration, heavily influenced by sdegutis default configuration
hs.window.animationDuration = 0

require "pomodoor"
require "atreus"

-- init grid
hs.grid.MARGINX 	= 0
hs.grid.MARGINY 	= 0
hs.grid.GRIDWIDTH 	= 4
hs.grid.GRIDHEIGHT 	= 4

-- disable animation
hs.window.animationDuration = 0


-- hotkey mash
-- the original was {"ctrl", "alt"} - conflicts with HashTWM
-- local mash       = {"ctrl", "alt"}
local mash       = {"cmd", "alt"}
local mash_app 	 = {"cmd", "alt", "ctrl"}
local mash_shift = {"ctrl", "alt", "shift"}
local mash_test	 = {"cntrl", "shift"}	

--------------------------------------------------------------------------------
appCuts = {
  -- d = 'Dictionary',
  t = 'iterm',
  r = 'Google chrome',
  f = 'Firefox',
  -- t = 'Trello X',
  -- 4 reserved for dash shortcut 
  -- q = 'Quiver',
  e = 'emacs',
  a = 'Finder',
  -- i = 'Terminal'
}

-- Launch applications
for key, app in pairs(appCuts) do
  hs.hotkey.bind(mash_app, key, function () hs.application.launchOrFocus(app) end)
end

-- global operations
hs.hotkey.bind(mash, ';', function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(mash, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)

-- adjust grid size
hs.hotkey.bind(mash, '=', function() hs.grid.adjustWidth( 1) end)
hs.hotkey.bind(mash, '-', function() hs.grid.adjustWidth(-1) end)
hs.hotkey.bind(mash, ']', function() hs.grid.adjustHeight( 1) end)
hs.hotkey.bind(mash, '[', function() hs.grid.adjustHeight(-1) end)

-- change focus
hs.hotkey.bind(mash_shift, 'H', function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(mash_shift, 'L', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(mash_shift, 'K', function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(mash_shift, 'J', function() hs.window.focusedWindow():focusWindowSouth() end)

hs.hotkey.bind(mash, 'M', hs.grid.maximizeWindow)

-- multi monitor
hs.hotkey.bind(mash, 'N', hs.grid.pushWindowNextScreen)
hs.hotkey.bind(mash, 'P', hs.grid.pushWindowPrevScreen)

-- move windows
hs.hotkey.bind(mash, 'H', hs.grid.pushWindowLeft)
hs.hotkey.bind(mash, 'J', hs.grid.pushWindowDown)
hs.hotkey.bind(mash, 'K', hs.grid.pushWindowUp)
hs.hotkey.bind(mash, 'L', hs.grid.pushWindowRight)

-- resize windows
hs.hotkey.bind(mash, 'Y', hs.grid.resizeWindowThinner)
hs.hotkey.bind(mash, 'U', hs.grid.resizeWindowShorter)
hs.hotkey.bind(mash, 'I', hs.grid.resizeWindowTaller)
hs.hotkey.bind(mash, 'O', hs.grid.resizeWindowWider)

-- Window Hints
-- hs.hotkey.bind(mash, '.', function() hs.hints.windowHints(hs.window.allWindows()) end)
hs.hotkey.bind(mash, '.', hs.hints.windowHints)

-- pomodoro key binding
hs.hotkey.bind(mash, '9', function() pom_enable() end)
hs.hotkey.bind(mash, '0', function() pom_disable() end) -- local mash       = {"cmd", "alt"}
hs.hotkey.bind(mash_shift, '0', function() pom_reset_work() end) -- local mash_shift = {"ctrl", "alt", "shift"}
hs.hotkey.bind(mash_shift, '9', function() hs.alert.closeAll() end)

-- snap all newly launched windows
local function auto_tile(appName, event)
	if event == hs.application.watcher.launched then
		local app = hs.appfinder.appFromName(appName)
		-- protect against unexpected restarting windows
		if app == nil then
			return
		end
		hs.fnutils.map(app:allWindows(), hs.grid.snap)
	end
end

-- start app launch watcher
hs.application.watcher.new(auto_tile):start()


--------------------------------
-- -- 08-06-2018 - playing with modal mode SR
-- -- A global variable for the Hyper Mode
-- hyper = hs.hotkey.modal.new({"cmd", "shift", "ctrl", "alt"})

-- -- Enter Hyper Mode when  (Hyper/Capslock) P is pressed
-- function enterHyperMode()
--   hyper.triggered = false
--   hyper:enter()
-- end

-- -- Leave Hyper Mode when (Hyper/Capslock) P is pressed,
-- -- send ESCAPE if no other keys are pressed.
-- function exitHyperMode()
--   hyper:exit()
--   if not hyper.triggered then
--     hs.eventtap.keyStroke({"cmd", "shift", "ctrl", "alt"}, 'ESCAPE')
--   end
-- end

-- -- Bind the Hyper key
-- f8 = hs.hotkey.bind({}, 'F8', enterHyperMode, exitHyperMode)

------------------------------------------
-- https://kirbuchi.com/2016/10/26/playing-with-hammerspoon/
-- Enable/Disable Keypress Show Mode with "C-⌘-⇧-p"
-- function showKeyPress(tap_event)
--   local duration = 1.5  -- popup duration
--   local modifiers = ""  -- key modifiers string representation
--   local flags = tap_event:getFlags()
--   local character = hs.keycodes.map[tap_event:getKeyCode()]
--   -- we only want to read special characters via getKeyCode, so we
--   -- use this subset of hs.keycodes.map
--   local special_chars = {
--     ["f1"] = true, ["f2"] = true, ["f3"] = true, ["f4"] = true,
--     ["f5"] = true, ["f6"] = true, ["f7"] = true, ["f8"] = true,
--     ["f9"] = true, ["f10"] = true, ["f11"] = true, ["f12"] = true,
--     ["f13"] = true, ["f14"] = true, ["f15"] = true, ["f16"] = true,
--     ["f17"] = true, ["f18"] = true, ["f19"] = true, ["f20"] = true,
--     ["pad"] = true, ["pad*"] = true, ["pad+"] = true, ["pad/"] = true,
--     ["pad-"] = true, ["pad="] = true, ["pad0"] = true, ["pad1"] = true,
--     ["pad2"] = true, ["pad3"] = true, ["pad4"] = true, ["pad5"] = true,
--     ["pad6"] = true, ["pad7"] = true, ["pad8"] = true, ["pad9"] = true,
--     ["padclear"] = true, ["padenter"] = true, ["return"] = true,
--     ["tab"] = true, ["space"] = true, ["delete"] = true, ["escape"] = true,
--     ["help"] = true, ["home"] = true, ["pageup"] = true,
--     ["forwarddelete"] = true, ["end"] = true, ["pagedown"] = true,
--     ["left"] = true, ["right"] = true, ["down"] = true, ["up"] = true
--   }

--   -- if we have a simple character (no modifiers), we want a shorter
--   -- popup duration.
--   if (not flags.shift and not flags.cmd and
--         not flags.alt and not flags.ctrl) then
--     duration = 0.3
--   end

--   -- we want to get regular characters via getCharacters as it
--   -- "cleans" the key for us (e.g. for a "⇧-5" keypress we want
--   -- to show "⇧-%").
--   if special_chars[character] == nil then
--     character = tap_event:getCharacters(true)
--     if flags.shift then
--       character = string.lower(character)
--     end
--   end

--   -- make some known special characters look good
--   if character == "return" then
--     character = "⏎"
--   elseif character == "delete" then
--     character = "⌫"
--   elseif character == "escape" then
--     character = "⎋"
--   elseif character == "space" then
--     character = "SPC"
--   elseif character == "up" then
--     character = "↑"
--   elseif character == "down" then
--     character = "↓"
--   elseif character == "left" then
--     character = "←"
--   elseif character == "right" then
--     character = "→"
--   end

--   -- get modifiers' string representation
--   if flags.ctrl then
--     modifiers = modifiers .. "C-"
--   end
--   if flags.cmd then
--     modifiers = modifiers .. "⌘-"
--   end
--   if flags.shift then
--     modifiers = modifiers .. "⇧-"
--   end
--   if flags.alt then
--     modifiers = modifiers .. "⌥-"
--   end

--   -- actually show the popup
--   hs.alert.show(modifiers .. character, duration)

-- end

-- local key_tap = hs.eventtap.new(
--   {hs.eventtap.event.types.keyDown},
--   showKeyPress
-- )
-- k = hs.hotkey.modal.new({"cmd", "shift", "ctrl", "alt"}, 'P')
-- function k:entered()
--   hs.alert.show("Enabling Keypress Show Mode", 1.5)
--   -- key_tap:start()
-- end
-- function k:exited()
--   hs.alert.show("Disabling Keypress Show Mode", 1.5)
-- end
-- k:bind({"cmd", "shift", "ctrl", "alt"}, 'P', function()
--     -- key_tap:stop()

--   -- Launch applications
--   for key, app in pairs(appCuts) do
-- 	 hs.hotkey.bind({}, key, function () hs.application.launchOrFocus(app) end)
--   end

--   k:exit()
-- end)

----------------------
-- from docs example
-- k = hs.hotkey.modal.new({"cmd", "shift", "ctrl", "alt"}, 'I')
i = hs.hotkey.modal.new({"cmd"}, 'I')
-- function i:entered() hs.alert('I mode', 10)
function i:entered() hs.alert('I mode', 'A')
end
function i:exited() --hs.alert'I exited '
   hs.alert.closeAll() 
end
i:bind('', 'escape', function() i:exit() end)
i:bind('', 'J', 'Pressed J',function() print'let the record show that J was pressed' end)
i:bind('', 't', function() hs.application.launchOrFocus('iterm') i:exit() end)
i:bind('', 'E', function() hs.application.launchOrFocus('Emacs') i:exit() end)
i:bind('', 'R', function() hs.application.launchOrFocus('Google chrome') i:exit() end)
i:bind('', 'F', function() hs.application.launchOrFocus('Firefox') i:exit() end)
i:bind('', 'A', function() hs.application.launchOrFocus('Finder') i:exit() end)

-- -- k:bind('', 'I', 'Select app',function()
-- --   -- Launch applications
-- --   for key, app in pairs(appCuts) do
-- -- 	 hs.hotkey.bind({}, key, function () hs.application.launchOrFocus(app) end)
-- --   end
-- -- end)

-- -- function k:entered() hs.alert'Entered mode'
-- -- end
-- -- function k:exited() hs.alert'Exited mode'
-- -- end
-- -- k = hs.hotkey.modal.new({"cmd"}, 'K')
-- -- k:bind('', 'K', function() k:exit() hs.hints.windowHints() end)
-- -- k:bind('', 'escape', function() k:exit() end)

-- -- hs.hotkey.bind(mash, '.', hs.hints.windowHints)

-- j = hs.hotkey.modal.new({"cmd"}, 'J')
-- function j:entered() hs.alert('J mode', 'A')
-- end
-- function j:exited() --hs.alert'J Exited'
--    hs.alert.closeAll()
-- end
-- j:bind('', 'escape', function() j:exit() end)
-- j:bind('', 'H', 'Pressed H',function() hs.grid.pushWindowLeft() end)
-- j:bind('', 'L', 'Pressed L',function() hs.grid.pushWindowRight() end)
-- j:bind('', '=', 'Pressed =',function() hs.grid.adjustWidth( 1) end)
-- j:bind('', '-', 'Pressed -',function() hs.grid.adjustWidth(-1) end)
-- j:bind('', 'Space', 'Pressed Space', function() hs.grid.maximizeWindow() end)

-- -- hs.hotkey.bind(mash, 'H', hs.grid.pushWindowLeft)

-- hs.hotkey.bind(mash, '=', function() hs.grid.adjustWidth( 1) end)
-- hs.hotkey.bind(mash, '-', function() hs.grid.adjustWidth(-1) end)
-- hs.hotkey.bind(mash, ']', function() hs.grid.adjustHeight( 1) end)
-- hs.hotkey.bind(mash, '[', function() hs.grid.adjustHeight(-1) end)

---------------------------------

hs.alert.defaultStyle.strokeColor =  {white = 1, alpha = 0.75}
hs.alert.defaultStyle.fillColor =  {white = 0.05, alpha = 0.75}
hs.alert.defaultStyle.radius = 10
hs.alert.defaultStyle.strokeWidth = 1


hs.alert.defaultStyle.textColor = {white = 25, alpha = 0.25}

-- 11-06-2018 https://gist.github.com/tmiller/31409a34e28ad7381d9ce0bde48d8254

hs.window.animationDuration = 0
local screenMode = hs.hotkey.modal.new('cmd', 'j')

function screenMode:entered()
    alertUuids = hs.fnutils.imap(hs.screen.allScreens(), function(screen)
       return hs.alert.show('Move Window', hs.alert.defaultStyle, screen, true)
    end)
end

function screenMode:exited()
    hs.fnutils.ieach(alertUuids, function(uuid)
        hs.alert.closeSpecific(uuid)
    end)
end

grid = {
    { key='j', unit=hs.geometry.rect(0, 0.5, 1, 0.5) },
    { key='k', unit=hs.geometry.rect(0, 0, 1, 0.5) },
    { key='h', unit=hs.layout.left50 },
    { key='l', unit=hs.layout.right50 },

    { key='y', unit=hs.geometry.rect(0, 0, 0.5, 0.5) },
    { key='u', unit=hs.geometry.rect(0.5, 0, 0.5, 0.5) },
    { key='n', unit=hs.geometry.rect(0, 0.5, 0.5, 0.5) },
    { key='m', unit=hs.geometry.rect(0.5, 0.5, 0.5, 0.5) },

    { key='space', unit=hs.layout.maximized }
}

hs.fnutils.each(grid, function(entry)
   screenMode:bind('', entry.key, function()
        hs.window.focusedWindow():moveToUnit(entry.unit)
        -- screenMode:exit()
    end)
end)

screenMode:bind('ctrl', '[', function() screenMode:exit() end)
screenMode:bind('', 'escape', function() screenMode:exit() end)

screenMode:bind('cmd', 'h', function()
    hs.window.focusedWindow():moveOneScreenWest()
    screenMode:exit()
end)

screenMode:bind('cmd', 'l', function()
    hs.window.focusedWindow():moveOneScreenEast()
    screenMode:exit()
end)

screenMode:bind('cmd', 'j', function()
    screenMode:exit()
end)

screenMode:bind('', '.', function() screenMode:exit()
				   hs.hints.windowHints()
				   -- screenMode:exit()
end)

screenMode:bind('', 'i', function() 
				   hs.grid.pushWindowNextScreen()
				   -- screenMode:exit()
end)

screenMode:bind('', 'o', function() 
				   hs.grid.pushWindowPrevScreen()
				   -- screenMode:exit()
end)
	-- { key='i', unit=hs.grid.pushWindowNextSceen()},
	-- { key='o', unit=hs.grid.pushWindowPrevScreen()},
	-- { key='.', unit=hs.hints.windowHints},
