-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")

local ReactionsParent = Reactions.Parent
local React = require(ReactionsParent.React)
local Foundation = require(ReactionsParent.Foundation)

local success, ReactRoblox = pcall(function()
    return require(ReactionsParent.Dev.ReactRoblox)
end)
if not success then
    local Packages = script:FindFirstAncestor("Packages")
    ReactRoblox = require(Packages.ReactRoblox)
end

local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local FoundationProvider = Foundation.FoundationProvider
local useStyleSheet = Foundation.Hooks.useStyleSheet

local function StyleLinkPortal(tbl1)
    local styleSheet = useStyleSheet()
    return ReactRoblox.createPortal(React.createElement("StyleLink", { StyleSheet = styleSheet }), tbl1.overlay)
end

return {
    name = Reactions.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = React.useRef(nil)
            if var1.current == nil then
                local foundationOverlay = Instance.new("Frame")
                foundationOverlay.Name = "FoundationOverlay"
                foundationOverlay.Size = UDim2.fromScale(1, 1)
                foundationOverlay.BackgroundTransparency = 1
                foundationOverlay.ZIndex = 1000
                var1.current = foundationOverlay
            end
            local current = var1.current
            if current.Parent ~= arg2.focus then
                current.Parent = arg2.focus
            end

            React.useEffect(function()
                return function()
                    current:Destroy()
                end
            end, { current })

            return React.createElement(
                FoundationProvider,
                {
                    colorMode = ColorMode[arg2.theme] or ColorMode.Dark,
                    device = Device[arg2.platform] or Device.Desktop,
                    overlayGui = current
                },
                {
                    Story = React.createElement(arg1, arg2),
                    StyleLink = React.createElement(StyleLinkPortal, { overlay = current })
                }
            )
        end
    end,
    storyRoots = { Reactions }
}
