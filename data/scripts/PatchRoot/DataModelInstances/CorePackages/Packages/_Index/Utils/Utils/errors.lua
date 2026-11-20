-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local GraphQLError = GraphQL.GraphQLError

local versionInfo = GraphQL.versionInfo

local _types = require(script.Parent.types)

local function createGraphQLError(str1: string, tbl1)
    if versionInfo.major >= 17 then
        return GraphQLError.new(str1, tbl1)
    end
    return GraphQLError.new(
        str1,
        if typeof(tbl1) == "table" then tbl1.nodes else nil,
        if typeof(tbl1) == "table" then tbl1.source else nil,
        if typeof(tbl1) == "table" then tbl1.positions else nil,
        if typeof(tbl1) == "table" then tbl1.path else nil,
        if typeof(tbl1) == "table" then tbl1.originalError else nil,
        if typeof(tbl1) == "table" then tbl1.extensions else nil
    )
end

module.createGraphQLError = createGraphQLError
function module.relocatedError(originalError, path)
    local func1 = createGraphQLError
    local message = originalError.message
    local tbl1 = {
        nodes = originalError.nodes,
        source = originalError.source,
        positions = originalError.positions,
        path = 0,
        originalError = 0,
        extensions = 0
    }

    if path == nil then
        path = originalError.path
    end

    tbl1.path = path

    tbl1.originalError = originalError
    tbl1.extensions = originalError.extensions
    return func1(message, tbl1)
end

return module
