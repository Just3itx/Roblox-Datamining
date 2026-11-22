-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MusicPicker = script:FindFirstAncestor("MusicPicker")
local MusicPickerParent = MusicPicker.Parent

local Foundation = require(MusicPickerParent.Foundation)
local React = require(MusicPickerParent.React)

local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local View = Foundation.View
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local useTokens = Foundation.Hooks.useTokens

local _MusicPickerTypes = require(MusicPicker.Types.MusicPickerTypes)

local function TabPill(tbl1)
    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = tbl1.onActivated,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = {
            ["row align-x-center align-y-center auto-xy padding-x-medium padding-y-small radius-circle"] = true,
            ["bg-contrast"] = tbl1.isActive,
            ["bg-surface-300"] = not tbl1.isActive
        }
    }, {
        Label = React.createElement(FoundationText, {
            Text = tbl1.label,
            tag = {
                ["auto-xy text-title-medium"] = true,
                ["content-inverse-emphasis"] = tbl1.isActive,
                ["content-default"] = not tbl1.isActive
            }
        })
    })
end

local function MusicPickerTabStrip(tbl1)
    local var1 = useTokens()
    local tbl2 = ({})
    for layoutOrder, tab in tbl1.tabs do
        local id = tab.id
        local createElement = React.createElement
        local func1 = TabPill
        local tbl3 = {
            label = tab.label,
            isActive = tbl1.activeTabId == id,
            layoutOrder = layoutOrder,
            onActivated = 0
        }

        function tbl3.onActivated()
            tbl1.onTabSelected(id)
        end

        tbl2[id] = createElement(func1, tbl3)
    end

    return React.createElement(ScrollView, {
        LayoutOrder = tbl1.LayoutOrder,
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, var1.Gap.Small),
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        scroll = {
            AutomaticSize = Enum.AutomaticSize.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.X,
            CanvasSize = UDim2.fromOffset(0, 0),
            ScrollingDirection = Enum.ScrollingDirection.X,
            scrollBarVisibility = ScrollBarVisibility.None
        },
        tag = "size-full-0 auto-y padding-y-xsmall"
    }, tbl2)
end

return MusicPickerTabStrip
