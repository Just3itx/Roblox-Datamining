-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)

local RoactChatAnalyticsConsumer = require(script.Parent.RoactChatAnalyticsConsumer)

return function(render)
    assert(type(render) == "function", "Expect renderCallback to be a function.")
    return Roact.createElement(RoactChatAnalyticsConsumer, { render = render })
end
