-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionizationUtilParent = script:FindFirstAncestor("SessionizationUtil").Parent

local SessionService = game:GetService("SessionService")
local SessionType = require(SessionizationUtilParent.RobloxAppSessionization).SessionType

local module = {}
module.__index = module

function module.new(level, sessionId: string?, tagName: string?, creationTimestamp: number?, metadata)
    local self = setmetatable({}, module)

    self.level = level
    self.sessionId = sessionId
    self.tagName = tagName
    self.creationTimestamp = creationTimestamp
    self.metadata = metadata or {}

    return self
end

function module:__tostring()
    local metadataCount = 0
    for _ in pairs(self.metadata) do
        metadataCount += 1
    end

    return string.format(
        "SessionInfo{level=%s, sessionId=%s, tagName=%s, creationTimestamp=%s, metadata_count=%d}",
        tostring(self.level),
        tostring(self.sessionId),
        tostring(self.tagName),
        tostring(self.creationTimestamp),
        metadataCount
    )
end

function module.getSessionByLevel(level0)
    local var1 = SessionType.StructuralIdentifier[level0]
    local var2, sessionTag

    if level0 == SessionType.StructuralIdentifier.Level0 then
        var2 = SessionService:GetRootSID()
        sessionTag = nil
    elseif var1 and SessionService:SessionExists(var1) then
        var2 = SessionService:GetSessionID(var1)
        sessionTag = SessionService:GetSessionTag(var1)
    else
        var2 = nil
        sessionTag = nil
    end

    return module.new(level0, var2, sessionTag, nil, {})
end

return module
