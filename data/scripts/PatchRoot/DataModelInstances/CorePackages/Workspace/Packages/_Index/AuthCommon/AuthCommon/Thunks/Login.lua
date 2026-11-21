-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local LoginByEmail = require(AuthCommon.Thunks.LoginByEmail)
local LoginByPhone = require(AuthCommon.Thunks.LoginByPhone)
local LoginByUsername = require(AuthCommon.Thunks.LoginByUsername)

local isStringEmail = require(AuthCommon.Utils.isStringEmail)
local isStringPhone = require(AuthCommon.Utils.isStringPhone)

local var1 = require(AuthCommon.Parent.AppCommonLib).isTenFootInterface()

return function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    return function(arg10)
        if isStringEmail(arg2) and not (arg9 or var1) then
            return arg10:dispatch(LoginByEmail(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8))
        elseif isStringPhone(arg2) and not (arg9 or var1) then
            return arg10:dispatch(LoginByPhone(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8))
        end

        return arg10:dispatch(LoginByUsername(arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    end
end
