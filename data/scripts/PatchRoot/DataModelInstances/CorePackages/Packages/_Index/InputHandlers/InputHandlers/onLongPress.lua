-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:39:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _FocusNavigation = require(scriptParentParent.FocusNavigation)

local handleInput = require(script.Parent.handleInput)

local function onLongPress(durationSeconds: number, onComplete, onStep)
    return handleInput({ hold = { durationSeconds = durationSeconds, onComplete = onComplete, onStep = onStep } })
end

return onLongPress
