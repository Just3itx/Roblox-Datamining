-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function normalizeParticipants(participants)
    if type(participants) ~= "table" then
        return participants
    end

    local result = ({})
    for k, participant in participants do
        local tbl1 = if type(participant) == "table" then participant else {
            id = tostring(participant)
        }
        result[k] = tbl1
    end

    return result
end

local function normalizeConversationForTelemetry(arg1)
    local var1 = table.clone(arg1)
    var1.participants = normalizeParticipants(arg1.participants)
    return var1
end

return normalizeConversationForTelemetry
