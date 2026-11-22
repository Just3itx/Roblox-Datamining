-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local React = require(ServerTriggeredModalsParent.React)

local getModalSignalStore = require(script.Parent.getModalSignalStore)

return function()
    return React.useMemo(function()
        return getModalSignalStore(false)
    end, {})
end
