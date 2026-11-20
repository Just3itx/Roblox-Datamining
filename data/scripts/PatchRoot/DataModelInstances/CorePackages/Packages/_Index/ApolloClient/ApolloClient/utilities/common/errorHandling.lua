-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Boolean = require(scriptParentParentParentParent.LuauPolyfill).Boolean

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

function module.graphQLResultHasError(arg1): boolean
    return not not (Boolean.toJSBoolean(arg1.errors) and #arg1.errors > 0)
end
return module
