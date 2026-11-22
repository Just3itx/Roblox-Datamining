-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local _React = require(SplitPaneParent.React)

local function expandRect(rect: Rect, collapsedSpotlightPadding: number): Rect -- Luacid: Inlined by compiler; 1 call site recovered
    return Rect.new(
        rect.Min.X - collapsedSpotlightPadding,
        rect.Min.Y - collapsedSpotlightPadding,
        rect.Max.X + collapsedSpotlightPadding,
        rect.Max.Y + collapsedSpotlightPadding
    )
end
return function(tbl1)
    local isSupportPaneCollapsed = tbl1.stepIndex == 1 and tbl1.isSupportPaneCollapsed
    local isDirectionalInput = isSupportPaneCollapsed and tbl1.isDirectionalInput
    local bool1 = not isSupportPaneCollapsed

    if not bool1 then
        if tbl1.anchors.gamepadCollapsedStepOne ~= nil then
            bool1 = true
        elseif tbl1.collapsedExpandButtonRect == nil then
            bool1 = false
        else
            bool1 = tbl1.anchors.collapsedExpandButton ~= nil
        end
    end

    local var1

    if isDirectionalInput and tbl1.anchors.gamepadCollapsedStepOne ~= nil then
        var1 = tbl1.anchors.gamepadCollapsedStepOne
    elseif isSupportPaneCollapsed and tbl1.anchors.collapsedExpandButton ~= nil then
        var1 = tbl1.anchors.collapsedExpandButton
    elseif tbl1.stepIndex == 2 and tbl1.isDirectionalInput and tbl1.anchors.gamepadStepTwo ~= nil then
        var1 = tbl1.anchors.gamepadStepTwo
    elseif tbl1.stepIndex == 2 and tbl1.anchors.bottomPane ~= nil then
        var1 = tbl1.anchors.bottomPane
    elseif tbl1.stepIndex == 3 and tbl1.isDirectionalInput and tbl1.anchors.gamepadFinal ~= nil then
        var1 = tbl1.anchors.gamepadFinal
    elseif tbl1.stepIndex == 3 and tbl1.anchors.topRightControl ~= nil then
        var1 = tbl1.anchors.topRightControl
    else
        var1 = tbl1.anchors.supportPane
    end

    return {
        isCollapsedStepOne = isSupportPaneCollapsed,
        isGamepadCollapsedStepOne = isDirectionalInput,
        isAnchorReady = bool1,
        anchorRef = var1,
        spotlightRect = if isSupportPaneCollapsed and not isDirectionalInput and tbl1.collapsedExpandButtonRect ~= nil then expandRect(tbl1.collapsedExpandButtonRect, tbl1.collapsedSpotlightPadding) else nil,
        dimEndX = if isSupportPaneCollapsed or tbl1.supportPaneRect == nil then nil else tbl1.supportPaneRect.Min.X
    }
end
