-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Types)
local builders = require(script.Parent.builders)

local function createMomentScene(arg1, arg2)
    local var1 = (arg2 or builders)[arg1.type]
    if var1 == nil then
        error(`createMomentScene: unknown scene type '{arg1.type}'`)
    end
    return var1(arg1.args)
end

return createMomentScene
