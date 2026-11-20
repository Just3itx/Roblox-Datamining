-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    config = function(tbl1)
        local tbl2 = tbl1 or {}

        local state = tbl2.state or {}
        return {
            dispatch = tbl2.dispatch or function(arg1, arg2)
                if type(arg2) == "function" then
                    arg2(arg1)
                end
            end,
            getState = function()
                return state
            end,
            setState = function(_, arg1)
                state = arg1
            end
        }
    end
}
