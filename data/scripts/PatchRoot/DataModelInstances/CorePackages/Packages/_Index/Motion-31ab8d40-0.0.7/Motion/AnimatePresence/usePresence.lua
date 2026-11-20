-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local PresenceContext = require(script.Parent.PresenceContext)
local isPresent = require(script.Parent.PresenceUtils).isPresent

local function usePresence()
    local var1 = React.useContext(PresenceContext)

    local id = var1.id
    local _isPresent = var1.isPresent
    local onExitComplete = var1.onExitComplete
    local passThroughData = var1.passThroughData

    local var2 = React.useCallback(function()
        if onExitComplete then
            onExitComplete(id)
        end
    end, { onExitComplete, id })

    return {
        isPresent = isPresent(var1),
        id = id,
        onExitComplete = var2,
        passThroughData = passThroughData
    }
end

return usePresence
