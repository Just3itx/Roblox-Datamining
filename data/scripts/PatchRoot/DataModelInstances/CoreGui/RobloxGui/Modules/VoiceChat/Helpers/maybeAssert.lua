-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GlobalConfig = require(script.Parent.Parent.GlobalConfig)

local function maybeAssert(...)
    if GlobalConfig.actionValidation then
        return assert(...)
    end
end

return maybeAssert
