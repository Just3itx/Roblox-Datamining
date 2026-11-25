-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local getBodyContentHeight, setBodyContentHeight = require(scriptParentParentParent.Signals).createSignal(0)

return {
    getBodyContentHeight = getBodyContentHeight,
    setBodyContentHeight = setBodyContentHeight,
    reset = function()
        setBodyContentHeight(0)
    end
}
