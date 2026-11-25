-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local LayoutValues = require(PurchasePrompt.Services.LayoutValues)

local LayoutValuesContext = require(script.Parent.LayoutValuesContext)

return function(arg1)
    local layoutValues = LayoutValues.new(arg1.isTenFootInterface)
    return Roact.createElement(LayoutValuesContext.Provider, { value = layoutValues.layout }, Roact.oneChild(arg1[Roact.Children]))
end
