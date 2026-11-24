-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local function computeChannelId(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    if not arg1 then
        return ""
    end
    if game:GetEngineFeature("VoiceChatServiceExposesChannelId") and arg1.service then
        return tostring(arg1.service:GetChannelId())
    end

    if not arg1.service then
        return ""
    end

    return tostring(arg1.service:GetGroupId())
end

local function buildState(arg1)
    local sortedPlayerListUserIds = {}
    if arg1 and arg1.participants then
        for k in pairs(arg1.participants) do
            local var1 = tonumber(k)
            if var1 then
                table.insert(sortedPlayerListUserIds, var1)
            end
        end
        table.sort(sortedPlayerListUserIds)
    end

    return {
        sortedPlayerListUserIds = sortedPlayerListUserIds,
        channelId = computeChannelId(arg1),
        voiceUserCount = #sortedPlayerListUserIds
    }
end

return {
    useVoiceSnapshot = function(arg1)
        local var1 = React.useRef((buildState(arg1)))

        React.useEffect(function()
            if not arg1 then
                return
            end

            var1.current = buildState(arg1)

            local connection = arg1.participantsUpdate.Event:Connect(function()
                var1.current = buildState(arg1)
            end)

            return function()
                connection:Disconnect()
            end
        end, { arg1 })

        return var1
    end
}
