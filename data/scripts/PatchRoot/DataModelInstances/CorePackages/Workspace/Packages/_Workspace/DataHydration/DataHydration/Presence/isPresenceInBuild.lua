-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocationType = require(script.Parent.Enums.LocationType)
local PresenceType = require(script.Parent.Enums.PresenceType)
local _normalizePresenceRawData = require(script.Parent.normalizePresenceRawData)

return function(arg1): boolean
    return not (arg1 == nil or arg1.userPresenceType ~= PresenceType.Online) and arg1.locationType == LocationType.Build
end
