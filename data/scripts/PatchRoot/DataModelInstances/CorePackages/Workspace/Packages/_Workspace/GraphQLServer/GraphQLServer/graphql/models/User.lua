-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local UserConnector = require(script.Parent.Parent.connectors.UserConnector)
local findUserById = UserConnector.findUserById
local findMe = UserConnector.findMe
tbl1.default = {
    findUserById = function(_, str1: string)
        return findUserById(str1)
    end,
    findMe = function(_)
        return findMe()
    end
}

return tbl1
