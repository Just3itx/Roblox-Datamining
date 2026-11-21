-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local createExpressionCooldownStore = require(script.Parent.createExpressionCooldownStore)
local expressionCooldownStore = require(script.Parent.expressionCooldownStore)

local tbl1 = ({})

return {
    getExpressionCooldownStore = function(str1: string?)
        if str1 == nil then
            return expressionCooldownStore
        end
        local var1 = tbl1[str1]
        if var1 == nil then
            var1 = createExpressionCooldownStore()
            tbl1[str1] = var1
        end
        return var1
    end,
    _resetForTesting = function()
        expressionCooldownStore._resetForTesting()
        table.clear(tbl1)
    end
}
