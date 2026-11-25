-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)

local View = Foundation.View

return React.memo(function(tbl1) -- name: SduiSubscriptionCell
    return React.createElement(View, {
        tag = if tbl1.tag then tbl1.tag else "col size-full-0 auto-y gap-medium padding-medium bg-surface-100 radius-medium",
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        ZIndex = tbl1.zIndex,
        Active = tbl1.onActivated ~= nil,
        onActivated = tbl1.onActivated,
        selection = { Selectable = false },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        testId = tbl1.testId
    }, {
        ContentRowSlot = if tbl1.contentRowComponent then React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = if tbl1.contentRowSlotTag then tbl1.contentRowSlotTag else "size-full-0 auto-y"
            },
            tbl1.contentRowComponent
        ) else nil,
        ButtonSlot = if tbl1.buttonComponent then React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = if tbl1.buttonSlotTag then tbl1.buttonSlotTag else "size-full-0 auto-y"
            },
            tbl1.buttonComponent
        ) else nil
    })
end)
