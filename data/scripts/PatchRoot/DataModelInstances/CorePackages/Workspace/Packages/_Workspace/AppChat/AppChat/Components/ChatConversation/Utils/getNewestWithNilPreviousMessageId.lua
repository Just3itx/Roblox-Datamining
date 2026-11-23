-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local getDeepValue = require(AppChat.Utils.getDeepValue)

return function(arg1)
    local deepValue = getDeepValue(arg1, "keys")
    local deepValue2 = getDeepValue(arg1, "values")
    local var1 = nil

    for _, value in pairs(deepValue) do
        if deepValue2[value] and deepValue2[value].previousMessageId == nil then
            return value
        end
    end

    return var1
end
