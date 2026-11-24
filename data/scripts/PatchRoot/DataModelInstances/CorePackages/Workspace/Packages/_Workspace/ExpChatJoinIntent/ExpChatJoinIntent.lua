-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local JoinIntentStore = require(script.JoinIntentStore)
local FStringOpenChatOnJoinNotificationTypes = require(script.Flags.FStringOpenChatOnJoinNotificationTypes)

local var1 = nil
local function getDefaultStore() -- Luacid: Inlined by compiler; 3 call sites recovered
    local var2 = var1
    if var2 then
        return var2
    end
    local joinIntentStore = JoinIntentStore.new({ notificationTypes = FStringOpenChatOnJoinNotificationTypes })
    var1 = joinIntentStore
    return joinIntentStore
end

local module = {
    ["jest.config"] = script["jest.config"],
    FStringOpenChatOnJoinNotificationTypes = FStringOpenChatOnJoinNotificationTypes,
    JoinIntentStore = JoinIntentStore
}

function module.handleDeeplinkTap(arg1)
    getDefaultStore():handleDeeplinkTap(arg1)
end

function module.read(num1: number)
    return getDefaultStore():read(num1)
end

function module.getIntent()
    return getDefaultStore():getIntent()
end

return module
