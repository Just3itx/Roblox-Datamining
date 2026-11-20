-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local String = require(scriptParentParentParent.LuauPolyfill).String

local _source = require(script.Parent.source)

return {
    getLocation = function(arg1, column: number)
        local tbl1 = { "\r\n", "\r", "\n" }

        local var1 = String.findOr(arg1.body, tbl1)
        local num2 = column
        local num3 = 1

        while var1 ~= nil and var1.index < num2 do
            local var2 = var1.index + string.len(var1.match)
            num3 += 1
            column = num2 + 1 - var2
            var1 = String.findOr(arg1.body, tbl1, var2)
        end

        return { line = num3, column = column }
    end
}
