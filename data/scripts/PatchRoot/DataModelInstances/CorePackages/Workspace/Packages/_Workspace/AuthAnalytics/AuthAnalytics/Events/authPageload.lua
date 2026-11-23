-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Logging = require(scriptParentParentParent.AppCommonLib).Logging
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)

return function(str1: string, state: string?, isAltAttempt: boolean?, origin: string?, str2: string?, str3: string?)
    local tbl1 = {}

    if state then
        if type(state) ~= "string" then
            Logging.warn("Failure logging authPageLoad: Expected state to be a string but got " .. type(state))
            return
        end

        tbl1.state = state
    end

    if isAltAttempt ~= nil then
        if type(isAltAttempt) ~= "boolean" then
            Logging.warn("Failure logging authPageLoad: Expected isAltAttempt to be a boolean but got " .. type(isAltAttempt))

            return
        end

        tbl1.is_alt_attempt = isAltAttempt
    end

    if origin then
        if type(origin) ~= "string" then
            Logging.warn("Failure logging authPageLoad: Expected origin to be a string but got " .. type(origin))
            return
        end

        tbl1.origin = origin
    end

    if str2 ~= nil then
        if type(str2) ~= "string" then
            Logging.warn("Failure logging authPageLoad: Expected field to be a string but got " .. type(str2))
        end

        tbl1.field = tostring(str2)
    end

    if str3 ~= nil then
        if type(str3) ~= "string" then
            Logging.warn("Failure logging authPageLoad: Expected associatedText to be a string but got " .. type(str3))
        end

        tbl1.associatedText = tostring(str3)
    end

    checkAndSendEvent(str1, "authPageload", tbl1)
end
