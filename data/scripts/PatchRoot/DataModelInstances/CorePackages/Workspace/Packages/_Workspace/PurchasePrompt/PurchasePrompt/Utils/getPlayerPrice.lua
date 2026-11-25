-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _scriptParentParent = script.Parent.Parent

return function(tbl1, bool1: boolean, num1: number?)
    if num1 and num1 > 0 then
        return num1
    end

    if bool1 then
        if tbl1.premiumPrice == nil then
            return tbl1.price
        end

        return tbl1.premiumPrice
    end

    return tbl1.price
end
