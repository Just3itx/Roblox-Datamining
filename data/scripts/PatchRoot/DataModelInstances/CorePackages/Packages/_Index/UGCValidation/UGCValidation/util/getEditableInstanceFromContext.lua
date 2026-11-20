-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

return function(arg1, str1: string, arg2, arg3)
    if not arg2 then
        if not arg3.isServer then
            return false
        end

        error(string.format("Failed to load texture data"))
    end

    local var1 = arg2[arg1]
    if not var1 then
        local var2 = arg1[str1]
        if not var2 or var2 == "" then
            return false
        end

        if arg3.isServer then
            error(string.format("Failed to load texture data"))
        end
    end

    local var2 = var1[str1]
    if not (var2 and var2.instance) then
        local var3 = arg1[str1]
        if not var3 or var3 == "" then
            return false
        end

        if not arg3.isServer then
            return false
        end

        error(string.format("Failed to load texture data"))
    end

    return true, var2.instance
end
