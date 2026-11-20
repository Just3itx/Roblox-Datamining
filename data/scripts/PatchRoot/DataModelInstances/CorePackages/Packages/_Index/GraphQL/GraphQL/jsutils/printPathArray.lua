-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

return {
    printPathArray = function(arg1): string
        local tbl1 = ({})
        for i = 1, #arg1 do
            local var1 = arg1[i]
            tbl1[i] = typeof(var1) == "number" and "[" .. tostring(var1) .. "]" or "." .. var1
        end
        return table.concat(tbl1, "")
    end
}
