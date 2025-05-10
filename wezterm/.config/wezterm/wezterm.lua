local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

wezterm.on('gui-startup', function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

local config = wezterm.config_builder()

local function is_vim(pane)
    -- this is set by the plugin, and unset on ExitPre in Neovim
    return pane:get_user_vars().IS_NVIM == "true"
end

wezterm.on("update-status", function(window, pane)
    local our_tab = pane:tab()
    local is_zoomed = false
    if our_tab ~= nil then
        for _, pane_attributes in pairs(our_tab:panes_with_info()) do
            is_zoomed = pane_attributes['is_zoomed'] or is_zoomed
        end
    end
    if is_zoomed then
        window:set_right_status(wezterm.format {
            -- { Attribute = { Underline = 'Single' } }, -- comma here
            -- { Attribute = { Italic = true } },        -- comma here
            -- { Background = { Color = 'hsla(0, 0, 0, .05)' } }, -- comma here
            { Foreground = { Color = 'yellow' } }, -- comma here
            { Text = 'Z ' }                        -- no comma on last element
        })
        wezterm.emit("force-tabs-shown", window, pane)
    else
        window:set_right_status("")
    end
end)

config.font = wezterm.font "PragmataPro Nerd Font"
config.font_size = 14
-- -- config.color_scheme = 'Dracula (Official)'
-- config.color_scheme = 'Solarized (light) (terminal.sexy)'
config.color_scheme = 'Solarized Light (Gogh)'
config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
config.window_decorations = "RESIZE"

-- config.enable_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font { family = 'Roboto', weight = 'Bold' },
    -- The size of the font in the tab bar.
    -- Default to 10.0 on Windows but 12.0 on other systems
    font_size = 12.0,
    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = '#333333',
    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = '#333333',
}

config.colors = {
    tab_bar = {
        -- The color of the strip that goes along the top of the window
        -- (does not apply when fancy tab bar is in use)
        background = '#0b0022',

        -- The active tab is the one that has focus in the window
        active_tab = {
            -- The color of the background area for the tab
            bg_color = '#2b2042',
            -- The color of the text for the tab
            fg_color = '#c0c0c0',

            -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
            -- label shown for this tab.
            -- The default is "Normal"
            intensity = 'Normal',

            -- Specify whether you want "None", "Single" or "Double" underline for
            -- label shown for this tab.
            -- The default is "None"
            underline = 'None',

            -- Specify whether you want the text to be italic (true) or not (false)
            -- for this tab.  The default is false.
            italic = false,

            -- Specify whether you want the text to be rendered with strikethrough (true)
            -- or not for this tab.  The default is false.
            strikethrough = false,
        },

        -- Inactive tabs are the tabs that do not have focus
        inactive_tab = {
            bg_color = '#1b1032',
            fg_color = '#808080',

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab`.
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over inactive tabs
        inactive_tab_hover = {
            bg_color = '#3b3052',
            fg_color = '#909090',
            italic = true,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab_hover`.
        },

        -- The new tab button that let you create new tabs
        new_tab = {
            bg_color = '#1b1032',
            fg_color = '#808080',

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab`.
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over the new tab button
        new_tab_hover = {
            bg_color = '#3b3052',
            fg_color = '#909090',
            italic = true,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab_hover`.
        },
    },
    copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
    copy_mode_active_highlight_bg = { AnsiColor = 'White' },
    copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
    copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },
}

config.initial_rows = 50
config.initial_cols = 200
config.audible_bell = "Disabled"
config.send_composed_key_when_left_alt_is_pressed = true

config.term = "xterm-256color"

---

config.mouse_bindings = {
    -- Right click sends "woot" to the terminal
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = act.CompleteSelection 'ClipboardAndPrimarySelection',
    },

    -- and make CTRL-Click open hyperlinks
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = act.OpenLinkAtMouseCursor,
    },
    -- NOTE that binding only the 'Up' event can give unexpected behaviors.
    -- Read more below on the gotcha of binding an 'Up' event only.
}



---

local direction_keys = {
    h = "Left",
    j = "Down",
    k = "Up",
    l = "Right",
}
local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == "resize" and "CTRL|SHIFT" or "CTRL",
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                -- pass the keys through to vim/nvim
                win:perform_action({
                    SendKey = { key = key, mods = resize_or_move == "resize" and "CTRL|SHIFT" or "CTRL" },
                }, pane)
            else
                if resize_or_move == "resize" then
                    win:perform_action({ AdjustPaneSize = { direction_keys[key], 5 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                end
            end
        end),
    }
end

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

local action = wezterm.action

config.keys = {
    { key = "l", mods = "ALT",    action = wezterm.action.ShowLauncher },
    {
        key = "|",
        mods = "LEADER",
        action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "-",
        mods = "LEADER",
        action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "z",
        mods = "LEADER",
        action = action.TogglePaneZoomState,
    },
    { key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
    {
        key = "c",
        mods = "LEADER",
        action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
        key = "p",
        mods = "LEADER",
        action = action.ActivateTabRelative(-1),
    },
    {
        key = "n",
        mods = "LEADER",
        action = action.ActivateTabRelative(1),
    },
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {
        key = "a",
        mods = "LEADER|CTRL",
        action = action.SendKey({ key = "a", mods = "CTRL" }),
    },
    {
        key = 'x',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = ',',
        mods = 'LEADER',
        action = act.PromptInputLine {
            description = wezterm.format({
                { Text = 'Enter new name for tab: ' }
            }),
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
    split_nav("move", "h"),
    split_nav("move", "j"),
    split_nav("move", "k"),
    split_nav("move", "l"),
    split_nav("resize", "h"),
    split_nav("resize", "j"),
    split_nav("resize", "k"),
    split_nav("resize", "l"),
    {
        key = "9",
        mods = "ALT",
        action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|TABS|WORKSPACES" }),
    },
    {
        key = "W",
        mods = "CTRL|SHIFT",
        action = action.PromptInputLine({
            description = wezterm.format({
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { AnsiColor = "Fuchsia" } },
                { Text = "Enter name for new workspace" },
            }),
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        action.SwitchToWorkspace({
                            name = line,
                        }),
                        pane
                    )
                end
            end),
        }),
    },
}
config.key_tables = {
    -- added new shortcuts to the end
    copy_mode = {
        { key = "c",          mods = "CTRL",  action = act.CopyMode("Close") },
        { key = "g",          mods = "CTRL",  action = act.CopyMode("Close") },
        { key = "q",          mods = "NONE",  action = act.CopyMode("Close") },
        { key = "Escape",     mods = "NONE",  action = act.CopyMode("Close") },

        { key = "h",          mods = "NONE",  action = act.CopyMode("MoveLeft") },
        { key = "j",          mods = "NONE",  action = act.CopyMode("MoveDown") },
        { key = "k",          mods = "NONE",  action = act.CopyMode("MoveUp") },
        { key = "l",          mods = "NONE",  action = act.CopyMode("MoveRight") },

        { key = "LeftArrow",  mods = "NONE",  action = act.CopyMode("MoveLeft") },
        { key = "DownArrow",  mods = "NONE",  action = act.CopyMode("MoveDown") },
        { key = "UpArrow",    mods = "NONE",  action = act.CopyMode("MoveUp") },
        { key = "RightArrow", mods = "NONE",  action = act.CopyMode("MoveRight") },

        { key = "RightArrow", mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
        { key = "f",          mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
        { key = "Tab",        mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
        { key = "w",          mods = "NONE",  action = act.CopyMode("MoveForwardWord") },

        { key = "LeftArrow",  mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
        { key = "b",          mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
        { key = "Tab",        mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
        { key = "b",          mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },

        { key = "0",          mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
        { key = "Enter",      mods = "NONE",  action = act.CopyMode("MoveToStartOfNextLine") },

        { key = "$",          mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
        { key = "$",          mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
        { key = "^",          mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
        { key = "^",          mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
        { key = "m",          mods = "ALT",   action = act.CopyMode("MoveToStartOfLineContent") },

        { key = " ",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Cell" } },
        { key = "v",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Cell" } },
        { key = "V",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Line" } },
        { key = "V",          mods = "SHIFT", action = act.CopyMode { SetSelectionMode = "Line" } },
        { key = "v",          mods = "CTRL",  action = act.CopyMode { SetSelectionMode = "Block" } },

        { key = "G",          mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
        { key = "G",          mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
        { key = "g",          mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },

        { key = "H",          mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
        { key = "H",          mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
        { key = "M",          mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
        { key = "M",          mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
        { key = "L",          mods = "NONE",  action = act.CopyMode("MoveToViewportBottom") },
        { key = "L",          mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },

        { key = "o",          mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
        { key = "O",          mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
        { key = "O",          mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

        { key = "PageUp",     mods = "NONE",  action = act.CopyMode("PageUp") },
        { key = "PageDown",   mods = "NONE",  action = act.CopyMode("PageDown") },

        { key = "b",          mods = "CTRL",  action = act.CopyMode("PageUp") },
        { key = "f",          mods = "CTRL",  action = act.CopyMode("PageDown") },

        -- Enter y to copy and quit the copy mode.
        {
            key = "y",
            mods = "NONE",
            action = act.Multiple {
                act.CopyTo("ClipboardAndPrimarySelection"),
                act.CopyMode("Close"),
            }
        },
        -- Enter search mode to edit the pattern.
        -- When the search pattern is an empty string the existing pattern is preserved
        { key = "/", mods = "NONE", action = act { Search = { CaseSensitiveString = "" } } },
        { key = "?", mods = "NONE", action = act { Search = { CaseInSensitiveString = "" } } },
        { key = "n", mods = "CTRL", action = act { CopyMode = "NextMatch" } },
        { key = "p", mods = "CTRL", action = act { CopyMode = "PriorMatch" } },
    },

    search_mode = {
        { key = "Escape", mods = "NONE", action = act { CopyMode = "Close" } },
        -- Go back to copy mode when pressing enter, so that we can use unmodified keys like "n"
        -- to navigate search results without conflicting with typing into the search area.
        { key = "Enter",  mods = "NONE", action = "ActivateCopyMode" },
        { key = "c",      mods = "CTRL", action = "ActivateCopyMode" },
        { key = "n",      mods = "CTRL", action = act { CopyMode = "NextMatch" } },
        { key = "p",      mods = "CTRL", action = act { CopyMode = "PriorMatch" } },
        { key = "r",      mods = "CTRL", action = act.CopyMode("CycleMatchType") },
        { key = "u",      mods = "CTRL", action = act.CopyMode("ClearPattern") },
    }
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = action.ActivateTab(i - 1),
    })
end

config.status_update_interval = 10000

---
return config
