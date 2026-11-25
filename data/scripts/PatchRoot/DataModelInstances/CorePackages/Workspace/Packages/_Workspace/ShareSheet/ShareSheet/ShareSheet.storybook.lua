-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local LocalizationService = game:GetService("LocalizationService")

local React = require(ShareSheetParent.React)
local ReactRoblox = require(ShareSheetParent.ReactRoblox)
local Foundation = require(ShareSheetParent.Foundation)
local Localization = require(ShareSheetParent.Localization)
local RobloxAppLocales = require(ShareSheetParent.RobloxAppLocales)

local LocalizationProvider = Localization.LocalizationProvider
local Localization2 = RobloxAppLocales.Localization

local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device

local tbl1 = {
    Dark = ColorMode.Dark,
    Light = ColorMode.Light
}

local useStyleSheet = Foundation.Hooks.useStyleSheet

local function StyleLinkPortal(tbl2)
    local styleSheet = useStyleSheet()
    return ReactRoblox.createPortal(React.createElement("StyleLink", { StyleSheet = styleSheet }), tbl2.overlay)
end

return {
    name = "ShareSheet",
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

            return React.createElement(LocalizationProvider, { localization = localization }, { React.createElement(
                    FoundationProvider,
                    {
                        colorMode = tbl1[arg2.theme] or ColorMode.Dark,
                        device = Device[arg2.platform] or Device.Phone,
                        preferences = arg2.settings,
                        scale = arg2.settings and arg2.settings.scale,
                        overlayGui = var1.current
                    },
                    {
                        Story = React.createElement(arg1, arg2),
                        StyleLink = React.createElement(StyleLinkPortal, { overlay = var1.current })
                    }
                ) })
        end
    end,
    storyRoot = ShareSheet
}
