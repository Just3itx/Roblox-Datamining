-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local findAvatarHeadshotById = require(script.Parent.Parent.connectors.PlayerConnector).findAvatarHeadshotById
local _generatedTypes = require(script.Parent.Parent.generatedTypes)

tbl1.default = {
    Player = {
        avatarHeadshot = function(arg1, _, arg2, _)
            local fetchImpl = arg2.fetchImpl
            return findAvatarHeadshotById(arg1.id, fetchImpl)
        end
    }
}

return tbl1
