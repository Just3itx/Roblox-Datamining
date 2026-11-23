-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Cryo = require(AvatarExperienceCommonParent.Cryo)
local View = require(AvatarExperienceCommonParent.Foundation).View
local RoactGamepad = require(AvatarExperienceCommonParent.RoactGamepad)
local Focusable = RoactGamepad.Focusable
local _Dash = require(AvatarExperienceCommonParent.Dash)

local CheckboxButtonItem = require(script.Parent.CheckboxButtonItem)

local function CheckboxGroup(tbl1)
    local var1 = RoactGamepad.useRefCache()

    local var2, var3 = React.useBinding(0)
    local var4 = RoactGamepad.useRefCache()

    local var5 = React.useCallback(function()
        local num1 = 0
        for _, item in tbl1.items do
            num1 += var4[item.id].current or 0
        end
        var3(num1)
        if tbl1.onHeightChanged then
            tbl1.onHeightChanged(num1)
        end
    end, {
        tbl1.items,
        var4,
        var3,
        tbl1.onHeightChanged
    })
    local tbl2 = {
        layout = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 1) })
    }
    for layoutOrder, item in tbl1.items do
        local bool1 = if tbl1.selectedValue then table.find(tbl1.selectedValue, item.id) ~= nil else false
        local var6 = var1["defaultChild-" .. layoutOrder]

        local var7 = "checkboxItem" .. item.id

        tbl2[var7] = React.createElement(Focusable[CheckboxButtonItem], {
            id = item.id,
            text = item.text,
            onActivated = tbl1.onActivated,
            isSelected = bool1,
            isDisabled = item.isDisabled,
            layoutOrder = layoutOrder,
            itemHeight = tbl1.itemHeight,
            customView = item.customView,
            expandedView = item.expandedView,
            expandedViewHeight = item.expandedViewHeight,
            useDefaultControlState = tbl1.useDefaultControlState,
            hideDivider = tbl1.hideDividers or layoutOrder == #tbl1.items,
            ref = var1[layoutOrder],
            defaultChildRef = var6,
            defaultChild = var6,
            restorePreviousChildFocus = bool1,
            NextSelectionUp = if layoutOrder > 1 then var1[layoutOrder - 1] else nil,
            NextSelectionDown = if layoutOrder < #tbl1.items then var1[layoutOrder + 1] else nil,
            onHeightChanged = React.useCallback(function(current: number)
                var4[item.id].current = current
                var5()
            end, { item.id, var4, var5 })
        })
    end

    local restorePreviousChildFocus = tbl1.items and #tbl1.items > 0

    return React.createElement(restorePreviousChildFocus and Focusable[View] or View, {
        defaultChild = restorePreviousChildFocus and var1[1] or nil,
        Size = var2:map(function(yOffset: number?): UDim2
            return UDim2.new(1, 0, 0, yOffset)
        end),
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        NextSelectionLeft = tbl1.NextSelectionLeft,
        NextSelectionRight = tbl1.NextSelectionRight,
        NextSelectionDown = tbl1.NextSelectionDown,
        NextSelectionUp = tbl1.NextSelectionUp,
        restorePreviousChildFocus = restorePreviousChildFocus or nil,
        ref = tbl1.frameRef
    }, tbl2)
end

return React.forwardRef(function(arg1, frameRef)
    return React.createElement(CheckboxGroup, Cryo.Dictionary.join(arg1, { frameRef = frameRef }))
end)
