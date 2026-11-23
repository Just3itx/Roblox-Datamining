-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local useCursor = require(BulkPurchaseAppParent.UIBlox).App.SelectionCursor.useCursor

local function FullPagePromptScrollList(tbl1)
    local var1 = useDesignTokens()
    local selectionImageObject = useCursor(UDim.new(0, var1.Radius.Small), var1.Size.Size_200)
    local size350 = var1.Size.Size_350
    local selectable, var4 = React.useBinding(false)

    local createElement = React.createElement

    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Size = tbl1.size,
        ScrollBarThickness = var1.Size.Size_100,
        ScrollBarImageColor3 = var1.Color.Shift.Shift_400.Color3,
        ScrollBarImageTransparency = var1.Color.Shift.Shift_400.Transparency,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(1, -size350, 0, 0),
        SelectionImageObject = selectionImageObject,
        Selectable = selectable
    }

    tbl2[React.Change.AbsoluteCanvasSize] = function(arg1)
        var4(arg1.AbsoluteCanvasSize.Y > arg1.AbsoluteWindowSize.Y)
    end

    return createElement(
        "ScrollingFrame",
        tbl2,
        React.createElement("UIPadding", { PaddingRight = UDim.new(0, size350) }),
        React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, var1.Size.Size_600)
        }),
        tbl1.children
    )
end
return FullPagePromptScrollList
