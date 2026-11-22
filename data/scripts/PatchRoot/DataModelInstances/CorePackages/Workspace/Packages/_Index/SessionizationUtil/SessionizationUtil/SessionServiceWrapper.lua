-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionizationUtilParent = script:FindFirstAncestor("SessionizationUtil").Parent

local SessionService = game:GetService("SessionService")
local module = {
    SessionChangedSignal = require(SessionizationUtilParent.AppCommonLib).Signal.new()
}

function module.GetRootSID(_): string
    return SessionService:GetRootSID()
end

function module.SetSession(arg1, parentSid: string, str1: string, tag: string)
    local sessionTag = SessionService:GetSessionTag(str1)

    SessionService:SetSession(parentSid, str1, tag)

    local sessionTag2 = SessionService:GetSessionTag(str1)

    if sessionTag2 ~= sessionTag then
        arg1.SessionChangedSignal:fire(str1, sessionTag2)
    end
end

function module.ReplaceSession(arg1, sid: string, tag: string)
    local sessionTag = SessionService:GetSessionTag(sid)

    SessionService:ReplaceSession(sid, tag)

    local sessionTag2 = SessionService:GetSessionTag(sid)

    if sessionTag2 ~= sessionTag then
        arg1.SessionChangedSignal:fire(sid, sessionTag2)
    end
end

function module.RemoveSession(_, sid: string)
    SessionService:RemoveSession(sid)
end

function module.RemoveSessionsWithMetadataKey(_, key: string)
    SessionService:RemoveSessionsWithMetadataKey(key)
end

function module.GetMetadata(_, sid: string, key: string)
    return SessionService:GetMetadata(sid, key)
end

function module.SetMetadata(_, sid: string, key: string, arg1)
    SessionService:SetMetadata(sid, key, arg1)
end

function module.RemoveMetadata(_, sid: string, key: string)
    SessionService:RemoveMetadata(sid, key)
end

function module.SessionExists(_, sid: string): boolean
    return SessionService:SessionExists(sid)
end

function module.GetSessionTag(_, sid: string): string
    return SessionService:GetSessionTag(sid)
end

function module.generateSessionInfoString(_, includeArbitrarySessions: boolean, includeTag: boolean, includeTimestamps: boolean, includeMetadata: boolean): string
    return SessionService:GenerateSessionInfoString(includeArbitrarySessions, includeTag, includeTimestamps, includeMetadata)
end

return module
