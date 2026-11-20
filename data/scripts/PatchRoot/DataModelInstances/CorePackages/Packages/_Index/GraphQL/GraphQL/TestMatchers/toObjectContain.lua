-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local inspect = require(scriptParentParentParent.LuauPolyfill).util.inspect
local deepContains = require(script.Parent.Parent.luaUtils.deepContains)

local function toObjectContain(arg1, arg2)
    local pass = deepContains(arg1, arg2)

    return {
        pass = pass,
        message = if pass then "" else "received tbl: " .. inspect(arg2) .. " expected item to be in table: " .. inspect(arg1)
    }
end

return toObjectContain
