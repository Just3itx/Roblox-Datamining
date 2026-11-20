-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Boolean = require(scriptParentParent.LuauPolyfill).Boolean

local module = {}
local Kind = require(scriptParentParent.GraphQL).Kind
function module.isDocumentNode(arg1)
    local var1 = Boolean.toJSBoolean(arg1)
    return var1 and typeof(arg1) == "table" and Boolean.toJSBoolean(arg1.kind) and arg1.kind == Kind.DOCUMENT
end

return module
