-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:40:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local _typedDocumentNode = require(scriptParentParentParent.jsutils.typedDocumentNode)

local _types = require(scriptParentParentParent.react.types.types)

local useBaseQuery = require(script.Parent.utils.useBaseQuery).useBaseQuery
local _core = require(scriptParentParentParent.core)

local module = {}

function module.useLazyQuery(arg1, arg2)
    return useBaseQuery(arg1, arg2, true)
end
return module
