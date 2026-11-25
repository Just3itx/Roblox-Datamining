-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent
local FFlagLuaAppAddTestIdsForArrow = require(RoactUtilsParent.SharedFlags).FFlagLuaAppAddTestIdsForArrow

return {
    getTestId = function(str1: string?, arg1)
        if not FFlagLuaAppAddTestIdsForArrow then
            return nil
        end

        if not str1 then
            return nil
        end

        local str2 = `data-testid=--{str1}`
        if arg1 then
            str2 = `{str2}-{tostring(arg1)}`
        end

        return str2
    end
}
