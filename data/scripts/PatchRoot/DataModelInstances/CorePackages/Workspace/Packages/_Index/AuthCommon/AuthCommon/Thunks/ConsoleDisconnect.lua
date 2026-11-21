-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Promise = require(AuthCommonParent.Promise)

local AuthPlatformDisconnect = require(AuthCommon.Http.Requests.AuthPlatformDisconnect)

local bool1 = game:DefineFastFlag("EnableConsoleDisconnectNetworkingErrorToast", false)
local SetNetworkingErrorToast = require(AuthCommonParent.RobloxAppToastsRodux).Thunks.SetNetworkingErrorToast

local function ConsoleDisconnect(arg1, arg2, arg3)
    return function(arg4)
        return AuthPlatformDisconnect(arg1):andThen(function()
            arg4:dispatch(arg3(arg1, arg2))
            return Promise.resolve()
        end, function(arg5)
            if bool1 then
                arg4:dispatch(SetNetworkingErrorToast(arg5))
            end
            return Promise.reject(arg5)
        end)
    end
end

return ConsoleDisconnect
