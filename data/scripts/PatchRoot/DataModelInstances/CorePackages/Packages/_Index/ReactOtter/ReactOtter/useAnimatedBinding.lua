-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local _Otter = require(scriptParentParent.Otter)

local useMotor = require(script.Parent.useMotor)

local function useAnimatedBinding(arg1, arg2)
    local var1, var2 = React.useBinding(arg1)
    return var1, (useMotor(arg1, var2, arg2))
end

return useAnimatedBinding
