-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local Constants = require(InterventionShared.Utils.Constants)
local React = require(InterventionSharedParent.React)
local useLayerCollector = require(InterventionSharedParent.UIBlox).Core.Layout.LayerCollector.useLayerCollector

local function useScrollFrameHeightCalculation(tbl1)
    local var1 = useLayerCollector()
    local var2 = tbl1.screenSize or var1.absoluteSize
    local var3, var4 = React.useState(tbl1.initialInnerContentHeight or 0)
    local onInnerContentSizeChanged = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize.Y)
    end, {})
    local var6 = tbl1.scrollFrameHeaderFooterHeight or Constants.DIALOG_HEADER_HEIGHT
    local var7 = var2.Y - Constants.UNIBAR_HEIGHT - var6
    if tbl1.screenSize then
        var7 = math.max(0, var7)
    end
    local scrollFrameContainerHeight = math.ceil(math.min(var7, var3))
    return {
        onInnerContentSizeChanged = onInnerContentSizeChanged,
        scrollFrameContainerHeight = scrollFrameContainerHeight,
        shouldShowScrollBar = scrollFrameContainerHeight < var3
    }
end

return useScrollFrameHeightCalculation
