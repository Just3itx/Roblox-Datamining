-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)

local RoactChatAnalyticsContext = require(script.Parent.RoactChatAnalyticsContext)

return function()
    return React.useContext(RoactChatAnalyticsContext)
end
