-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Action = require(script.Parent.Parent.Action)

local _LuauHeapTypes = require(script.Parent.Parent.Components.LuauHeap.LuauHeapTypes)

return Action(script.Name, function(isClientState: boolean, sessionState)
    return { isClientState = isClientState, sessionState = sessionState }
end)
