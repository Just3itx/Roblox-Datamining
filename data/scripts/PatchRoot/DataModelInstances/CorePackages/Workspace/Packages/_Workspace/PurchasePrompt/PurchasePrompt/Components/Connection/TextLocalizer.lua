-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local LocalizationContextConsumer = require(script.Parent.LocalizationContextConsumer)

local function TextLocalizer(arg1)
    local locKey = arg1.locKey
    local params = arg1.params
    local render = arg1.render

    assert(typeof(locKey) == "string", "String prop 'locKey' must be provided")
    assert(typeof(render) == "function", "Render prop must be a function")

    return Roact.createElement(LocalizationContextConsumer, {
        render = function(arg2)
            return render(arg2:Format(locKey, params))
        end
    })
end

return TextLocalizer
