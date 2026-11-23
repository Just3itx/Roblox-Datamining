-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)
local RobloxAppLocales = require(BuildExperienceParent.RobloxAppLocales)

local FoundationProvider = Foundation.FoundationProvider
local LocalizationProvider = Localization.LocalizationProvider
local Device = Foundation.Enums.Device
local ColorMode = Foundation.Enums.ColorMode
local Localization2 = RobloxAppLocales.Localization
local useStyleSheet = Foundation.Hooks.useStyleSheet

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

local tbl2 = {
    Console = Device.Console,
    Desktop = Device.Desktop
}

local function StyleLinkPortal(tbl3)
    local styleSheet = useStyleSheet()
    return ReactRoblox.createPortal(React.createElement("StyleLink", { StyleSheet = styleSheet }), tbl3.overlay)
end

return {
    name = BuildExperience.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = React.useRef(Instance.new("Frame"))
            if var1.current.Parent ~= arg2.focus then
                var1.current.Parent = arg2.focus
            end

            React.useLayoutEffect(function()
                var1.current.Size = UDim2.fromScale(1, 1)
                var1.current.BackgroundTransparency = 1
            end, {})

            local localization = React.useMemo(function()
                return Localization2.new(LocalizationService.RobloxLocaleId)
            end, {})

            return React.createElement(LocalizationProvider, { localization = localization }, {
                FoundationProvider = React.createElement(
                    FoundationProvider,
                    {
                        colorMode = tbl1[arg2.theme],
                        device = tbl2[arg2.platform],
                        preferences = arg2.settings,
                        overlayGui = var1.current
                    },
                    {
                        Story = React.createElement(arg1, arg2),
                        StyleLink = React.createElement(StyleLinkPortal, { overlay = var1.current })
                    }
                )
            })
        end
    end,
    storyRoots = { BuildExperience }
}
