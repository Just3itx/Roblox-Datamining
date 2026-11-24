-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local UserConnector = require(script.Parent.Parent.connectors.UserConnector)
local findUserById = UserConnector.findUserById
local findMe = UserConnector.findMe
tbl1.default = {
    User = {
        __resolveType = function(): string
            return "Player"
        end
    },
    Query = {
        me = function(_, _, arg1)
            return findMe(arg1.fetchImpl)
        end,
        user = function(_, arg1, arg2)
            local id = arg1.id
            return findUserById(id, arg2.fetchImpl)
        end
    }
}

return tbl1
