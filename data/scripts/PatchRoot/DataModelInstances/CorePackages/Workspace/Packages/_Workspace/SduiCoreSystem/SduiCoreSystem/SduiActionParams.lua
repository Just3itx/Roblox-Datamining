-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    getStringParam = function(tbl1, str1: string, str2: string?): string?
        local var1 = tbl1[str1]
        return if typeof(var1) == "string" then var1 else str2
    end,
    getBooleanParam = function(tbl1, str1: string, bool1: boolean): boolean
        local var1 = tbl1[str1]
        return if typeof(var1) == "boolean" then var1 else bool1
    end,
    getCallbackParam = function(tbl1, str1: string, func1: ((...any) -> (...any))?)
        local var1 = tbl1[str1]
        return if typeof(var1) == "function" then function()
            var1()
        end else func1
    end
}
