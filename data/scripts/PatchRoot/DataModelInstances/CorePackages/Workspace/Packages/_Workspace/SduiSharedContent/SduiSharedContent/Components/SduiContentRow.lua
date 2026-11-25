-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local Responsive = require(SduiSharedContentParent.Responsive)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local FFlagSduiContentRowStateLayer = require(SduiSharedContent.Flags.FFlagSduiContentRowStateLayer)
local FFlagSDUIContentRowSelectable = require(SduiSharedContent.Flags.FFlagSDUIContentRowSelectable)
local FFlagSduiContentRowTrailingHover = require(SduiSharedContentParent.SharedFlags).FFlagSduiContentRowTrailingHover

local FFlagSduiContentRowTrailingHoverPointerOnly = require(SduiSharedContent.Flags.FFlagSduiContentRowTrailingHoverPointerOnly)

local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local CursorType = Foundation.Enums.CursorType
local useCursor = Foundation.Hooks.useCursor

return React.memo(function(tbl1) -- name: SduiContentRow
    local var1, var2

    if FFlagSduiContentRowTrailingHover then
        local bool1 = if FFlagSduiContentRowTrailingHoverPointerOnly then Responsive.useLastInput() == Responsive.Input.Pointer else nil
        local var3, var4 = React.useState(false)
        var1 = React.useCallback(function(arg1)
            var4(arg1 == ControlState.Hover or arg1 == ControlState.Pressed)
        end, {})

        if tbl1.trailingHover ~= nil and var3 and (not FFlagSduiContentRowTrailingHoverPointerOnly or bool1) then
            var2 = tbl1.trailingHover
        else
            var2 = tbl1.trailing
        end
    else
        var2 = nil
        var1 = nil
    end

    local selectable = FFlagSDUIContentRowSelectable and tbl1.selectable == true
    local var4 = if FFlagSDUIContentRowSelectable then useCursor(CursorType.RoundedRect) else nil
    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        tag = if tbl1.tag then tbl1.tag else "row auto-y gap-large",
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        ZIndex = tbl1.zIndex,
        Active = tbl1.onActivated ~= nil,
        onActivated = tbl1.onActivated,
        onStateChanged = 0,
        selection = 0,
        stateLayer = 0,
        testId = 0
    }

    if not FFlagSduiContentRowTrailingHover or tbl1.trailingHover == nil then
        var1 = nil
    end

    tbl2.onStateChanged = var1

    local selection = { Selectable = selectable, SelectionImageObject = 0 }
    if not selectable then
        var4 = nil
    end

    selection.SelectionImageObject = var4
    tbl2.selection = selection

    tbl2.stateLayer = {
        affordance = if FFlagSduiContentRowStateLayer then tbl1.stateLayerAffordance or Foundation.Enums.StateLayerAffordance.None else Foundation.Enums.StateLayerAffordance.None
    }

    tbl2.testId = tbl1.testId
    local tbl4 = {
        LeadingColumn = if tbl1.leading then React.createElement(View, { LayoutOrder = 1, tag = tbl1.leadingTag or "col auto-xy" }, tbl1.leading) else nil,
        ContentColumn = if tbl1.content then React.createElement(View, { LayoutOrder = 2, tag = tbl1.contentTag or "col fill gap-small auto-xy" }, tbl1.content) else nil,
        TrailingColumn = 0
    }
    local var6 = if FFlagSduiContentRowTrailingHover then var2 else tbl1.trailing
    local var7

    if var6 then
        local createElement2 = React.createElement
        local var8 = View
        local tbl5 = {
            LayoutOrder = 3,
            tag = tbl1.trailingTag or "col auto-xy"
        }

        if not FFlagSduiContentRowTrailingHover then
            var2 = tbl1.trailing
        end

        var7 = createElement2(var8, tbl5, var2)
    else
        var7 = nil
    end

    tbl4.TrailingColumn = var7
    return createElement(var5, tbl2, tbl4)
end)
