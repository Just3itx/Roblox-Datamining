-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function getRootNavigation(arg1)
    local var1 = arg1._dangerouslyGetParent()
    if var1 then
        return (getRootNavigation(var1))
    end

    return arg1
end

return getRootNavigation
