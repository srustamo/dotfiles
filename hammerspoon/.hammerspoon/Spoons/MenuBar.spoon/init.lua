--Wed Sep  1 14:17:49 2021 
--https://gist.github.com/bezhermoso/5f45ace434a7b03c963a
-- need to remove space between NotificationCenter
--- === DismissNotifications ===
---
--- Send clipboard contents to DismissNotifications
---
--- Conversion of tldm's pastebin gist to a Spoon https://gist.github.com/tdlm/5eba0299f2924a8aaf46
--- Code by @tdlm, spoon by Tyler Thrailkill <tyler.b.thrailkill@gmail.com>
---
--- https://github.com/snowe2010

local obj = {}
obj.__index = obj

-- Metadata
obj.name = 'MenuBar'
obj.version = '1.0'
obj.author = 'Shavkat'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

--- DismissNotifications.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('MenuBar')

function obj:menubar_toggle()
    code, output, descriptor =
        hs.osascript.applescript(
        string.format(
            [[
		tell application "System Preferences"
			reveal pane id "com.apple.preference.general"
			try
				--wait for screen to boot
				repeat until window "General" exists
					delay 0.2
				end repeat
				delay 0.5
			on error error_message
				get error_message
			end try
		end tell
		tell application "System Events" to tell process "System Preferences" to tell window "General"
			click checkbox "Automatically hide and show the menu bar"
		end tell
		quit application "System Preferences"
        ]]
        )
    )
    obj.logger.df('Menubar toggle [code=%s, output=%s, descriptor=%s]', code, output, descriptor)
end


--- DismissNotifications:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for DismissNotifications
---
--- Parameters:
---  * mapping - A table containing hotkey objifier/key details for the following items:
---   * all - dismiss all notifications
---   * top - dismiss the top notification
---   * top_click - click the top notification
---   * top_secondary - click the top notifications second option
function obj:bindHotkeys(keys)
    hs.hotkey.bindSpec(
        keys['menubar_toggle'],
        'Toggle menubar',
        function()
            self.menubar_toggle()
        end
    )
end

return obj
