-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return (setmetatable({ __NULL_IDENTIFIER__ = "__GRAPHQL_NULL_OBJECT__" }, {
    __newindex = function(_, arg1, _)
        local str1 = ("%q (%s) is not a valid member of %s"):format(tostring(arg1), typeof(arg1), "null")

        error(str1, 2)
    end,
    __metatable = false,
    __tostring = function(): string
        return "null"
    end
}))
