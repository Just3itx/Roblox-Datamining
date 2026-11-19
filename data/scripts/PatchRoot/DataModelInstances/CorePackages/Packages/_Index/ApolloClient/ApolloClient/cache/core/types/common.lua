-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:11:19Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local tbl1 = {}

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Error = require(scriptParentParentParentParentParent.LuauPolyfill).Error

local _GraphQL = require(scriptParentParentParentParentParent.GraphQL)

local _types = require(scriptParentParentParentParent.utilities.graphql.types)

local MissingFieldError = setmetatable({}, { __index = Error })
MissingFieldError.__index = MissingFieldError

function MissingFieldError.new(message: string, path, query, variables)
    local error = Error.new(message)
    error.message = message
    error.path = path
    error.query = query
    error.variables = variables

    return (setmetatable(error, MissingFieldError))
end
tbl1.MissingFieldError = MissingFieldError

return tbl1
