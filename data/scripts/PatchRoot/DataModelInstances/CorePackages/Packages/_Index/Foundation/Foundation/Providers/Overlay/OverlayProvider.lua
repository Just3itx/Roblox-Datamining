-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Constants = require(Foundation.Constants)

local getMainGui = require(Foundation.Utility.getMainGui)
local withDefaults = require(Foundation.Utility.withDefaults)
local useStyleSheet = require(Foundation.Providers.Style.StyleSheetContext).useStyleSheet
local _Types = require(Foundation.Components.Types)

local OverlayContext = require(script.Parent.OverlayContext)
local useKeyboardAwareSize = require(script.Parent.useKeyboardAwareSize)

local React = require(FoundationParent.React)
local ReactRoblox = require(FoundationParent.ReactRoblox)

local tbl1 = {
    DisplayOrder = Constants.MAX_LAYOUT_ORDER - 1
}

local function OverlayProvider(arg1)
    local var1 = withDefaults(arg1, tbl1)
    local var2, ref = React.useState(var1.gui)
    local var4, var5 = React.useState(false)
    local parent = if var1.gui then nil else var2 and var2.Parent
    local var6 = useKeyboardAwareSize(parent)
    local styleSheet = useStyleSheet()

    local requestOverlay = React.useCallback(function()
        if var1.gui == nil then
            var5(true)
        end
    end, { var1.gui })

    local mainGui = if var1.gui == nil and var4 then getMainGui() else nil

    if var1.gui ~= nil or mainGui == nil then
        var4 = false
    end

    if var1.gui ~= nil then
        var2 = var1.gui
    end

    if var1.gui ~= nil then
        parent = var1.gui
    end
    local value = React.useMemo(function()
        return { requestOverlay = requestOverlay, instance = var2, screen = parent }
    end, { requestOverlay, var2, parent })

    local createElement = React.createElement
    local provider = OverlayContext.Provider
    local tbl2 = { value = value }
    local tbl3 = { FoundationOverlay = 0, Children = 0 }
    local portal

    if var4 then
        portal = ReactRoblox.createPortal(
            React.createElement("ScreenGui", {
                Enabled = true,
                DisplayOrder = var1.DisplayOrder,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
                SafeAreaCompatibility = Enum.SafeAreaCompatibility.None,
                ClipToDeviceSafeArea = false
            }, {
                SafeAreaFrame = React.createElement("Frame", { Size = var6, BackgroundTransparency = 1, BorderSizePixel = 0, ref = ref }),
                FoundationStyleLink = React.createElement("StyleLink", { StyleSheet = styleSheet })
            }),
            mainGui
        )
    else
        portal = nil
    end

    tbl3.FoundationOverlay = portal

    tbl3.Children = React.createElement(React.Fragment, nil, var1.children)
    return createElement(provider, tbl2, tbl3)
end

return OverlayProvider
