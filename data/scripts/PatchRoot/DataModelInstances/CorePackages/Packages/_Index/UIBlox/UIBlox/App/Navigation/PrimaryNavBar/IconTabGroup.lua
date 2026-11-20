-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Cryo = require(scriptParentParentParentParentParent.Cryo)

local React = require(scriptParentParentParentParentParent.React)
local Object = require(scriptParentParentParentParentParent.LuauPolyfill).Object

local InteractableList = require(scriptParentParentParentParent.Core.Control.InteractableList)
local SelectionMode = require(scriptParentParentParentParent.Core.Control.Enum.SelectionMode)
local useCursor = require(scriptParentParentParentParent.App.SelectionCursor.useCursor)

local IconTab = require(script.Parent.IconTab)
local HorizontalContainer = require(script.Parent.HorizontalContainer)

local _Types = require(script.Parent.Types)

local Constants = require(script.Parent.Constants)

local tbl1 = {
    selection = { 1 },
    items = {},
    padding = {
        left = Constants.ICON_TAB_PADDING,
        right = Constants.ICON_TAB_PADDING
    },
    itemSpacing = UDim.new(0, Constants.ICON_TAB_ITEM_SPACING),
    itemPadding = {
        left = Constants.ICON_TAB_ITEM_PADDING_LEFT,
        right = Constants.ICON_TAB_ITEM_PADDING_RIGHT
    }
}

local function IconTabGroup(arg1)
    local var1 = Object.assign({}, tbl1, arg1)
    local selectionImageObject = useCursor(UDim.new(0.5, 0), 0)
    return HorizontalContainer({
        size = UDim2.new(0, 0, 0, Constants.ICON_TAB_GROUP_HEIGHT),
        showRoundedBackground = false,
        automaticSize = Enum.AutomaticSize.X,
        padding = var1.padding
    }, {
        MainTabList = React.createElement(InteractableList, {
            size = UDim2.new(0, 0, 1, 0),
            automaticSize = Enum.AutomaticSize.X,
            fillDirection = Enum.FillDirection.Horizontal,
            horizontalAlignment = Enum.HorizontalAlignment.Left,
            sortOrder = Enum.SortOrder.LayoutOrder,
            itemList = var1.items,
            itemSize = UDim2.fromScale(0, 0),
            renderItem = function(arg2, controlState, selected: boolean)
                local tbl2 = {
                    LayoutOrder = Cryo.List.find(var1.items, arg2),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    SelectionImageObject = selectionImageObject
                }
                return React.createElement(
                    IconTab,
                    {
                        item = arg2,
                        selected = selected,
                        controlState = controlState,
                        padding = var1.itemPadding
                    }
                ), tbl2
            end,
            onSelectionChanged = function(arg2)
                local item = var1.items[arg2[1]]
                if item ~= nil and item.onActivated ~= nil then
                    item.onActivated()
                end
            end,
            selection = var1.selection,
            selectionMode = SelectionMode.Single,
            padding = var1.itemSpacing
        })
    })
end

return IconTabGroup
