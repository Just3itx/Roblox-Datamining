-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local PresenceTypes = require(scriptParentParentParent.Analytics.Enums).PresenceTypes
local PresenceType = dependencies.RoduxPresence.Enums.PresenceType

local tbl1 = {
    [PresenceType.InGame] = PresenceTypes.InGame,
    [PresenceType.InStudio] = PresenceTypes.InStudio,
    [PresenceType.Offline] = PresenceTypes.Offline,
    [PresenceType.Online] = PresenceTypes.Online
}

return function(arg1)
    if arg1 then
        if type(arg1) == "string" and arg1 ~= "" then
            return PresenceTypes[arg1]
        end

        return tbl1[arg1]
    end

    return nil
end
