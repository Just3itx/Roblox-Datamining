-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local Roact = require(scriptParentParentParent.Parent.Roact)
local StyleConsumer = require(scriptParent.StyleConsumer)
local _StyleTypes = require(scriptParentParentParent.App.Style.StyleTypes)

return function(func1: (...any) -> (...any))
    assert(type(func1) == "function", "Expect renderCallback to be a function.")
    return Roact.createElement(StyleConsumer, {
        render = function(arg1)
            return func1(arg1.style)
        end
    })
end
