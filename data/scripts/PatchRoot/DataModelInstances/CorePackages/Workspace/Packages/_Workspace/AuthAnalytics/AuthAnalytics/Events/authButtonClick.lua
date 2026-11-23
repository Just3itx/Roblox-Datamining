-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)

return function(str1: string, btn: string, state: string?, url: string?, isAltAttempt: boolean?, origin: string?, ctype: string?, associatedText: string?)
    local tbl1 = {}

    if btn then
        tbl1.btn = btn
    end

    if state then
        tbl1.state = state
    end

    if url then
        tbl1.url = url
    end
    if isAltAttempt ~= nil then
        tbl1.is_alt_attempt = isAltAttempt
    end

    if origin then
        tbl1.origin = origin
    end

    if ctype then
        tbl1.ctype = ctype
    end

    if associatedText then
        tbl1.associatedText = associatedText
    end

    checkAndSendEvent(str1, "authButtonClick", tbl1)
end
