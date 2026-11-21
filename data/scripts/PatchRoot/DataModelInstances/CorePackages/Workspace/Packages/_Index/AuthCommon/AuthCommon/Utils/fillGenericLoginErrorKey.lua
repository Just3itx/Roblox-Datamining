-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local LoginErrorCodes = require(AuthCommon.Enums.LoginErrorCodes)
local isNonTerminalLoginError = require(script.Parent.isNonTerminalLoginError)

local function fillGenericLoginErrorKey(arg1, arg2)
    if typeof(arg1) ~= "table" or arg1.errorKey ~= nil then
        return arg1
    end
    if arg1.errorCode == LoginErrorCodes.AccountLocked then
        return arg1
    end
    if not isNonTerminalLoginError(arg1, arg2) then
        arg1.errorKey = "Authentication.Login.Response.SomethingWentWrong"
    end

    return arg1
end

return fillGenericLoginErrorKey
