-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)
local ReactRoblox = require(GiftingParent.Dev.ReactRoblox)

local FoundationProvider = Foundation.FoundationProvider
local Theme = Foundation.Enums.Theme
local Device = Foundation.Enums.Device
local useStyleSheet = Foundation.Hooks.useStyleSheet

local tbl1 = {
    Default = Theme.Dark,
    Light = Theme.Light,
    Dark = Theme.Dark
}

local tbl2 = {
    Default = Device.Desktop,
    Desktop = Device.Desktop,
    Console = Device.Console
}

local function StyleLinkPortal(tbl3)
    local styleSheet = useStyleSheet()
    return ReactRoblox.createPortal(React.createElement("StyleLink", { StyleSheet = styleSheet }), tbl3.overlay)
end

return {
    name = Gifting.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = React.useRef(Instance.new("Frame"))
            if var1.current.Parent ~= arg2.focus then
                var1.current.Parent = arg2.focus
            end

            React.useLayoutEffect(function()
                var1.current.Name = "GiftingOverlay"
                var1.current.Size = UDim2.fromScale(1, 1)
                var1.current.BackgroundTransparency = 1
            end, {})

            return React.createElement(FoundationProvider, {
                theme = arg2 and tbl1[arg2.theme] or tbl1.Default,
                device = arg2 and tbl2[arg2.platform] or tbl2.Default,
                preferences = arg2 and arg2.settings,
                overlayGui = var1.current
            }, {
                Story = React.createElement(arg1, arg2),
                StyleLink = React.createElement(StyleLinkPortal, { overlay = var1.current })
            })
        end
    end,
    storyRoots = { Gifting }
}
