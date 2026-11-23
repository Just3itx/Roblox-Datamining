-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens

return (React.forwardRef(function(tbl1, ref)
    local var1 = useDesignTokens()
    return React.createElement("Frame", {
        ref = ref,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = var1.Color.Common.Scrim.Transparency,
        BackgroundColor3 = var1.Color.Common.Scrim.Color3,
        ClipsDescendants = false,
        Active = true
    }, tbl1.children)
end))
