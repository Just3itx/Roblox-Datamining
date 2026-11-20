-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local inspect = require(scriptParentParentParent.LuauPolyfill).util.inspect
local arrayContains = require(scriptParentParent.luaUtils.arrayContains)

local function toArrayContains(arg1, arg2, arg3)
    local pass = arrayContains(arg1, arg2, arg3)

    return {
        pass = pass,
        message = if pass then "" else "received tbl: " .. inspect(arg2) .. " expected item to be in table: " .. inspect(arg1)
    }
end

return toArrayContains
