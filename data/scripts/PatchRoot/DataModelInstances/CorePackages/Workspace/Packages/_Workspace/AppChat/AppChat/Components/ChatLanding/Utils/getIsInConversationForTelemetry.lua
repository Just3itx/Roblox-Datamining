-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local EnumScreens = require(AppChat.EnumScreens)
local getCurrentRoute = require(script.Parent.getCurrentRoute)

local function getIsInConversationForTelemetry(arg1): boolean
    local previousValue

    repeat
        previousValue = arg1
        local var1 = arg1 and arg1._dangerouslyGetParent and arg1._dangerouslyGetParent()
        arg1 = var1
    until not var1

    local currentRoute = if previousValue then getCurrentRoute(previousValue.state) else nil
    return not (currentRoute == nil) and currentRoute.routeName == EnumScreens.ChatConversation
end

return getIsInConversationForTelemetry
