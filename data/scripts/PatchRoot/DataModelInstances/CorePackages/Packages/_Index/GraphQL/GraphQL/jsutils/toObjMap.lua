-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ObjMap = require(script.Parent.ObjMap)

return {
    toObjMap = function(arg1)
        local result = ({})

        for k, value in pairs(arg1) do
            result[k] = value
        end

        return result
    end
}
