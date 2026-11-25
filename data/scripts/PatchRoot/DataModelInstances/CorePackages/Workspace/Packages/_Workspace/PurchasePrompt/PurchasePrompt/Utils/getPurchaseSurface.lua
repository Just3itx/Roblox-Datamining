-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local AppContext = require(PurchasePrompt.Utils.AppContext)
local ProductPurchaseSurface = require(PurchasePromptParent.PurchasePromptLite).Enums.ProductPurchaseSurface

local function getPurchaseSurface(arg1)
    if arg1 and arg1.surface then
        return arg1.surface
    end

    if AppContext.get() == AppContext.Enum.IN_EXPERIENCE then
        return ProductPurchaseSurface.InExperience
    end

    return ProductPurchaseSurface.Unknown
end

return getPurchaseSurface
