-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Number = require(script.Parent.Parent.Parent.LuauPolyfill).Number

local function toBeNaN(arg1)
    local pass = Number.isNaN(arg1)

    if pass then
        return { pass = pass }
    end

    return {
        pass = false,
        message = ("expected: NaN (number), got: \"%s\" (%s) instead"):format(tostring(arg1), typeof(arg1))
    }
end

return toBeNaN
