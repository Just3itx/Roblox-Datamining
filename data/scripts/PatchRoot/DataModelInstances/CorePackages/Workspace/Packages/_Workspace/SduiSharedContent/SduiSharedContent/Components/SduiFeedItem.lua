-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local useImpressionsTagger = require(SduiSharedContentParent.Impressions).useImpressionsTagger
local FFlagAppPageShellScrollToTopFocus = require(SduiSharedContentParent.SharedFlags).FFlagAppPageShellScrollToTopFocus

return React.memo(function(tbl1) -- name: SduiFeedItem
    local var1 = React.useRef(nil)

    local var2 = if FFlagAppPageShellScrollToTopFocus then React.useCallback(function(current)
        var1.current = current
        if type(tbl1.defaultFocusRef) == "function" then
            tbl1.defaultFocusRef(current)
        elseif type(tbl1.defaultFocusRef) == "table" then
            tbl1.defaultFocusRef.current = current
        end
    end, { tbl1.defaultFocusRef }) else nil

    useImpressionsTagger(var1, tbl1.impressionsTag, tbl1.index)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        ref = 0,
        Size = 0,
        AutomaticSize = 0,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        SelectionGroup = true,
        SelectionBehaviorLeft = 0,
        SelectionBehaviorRight = 0,
        LayoutOrder = 0,
        ZIndex = 0
    }

    if not FFlagAppPageShellScrollToTopFocus then
        var2 = var1
    end

    tbl2.ref = var2
    tbl2.Size = UDim2.new(1, 0, 0, 0)
    tbl2.AutomaticSize = Enum.AutomaticSize.Y

    tbl2.SelectionBehaviorLeft = tbl1.selectionBehaviorLeft
    tbl2.SelectionBehaviorRight = tbl1.selectionBehaviorRight
    tbl2.LayoutOrder = tbl1.layoutOrder
    tbl2.ZIndex = tbl1.zIndex
    return createElement(str1, tbl2, tbl1.children)
end)
