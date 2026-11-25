-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local React = require(SduiSharedUtilitiesParent.React)
local Loading = require(SduiSharedUtilitiesParent.Foundation).Loading
local SduiFeatureErrorUi = require(SduiSharedUtilities.ui.SduiFeatureErrorUi)
local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)

local FFlagSduiFeatureEntryPointTakesAbsoluteSizeHandler = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiFeatureEntryPointTakesAbsoluteSizeHandler

return React.forwardRef(function(tbl1, ref) -- name: SduiFeatureEntryPointUi
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = if tbl1.Size then tbl1.Size else UDim2.new(1, 0, 0, 0),
        AutomaticSize = if tbl1.AutomaticSize then tbl1.AutomaticSize else Enum.AutomaticSize.Y,
        Position = tbl1.Position,
        LayoutOrder = tbl1.LayoutOrder,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        [React.Change.AbsoluteSize] = if FFlagSduiFeatureEntryPointTakesAbsoluteSizeHandler then tbl1.onAbsoluteSizeChange else nil,
        ref = ref
    }
    local tbl3 = { Content = 0 }
    local var1

    if tbl1.uiStatus == "Loading" and tbl1.shouldDisplayLoading then
        if tbl1.loadingSlot then
            var1 = tbl1.loadingSlot
        else
            var1 = React.createElement(Loading, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                testId = "sdui-feature-entry-point-loading"
            })
        end
    elseif tbl1.uiStatus == "Error" and tbl1.shouldDisplayError then
        if tbl1.errorSlot then
            var1 = tbl1.errorSlot
        else
            var1 = React.createElement(SduiFeatureErrorUi, { onRetry = tbl1.onRetry })
        end
    elseif tbl1.uiStatus == "Resolved" then
        var1 = tbl1.contentSlot
    else
        var1 = nil
    end

    tbl3.Content = var1
    return createElement(str1, tbl2, tbl3)
end)
