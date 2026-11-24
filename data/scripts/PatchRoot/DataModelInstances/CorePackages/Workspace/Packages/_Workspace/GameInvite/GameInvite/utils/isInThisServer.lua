-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local _DataHydration = require(GameInviteParent.DataHydration)

local function isInThisServer(arg1, gameId: string): boolean
    return not (arg1 == nil or gameId == "") and arg1.gameId == gameId
end

return isInThisServer
