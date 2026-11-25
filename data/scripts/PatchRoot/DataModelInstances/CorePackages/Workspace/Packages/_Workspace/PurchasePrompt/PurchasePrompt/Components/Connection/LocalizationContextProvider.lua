-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local LocalizationContext = require(script.Parent.LocalizationContext)

return function(arg1)
    return Roact.createElement(
        LocalizationContext.Provider,
        {
            value = arg1.localizationContext
        },
        Roact.oneChild(arg1[Roact.Children])
    )
end
