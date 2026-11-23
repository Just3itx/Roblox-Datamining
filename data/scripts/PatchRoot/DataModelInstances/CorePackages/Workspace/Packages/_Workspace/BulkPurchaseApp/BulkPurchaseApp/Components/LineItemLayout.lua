-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens

local function LineItemLayout(tbl1)
    local var1 = useDesignTokens()
    local var2, var3 = React.useBinding(Vector2.new(0, 0))

    local createElement = React.createElement
    local tbl2 = {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder
    }

    local tbl3 = {
        Start = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = var2:map(function(vector2: Vector2): UDim2
                return UDim2.new(1, -(vector2.X + var1.Size.Size_400), 1, 0)
            end)
        }, tbl1.startSlot),
        End = 0
    }

    local createElement2 = React.createElement
    local tbl4 = {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X
    }

    tbl4[React.Change.AbsoluteSize] = function(arg1)
        var3(arg1.AbsoluteSize)
    end

    tbl3.End = createElement2("Frame", tbl4, tbl1.endSlot)
    return createElement("Frame", tbl2, tbl3)
end

return LineItemLayout
