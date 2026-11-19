-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:32Z
-- Luau bytecode version: 9 | Luau type version: 3
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
