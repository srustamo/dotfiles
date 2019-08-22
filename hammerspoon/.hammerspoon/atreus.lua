-- https://github.com/tekezo/Karabiner/issues/354
-- 12/08/16
--local usbWatcher = nil

--function usbDeviceCallback(data)
--    --if (data["productName"] == "Atreus") then
--    if (data["productID"] == "0x6060") then
--        if (data["eventType"] == "added") then
--            hs.execute('/Applications/Karabiner.app/Contents/Library/bin/karabiner select 4')
--        elseif (data["eventType"] == "removed") then
--            hs.execute('/Applications/Karabiner.app/Contents/Library/bin/karabiner select 0')
--        end
--    end
--end

--usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
--usbWatcher:start()

--https://github.com/tekezo/Karabiner/issues/354 Tue Dec  5 17:33:52 2017
-- hs.execute('/Applications/Karabiner.app/Contents/Library/bin/karabiner select 0')
-- 06-06-2018 OSX High Sierra
-- hs.execute('/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli --select-profile d' )
-- 07-06-2018 https://github.com/Hammerspoon/hammerspoon/issues/1810
hs.execute [["/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli" "--select-profile" "m"]]


local usb_table = nil

usb_table = hs.usb.attachedDevices()

for index, usb_device in pairs(usb_table) do
	if (usb_device["productName"] == "Atreus") then
--		hs.execute('/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli --select-profile a')
		hs.execute [["/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli" "--select-profile" "a"]]
	end
end

local usbWatcher = nil

function usbDeviceCallback(data)
    if (data["productName"] == "Atreus") then
        if (data["eventType"] == "added") then
		hs.execute [["/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli" "--select-profile" "a"]]
		hs.alert("Atreus profile")
--           hs.execute('/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli select 4')
        elseif (data["eventType"] == "removed") then
--           hs.execute('/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli select 0')
			 hs.execute [["/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli" "--select-profile" "m"]]
			 hs.alert("Mac profile")
        end
    end
end

usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()
