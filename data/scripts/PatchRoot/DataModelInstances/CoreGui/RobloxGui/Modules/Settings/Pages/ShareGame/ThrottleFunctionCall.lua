-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    local bool1 = false
    return function(...)
        if bool1 then
            return
        end

        bool1 = true
        task.delay(arg1, function()
            bool1 = false
        end)
        return arg2(...)
    end
end
