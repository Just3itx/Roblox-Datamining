-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local DataHydration = require(GameInviteParent.DataHydration)

local isInThisServer = require(script.Parent.isInThisServer)

local InGame = DataHydration.Presence.PresenceEnums.PresenceType.InGame

local function isInThisUniverse(arg1, universeId: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (universeId == "" or universeId == "0") and arg1.universeId == universeId
end

local function isInAnotherServer(arg1, str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (str1 == "" or arg1.gameId == "") and not isInThisServer(arg1, str1)
end

local function isInOtherServerOfThisExperience(arg1, universeId: string, str1: string)
    return not (arg1 == nil or arg1.userPresenceType ~= InGame)
        and isInThisUniverse(arg1, universeId)
        and isInAnotherServer(arg1, str1)
end

return isInOtherServerOfThisExperience
