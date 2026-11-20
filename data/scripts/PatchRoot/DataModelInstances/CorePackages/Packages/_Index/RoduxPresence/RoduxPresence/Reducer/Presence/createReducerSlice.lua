-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxPresence = script:FindFirstAncestor("RoduxPresence")
local RoduxPresenceParent = RoduxPresence.Parent
local Cryo = require(RoduxPresenceParent.Cryo)

local getDeepValue = require(RoduxPresence.getDeepValue)

local Actions = RoduxPresence.Actions
local ReceivedUserPresence = require(Actions.ReceivedUserPresence)

return function(arg1, arg2, arg3)
    local presenceNetworking = arg3.presenceNetworking

    local function handlePresenceModel(arg4, arg5)
        local var1 = arg4[arg1]
        local str1 = tostring(arg5.userId)

        local deepValue = getDeepValue(arg4, string.format("byUserId.%s.%s", str1, arg2))
        if deepValue and var1[deepValue] then
            local str2 = tostring(deepValue)
            var1 = Cryo.Dictionary.join(var1, { [str2] = Cryo.List.removeValue(var1[str2], str1) })
        end

        local var2 = var1[arg5[arg2]]
        if var2 and table.find(var2, str1) then
            return var1
        end

        local join = Cryo.Dictionary.join
        local tbl1 = {}
        local var3 = arg5[arg2]
        tbl1[tostring(var3)] = Cryo.List.join(var2 or {}, { str1 })
        return join(var1, tbl1)
    end

    return function(arg4, arg5)
        assert(arg4, "state should not be nil")

        if arg5.type == ReceivedUserPresence.name then
            return handlePresenceModel(arg4, arg5.payload)
        end

        if arg5.type ~= presenceNetworking.GetPresencesFromUserIds.Succeeded.name then
            return arg4[arg1]
        end

        local userPresences = arg5.responseBody.userPresences

        local var1 = arg4[arg1]
        for _, value in ipairs(userPresences) do
            var1 = handlePresenceModel(arg4, value)
        end

        return var1
    end
end
