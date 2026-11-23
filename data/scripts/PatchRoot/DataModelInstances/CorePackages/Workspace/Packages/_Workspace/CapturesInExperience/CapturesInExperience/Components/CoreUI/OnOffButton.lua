-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local SegmentedControl = require(scriptParentParentParentParent.UIBlox).App.Control.SegmentedControl

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local onToggleActivation = require(scriptParentParentParent.Utils.onToggleActivation)
local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()

    local var3 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsCapturesCoreGuiEnabled
    end)

    local var4 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsActive
    end)

    local var5 = useLocalization({ offText = "Feature.Captures.Control.Off", onText = "Feature.Captures.Control.On" })

    local onTabActivated = React.useCallback(function(arg1)
        onToggleActivation(
            var4,
            arg1,
            var1.fireEvent,
            var2,
            EventNames.CapturesActivatedInGameMenu,
            EventNames.CapturesDeactivatedInGameMenu
        )
    end, { var4 })

    return React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(tbl1.width, tbl1.height)
    }, {
        Control = React.createElement(SegmentedControl, {
            height = tbl1.height,
            onTabActivated = onTabActivated,
            selectedTabIndex = if var4 then 1 else 2,
            tabs = {
                {
                    tabName = var5.onText,
                    isDisabled = not var3
                },
                {
                    tabName = var5.offText,
                    isDisabled = not var3
                }
            },
            width = UDim.new(0, tbl1.width)
        })
    })
end
