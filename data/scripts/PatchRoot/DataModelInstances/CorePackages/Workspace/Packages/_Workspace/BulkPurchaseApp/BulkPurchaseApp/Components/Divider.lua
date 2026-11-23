-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens

local function Divider(tbl1)
    local var1 = useDesignTokens()

    return React.createElement("Frame", {
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = var1.Color.Stroke.Emphasis.Color3,
        BackgroundTransparency = var1.Color.Stroke.Emphasis.Transparency,
        LayoutOrder = tbl1.LayoutOrder,
        [React.Tag] = "data-testid=BulkPurchaseApp_Divider"
    })
end

return Divider
