-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getLocalUserId = require(script.Parent.Parent.Utils.getLocalUserId)

local function getOtherParticipantUserId(participants)
    if participants == nil then
        return nil
    end
    local localUserId = getLocalUserId()
    local var1 = if localUserId == nil then nil else tostring(localUserId)

    for _, participant in participants do
        if tostring(participant) ~= var1 then
            return tostring(participant)
        end
    end
    return nil
end

local function getOsaParticipantUserId(arg1)
    local bool1 = arg1
        and arg1.type == "one_to_one"
        and (arg1.source == "friends"
            or arg1.osaAcknowledgementStatus == "acknowledged"
            or arg1.osaAcknowledgementStatus == "unacknowledged")

    if bool1 and arg1 then
        return (getOtherParticipantUserId(arg1.participants))
    end

    return nil
end

return getOsaParticipantUserId
