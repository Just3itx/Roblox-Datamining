-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)

return function(str1: string, state: string, field: string, errorCode: string?, associatedText: string?)
    local tbl1 = {}

    if state then
        tbl1.state = state
    end

    if field then
        tbl1.field = field
    end

    if errorCode then
        tbl1.errorCode = errorCode
    end

    if associatedText then
        tbl1.associatedText = associatedText
    end

    checkAndSendEvent(str1, "authMsgShown", tbl1)
end
