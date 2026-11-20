-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local Roact = require(scriptParentParentParent.Parent.Roact)
local StyleConsumer = require(scriptParent.StyleConsumer)

return function(arg1)
    assert(type(arg1) == "function", "Expect renderCallback to be a function.")
    return Roact.createElement(StyleConsumer, {
        render = function(arg2)
            return arg1(arg2.derivedValues.textSizeOffset)
        end
    })
end
