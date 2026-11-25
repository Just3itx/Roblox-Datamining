-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local React = require(scriptParentParentParent.React)
local NotificationCardContext = require(scriptParent.NotificationCardContext)

local function useNotificationCardData()
    return (React.useContext(NotificationCardContext))
end

return useNotificationCardData
