-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local tbl1 = {}
local _GraphQL = require(scriptParentParent.GraphQL)

tbl1.MapperKind = {
    TYPE = "MapperKind.TYPE",
    SCALAR_TYPE = "MapperKind.SCALAR_TYPE",
    ENUM_TYPE = "MapperKind.ENUM_TYPE",
    COMPOSITE_TYPE = "MapperKind.COMPOSITE_TYPE",
    OBJECT_TYPE = "MapperKind.OBJECT_TYPE",
    INPUT_OBJECT_TYPE = "MapperKind.INPUT_OBJECT_TYPE",
    ABSTRACT_TYPE = "MapperKind.ABSTRACT_TYPE",
    UNION_TYPE = "MapperKind.UNION_TYPE",
    INTERFACE_TYPE = "MapperKind.INTERFACE_TYPE",
    ROOT_OBJECT = "MapperKind.ROOT_OBJECT",
    QUERY = "MapperKind.QUERY",
    MUTATION = "MapperKind.MUTATION",
    SUBSCRIPTION = "MapperKind.SUBSCRIPTION",
    DIRECTIVE = "MapperKind.DIRECTIVE",
    FIELD = "MapperKind.FIELD",
    COMPOSITE_FIELD = "MapperKind.COMPOSITE_FIELD",
    OBJECT_FIELD = "MapperKind.OBJECT_FIELD",
    ROOT_FIELD = "MapperKind.ROOT_FIELD",
    QUERY_ROOT_FIELD = "MapperKind.QUERY_ROOT_FIELD",
    MUTATION_ROOT_FIELD = "MapperKind.MUTATION_ROOT_FIELD",
    SUBSCRIPTION_ROOT_FIELD = "MapperKind.SUBSCRIPTION_ROOT_FIELD",
    INTERFACE_FIELD = "MapperKind.INTERFACE_FIELD",
    INPUT_OBJECT_FIELD = "MapperKind.INPUT_OBJECT_FIELD",
    ARGUMENT = "MapperKind.ARGUMENT",
    ENUM_VALUE = "MapperKind.ENUM_VALUE"
}

return tbl1
