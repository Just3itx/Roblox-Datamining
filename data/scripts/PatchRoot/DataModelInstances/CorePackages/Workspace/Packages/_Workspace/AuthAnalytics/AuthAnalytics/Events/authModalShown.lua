-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Logging = require(scriptParentParentParent.AppCommonLib).Logging
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)

return function(str1: string, state: string?, field: string?, origin: string?, associatedText: string?, str2: string?)
    local tbl1 = {}

    if state then
        tbl1.state = state
    end
    if field then
        tbl1.field = field
    end
    if origin then
        tbl1.origin = origin
    end
    if associatedText then
        tbl1.associatedText = associatedText
    end
    if str2 ~= nil then
        if type(str2) ~= "string" then
            Logging.warn("Failure logging authModalShown: Expected errorCode to be a string but got " .. type(str2))
        end

        tbl1.errorCode = tostring(str2)
    end

    checkAndSendEvent(str1, "authModalShown", tbl1)
end
