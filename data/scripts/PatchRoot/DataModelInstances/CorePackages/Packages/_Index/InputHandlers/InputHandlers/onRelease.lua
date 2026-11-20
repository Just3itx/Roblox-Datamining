-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:39:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _FocusNavigation = require(scriptParentParent.FocusNavigation)

local handleInput = require(script.Parent.handleInput)

local function onRelease(onRelease2)
    return handleInput({ onRelease = onRelease2 })
end

return onRelease
