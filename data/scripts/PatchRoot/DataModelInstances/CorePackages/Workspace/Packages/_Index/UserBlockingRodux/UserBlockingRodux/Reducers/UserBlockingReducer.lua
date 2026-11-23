-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserBlockingRodux = script:FindFirstAncestor("UserBlockingRodux")

local isBlockedByMe = require(UserBlockingRodux.Reducers.UserBlocking.isBlockedByMe)

local tbl1 = {
    isBlockedByMe = {}
}

return function(arg1)
    local var1 = isBlockedByMe(arg1)

    return function(arg2, arg3)
        return {
            isBlockedByMe = var1((arg2 or tbl1).isBlockedByMe, arg3)
        }
    end
end
