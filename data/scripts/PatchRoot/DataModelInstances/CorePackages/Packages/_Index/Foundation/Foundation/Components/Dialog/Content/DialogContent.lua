-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:50:38Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local ScrollView = require(Foundation.Components.ScrollView)
local _Types = require(Foundation.Components.Types)
local Visibility = require(Foundation.Enums.Visibility)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local useScrollBarPadding = require(script.Parent.useScrollBarPadding)
local useDialogVariants = require(script.Parent.Parent.useDialogVariants).useDialogVariants
local useDialog = require(script.Parent.Parent.useDialog)

local function DialogContent(arg1)
    local var1, var2, var3 = useScrollBarPadding()
    local var4 = useDialogVariants()
    arg1.testId = `{useDialog().testId}--content`

    local selectable = (arg1.Selectable == nil or arg1.Selectable) and var1

    local createElement = React.createElement
    local var6 = ScrollView
    local var7 = withCommonProps
    local tbl1 = {
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            scrollBarVisibility = if var1 then Visibility.Auto else Visibility.None
        },
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        selection = {
            Selectable = selectable,
            NextSelectionUp = arg1.NextSelectionUp,
            NextSelectionDown = arg1.NextSelectionDown,
            NextSelectionLeft = arg1.NextSelectionLeft,
            NextSelectionRight = arg1.NextSelectionRight
        },
        onAbsoluteCanvasSizeChanged = var3,
        onAbsoluteWindowSizeChanged = var3,
        tag = var4.content.tag
    }

    return createElement(var6, var7(arg1, tbl1), {
        ScrollPadding = React.createElement("UIPadding", {
            PaddingRight = var2:map(function(offset: number): UDim
                return UDim.new(0, offset)
            end)
        }),
        ScrollContent = React.createElement(React.Fragment, nil, arg1.children)
    })
end

return DialogContent
