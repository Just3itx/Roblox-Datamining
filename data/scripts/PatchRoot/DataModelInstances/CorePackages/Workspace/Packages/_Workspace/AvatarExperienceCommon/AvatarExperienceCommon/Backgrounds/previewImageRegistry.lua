-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = ({})

return {
    register = function(str1: string, arg1)
        tbl1[str1] = arg1
    end,
    resolve = function(str1: string)
        return tbl1[str1]
    end,
    destroy = function(str1: string)
        local var1 = tbl1[str1]
        if var1 then
            tbl1[str1] = nil
            var1:Destroy()
        end
    end,
    clear = function()
        local tbl2 = tbl1
        tbl1 = {}
        for _, value in tbl2 do
            value:Destroy()
        end
    end
}
