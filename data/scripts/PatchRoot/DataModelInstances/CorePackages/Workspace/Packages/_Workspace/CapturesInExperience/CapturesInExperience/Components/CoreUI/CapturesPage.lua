-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)

local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local CaptureConfigCTAs = require(scriptParentParentParent.Components.CoreUI.CaptureConfigCTAs)
local CapturesGallery = require(scriptParentParentParent.Components.CapturesGallery.CapturesGallery)
local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)

return function(tbl1)
    local closeSettingsMenu = React.useCallback(function()
        tbl1.closeSettingsMenu()
    end, {})

    local var2 = useAnalytics()
    local var3, var4 = React.useState(0)

    local var5 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsMenuOpen
    end)

    useEffectOnce(function()
        var2.fireEvent(EventNames.CapturesPageOpenedInGameMenu)
    end, var5)

    local onAbsoluteSizeChanged = React.useCallback(function(vector2: Vector2)
        var4(vector2.Y)
    end, {})

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Visible = var5
    }, {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, 12)
        }),
        CaptureConfigCTAs = React.createElement(
            CaptureConfigCTAs,
            {
                closeSettingsMenu = closeSettingsMenu,
                LayoutOrder = 1,
                onAbsoluteSizeChanged = onAbsoluteSizeChanged
            }
        ),
        CapturesGallery = React.createElement(CapturesGallery, { LayoutOrder = 2, Size = UDim2.new(1, 0, 1, -var3 - 12) })
    })
end
