-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local CapturesContext = require(scriptParentParent.Context.CapturesContext)

return function()
    return {
        fireEvent = React.useContext(CapturesContext).fireAnalyticsEvent
    }
end
