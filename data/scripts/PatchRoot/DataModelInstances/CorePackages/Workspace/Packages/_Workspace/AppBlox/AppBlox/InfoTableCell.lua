-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)
local View = Foundation.View
local Divider = Foundation.Divider
local Icon = Foundation.Icon
local Enums = Foundation.Enums

local function func1() end

local tbl1 = {
    affordance = Enums.StateLayerAffordance.None
}

return React.memo(function(tbl2) -- name: InfoTableCell
    local bool1 = (tbl2.numColumns or 1) == 1

    local bool2 = tbl2.selectable ~= false
    local selection = React.useMemo(function(): {Selectable: boolean, SelectionOrder: any}?
        return if bool2 then {
            Selectable = true,
            SelectionOrder = tbl2.selectionOrder
        } else nil
    end, { bool2, tbl2.selectionOrder })

    local createElement = React.createElement
    local var2 = View
    local tbl3 = {
        tag = "col size-full-0 auto-y",
        onActivated = 0,
        selection = 0,
        stateLayer = 0,
        testId = 0
    }
    local onActivated = tbl2.onActivated

    if not onActivated then
        if bool2 then
            onActivated = func1
        else
            onActivated = nil
        end
    end

    tbl3.onActivated = onActivated
    tbl3.selection = selection
    tbl3.stateLayer = if bool2 and not tbl2.onActivated then tbl1 else nil
    tbl3.testId = tbl2.testId
    local tbl4 = {
        TopDivider = if bool1 then nil else React.createElement(Divider, { LayoutOrder = 1 }),
        LabelValueContainer = 0,
        BottomDivider = 0
    }
    local createElement2 = React.createElement
    local var3 = View
    local tbl5 = {
        LayoutOrder = 2,
        tag = {
            ["row size-full-0 auto-y flex-x-between gap-medium padding-y-large"] = bool1,
            ["col size-full-0 auto-y padding-y-medium"] = not bool1
        }
    }
    local tbl6 = {
        Label = tbl2.labelComponent,
        ValueContainer = React.createElement(View, {
            LayoutOrder = 2,
            tag = {
                ["row size-0-full auto-xy fill align-x-right"] = bool1,
                ["row size-full-0 auto-y"] = not bool1
            }
        }, {
            Value = tbl2.valueComponent,
            ChevronIcon = if tbl2.onActivated then React.createElement(Icon, { name = Enums.IconName.ChevronSmallRight }) else nil
        })
    }
    tbl4.LabelValueContainer = createElement2(var3, tbl5, tbl6)

    tbl4.BottomDivider = if tbl2.isLastInSingleColumn or not bool1 then nil else React.createElement(Divider, { LayoutOrder = 3 })
    return createElement(var2, tbl3, tbl4)
end)
