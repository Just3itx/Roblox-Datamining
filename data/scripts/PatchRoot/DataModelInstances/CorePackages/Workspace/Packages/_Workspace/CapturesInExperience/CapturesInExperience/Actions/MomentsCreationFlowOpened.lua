-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local _Types = require(scriptParentParent.Types)

return Rodux.makeActionCreator(script.Name, function(capture, sessionId: string)
    return { capture = capture, sessionId = sessionId }
end)
