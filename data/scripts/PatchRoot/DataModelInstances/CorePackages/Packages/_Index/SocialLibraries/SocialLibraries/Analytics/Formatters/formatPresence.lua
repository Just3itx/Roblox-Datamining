-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local PresenceTypes = require(scriptParentParentParent.Analytics.Enums).PresenceTypes
local PresenceType = dependencies.RoduxPresence.Enums.PresenceType

local tbl1 = {
    [PresenceType.InGame] = PresenceTypes.InGame.rawValue(),
    [PresenceType.InStudio] = PresenceTypes.InStudio.rawValue(),
    [PresenceType.Offline] = PresenceTypes.Offline.rawValue(),
    [PresenceType.Online] = PresenceTypes.Online.rawValue()
}

return function(arg1)
    return tbl1[arg1]
end
