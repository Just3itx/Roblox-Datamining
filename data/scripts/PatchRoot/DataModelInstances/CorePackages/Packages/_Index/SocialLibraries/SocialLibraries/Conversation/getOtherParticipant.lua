-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    local localUserId = arg1.LocalUserId
    for _, value in ipairs(arg2) do
        if value ~= localUserId then
            return value
        end
    end
end
