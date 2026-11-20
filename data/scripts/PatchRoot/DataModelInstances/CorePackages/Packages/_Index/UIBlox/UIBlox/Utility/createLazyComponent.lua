-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Cryo = require(scriptParentParentParent.Cryo)
local React = require(scriptParentParentParent.React)

local function createLazyComponent(func1: (...any) -> (...any))
    return React.forwardRef(function(arg1, ref)
        return React.createElement(func1(), Cryo.Dictionary.join(arg1, { ref = ref }))
    end)
end

return createLazyComponent
