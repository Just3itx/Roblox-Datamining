-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local LayoutValuesContext = require(script.Parent.LayoutValuesContext)

return function(render)
    assert(type(render) == "function", "Expect withLayoutValues callback to be a function.")
    return Roact.createElement(LayoutValuesContext.Consumer, { render = render })
end
