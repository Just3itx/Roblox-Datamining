-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local AnalyticsConsumer = require(script.Parent.AnalyticsConsumer)

return function(render)
    assert(type(render) == "function", "Expect renderCallback to be a function.")
    return Roact.createElement(AnalyticsConsumer, { render = render })
end
