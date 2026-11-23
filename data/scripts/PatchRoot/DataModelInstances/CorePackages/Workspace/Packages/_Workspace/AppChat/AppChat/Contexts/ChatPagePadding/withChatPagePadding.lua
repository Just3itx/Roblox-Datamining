-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local Context = require(script.Parent.Context)

return function(render: (...any) -> (...any))
    assert(type(render) == "function", "Expect renderCallback to be a function.")
    return Roact.createElement(Context.Consumer, { render = render })
end
