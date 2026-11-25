-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local Roact = PurchasePromptDeps.Roact
local t = PurchasePromptDeps.t

local LocalizationContextConsumer = require(script.Parent.LocalizationContextConsumer)

local var1 = t.strictInterface({ locKeys = t.table, render = t.callback })

local var2 = t.strictInterface({ key = t.string, params = t.optional(t.table) })

local function MultiTextLocalizer(arg1)
    assert(var1(arg1))
    for _, locKey in pairs(arg1.locKeys) do
        assert(var2(locKey))
    end

    local render = arg1.render

    return Roact.createElement(LocalizationContextConsumer, {
        render = function(arg2)
            local tbl1 = ({})
            for k, locKey in pairs(arg1.locKeys) do
                tbl1[k] = arg2:Format(locKey.key, locKey.params)
            end
            return render(tbl1)
        end
    })
end

return MultiTextLocalizer
