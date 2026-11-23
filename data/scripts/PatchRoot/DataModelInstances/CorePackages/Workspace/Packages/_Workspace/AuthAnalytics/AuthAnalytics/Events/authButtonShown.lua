-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)

return function(str1: string, btn: string, state: string?, origin: string?)
    local tbl1 = { btn = btn }

    if state then
        tbl1.state = state
    end
    if origin then
        tbl1.origin = origin
    end

    checkAndSendEvent(str1, "authButtonShown", tbl1)
end
