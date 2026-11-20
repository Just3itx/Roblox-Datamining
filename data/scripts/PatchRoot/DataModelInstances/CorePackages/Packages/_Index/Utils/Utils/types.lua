-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local tbl1 = {}
local _visit = require(scriptParentParent.GraphQL).visit

tbl1.DirectiveLocation = {
    QUERY = "QUERY",
    MUTATION = "MUTATION",
    SUBSCRIPTION = "SUBSCRIPTION",
    FIELD = "FIELD",
    FRAGMENT_DEFINITION = "FRAGMENT_DEFINITION",
    FRAGMENT_SPREAD = "FRAGMENT_SPREAD",
    INLINE_FRAGMENT = "INLINE_FRAGMENT",
    VARIABLE_DEFINITION = "VARIABLE_DEFINITION",
    SCHEMA = "SCHEMA",
    SCALAR = "SCALAR",
    OBJECT = "OBJECT",
    FIELD_DEFINITION = "FIELD_DEFINITION",
    ARGUMENT_DEFINITION = "ARGUMENT_DEFINITION",
    INTERFACE = "INTERFACE",
    UNION = "UNION",
    ENUM = "ENUM",
    ENUM_VALUE = "ENUM_VALUE",
    INPUT_OBJECT = "INPUT_OBJECT",
    INPUT_FIELD_DEFINITION = "INPUT_FIELD_DEFINITION"
}

return tbl1
