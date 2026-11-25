-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local ReactRoblox = require(PeopleReactViewParent.ReactRoblox)
local Signal = require(PeopleReactViewParent.AppCommonLib).Signal
local LocalizationProvider = require(PeopleReactViewParent.Localization).LocalizationProvider

local FoundationProvider = Foundation.FoundationProvider
local useStyleSheet = Foundation.Hooks.useStyleSheet

local tbl1 = { Default = "Desktop", Desktop = "Desktop", Console = "Console" }

local tbl2 = {
    ["Feature.SettingsHub.Action.Block"] = "Block",
    ["Feature.SettingsHub.Action.Unblock"] = "Unblock",
    ["Feature.SettingsHub.Label.Mute"] = "Mute",
    ["Feature.SettingsHub.Label.Unmute"] = "Unmute",
    ["CoreScripts.InGameMenu.QuickActions.Report"] = "Report",
    ["CoreScripts.InGameMenu.GameSettings.Volume"] = "Volume",
    ["Feature.SettingsHub.Label.VoiceChat"] = "Voice chat",
    ["CoreScripts.InGameMenu.VoiceChatVolumeLower"] = "Voice chat volume",
    ["Feature.SettingsHub.Prompt.BuyWhatTheyreWearing"] = "Buy what they’re wearing\t",
    ["Feature.SettingsHub.Description.SelectAvatarToCheckoutItems"] = "Select an avatar to check out their items.",
    ["Feature.SettingsHub.Description.SelectUsernameToViewProfile"] = "View profiles by selecting a username.",
    ["Feature.SettingsHub.Action.Ok"] = "Ok"
}

local localization = {
    Format = function(_, str1: string)
        return tbl2[str1] or str1
    end,
    changed = Signal.new(),
    GetLocale = function(): string
        return "en-us"
    end
}

local function StyleLinkPortal(tbl4)
    local styleSheet = useStyleSheet()
    return ReactRoblox.createPortal(React.createElement("StyleLink", { StyleSheet = styleSheet }), tbl4.overlay)
end

return {
    name = PeopleReactView.Name,
    storyRoot = PeopleReactView,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1) -- name: StoryBookMapStory
        return function(arg2)
            local var1 = React.useRef(Instance.new("Frame"))
            if var1.current.Parent ~= arg2.focus then
                var1.current.Parent = arg2.focus
            end

            React.useLayoutEffect(function()
                var1.current.Size = UDim2.fromScale(1, 1)
                var1.current.BackgroundTransparency = 1
            end, {})

            return React.createElement(LocalizationProvider, { localization = localization }, {
                FoundationProvider = React.createElement(FoundationProvider, {
                    colorMode = Foundation.Enums.ColorMode.Dark,
                    device = arg2 and tbl1[arg2.platform] or "Desktop",
                    overlayGui = var1.current
                }, {
                    Child = React.createElement(arg1, arg2),
                    StyleLink = React.createElement(StyleLinkPortal, { overlay = var1.current })
                })
            })
        end
    end
}
