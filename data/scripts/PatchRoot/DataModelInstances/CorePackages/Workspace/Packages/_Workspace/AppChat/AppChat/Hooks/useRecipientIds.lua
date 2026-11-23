-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector

return function(arg1)
    local var1 = useSelector(function(arg2): number?
        return tonumber(arg2.LocalUserId)
    end)

    local result = {}

    for _, value in arg1 and arg1.participants or {} do
        local var2 = tonumber(value)
        if var2 and var2 ~= var1 then
            table.insert(result, var2)
        end
    end

    return result
end
