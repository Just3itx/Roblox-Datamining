-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local NotificationCardContext = require(scriptParent.NotificationCardContext)
local _type = require(scriptParentParent.type)

local function useNotificationCardState(arg1)
    local var1 = React.useContext(NotificationCardContext)

    if arg1 then
        return var1.state and var1.state.visualItems and var1.state.visualItems[arg1] or {}
    end

    return var1.state
end

return useNotificationCardState
