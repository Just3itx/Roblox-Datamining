-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)

return function(str1: string, field: string?, state: string?, origin: string?, arg1, associatedText: string?)
    local tbl1 = {}

    if field then
        tbl1.field = field
    end

    if state then
        tbl1.state = state
    end

    if origin then
        tbl1.origin = origin
    end

    if arg1 ~= nil then
        tbl1.entered = tostring(arg1)
    end

    if associatedText then
        tbl1.associatedText = associatedText
    end

    checkAndSendEvent(str1, "authFormInteraction", tbl1)
end
