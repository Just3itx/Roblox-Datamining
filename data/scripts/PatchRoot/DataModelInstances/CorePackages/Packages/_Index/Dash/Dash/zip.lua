-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:01:14Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function zip(tbl1, tbl2)
    local var1 = nil
    local var2 = nil
    local var3 = nil
    local var4 = nil
    return function()
        var1, var3 = next(tbl1, var1)
        var2, var4 = next(tbl2, var2)
        if not (var3 and var4) then
            return nil
        end
        return var3, var4
    end
end

return zip
