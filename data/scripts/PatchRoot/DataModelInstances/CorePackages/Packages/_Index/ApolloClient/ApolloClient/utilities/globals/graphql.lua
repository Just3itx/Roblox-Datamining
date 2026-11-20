-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local isType = require(scriptParentParentParentParent.GraphQL).isType

function module.removeTemporaryGlobals()
    isType(nil)

    local function remove() end

    return remove()
end

return module
