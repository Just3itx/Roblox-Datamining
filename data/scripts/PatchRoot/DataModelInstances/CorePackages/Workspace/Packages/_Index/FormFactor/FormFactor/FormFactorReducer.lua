-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FormFactor = require(script.Parent.FormFactor)
local SetFormFactor = require(script.Parent.SetFormFactor)

return function(arg1, arg2)
    arg1 = arg1 or FormFactor.UNKNOWN

    return if arg2.type == SetFormFactor.name then arg2.formFactor else arg1
end
