-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local getLocalizedToastStringFromHttpError = require(script.Parent.getLocalizedToastStringFromHttpError)

local RobloxAppToastsRoduxParent = script:FindFirstAncestor("RobloxAppToastsRodux").Parent
local mutedError = require(RobloxAppToastsRoduxParent.Loggers).mutedError
local ToastRodux = require(RobloxAppToastsRoduxParent.ToastRodux)
local ToastType = ToastRodux.Enums.ToastType
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local tutils = require(RobloxAppToastsRoduxParent.tutils)

local bool1 = game:DefineFastFlag("LuaAppMutedSetNetworkingErrorToast", false)

local function getUserFacingMessage(arg1)
    local success, result = pcall(HttpService.JSONDecode, HttpService, arg1.Body)
    if not success then
        return nil
    end

    local errors = result.errors
    if errors then
        for _, error in ipairs(errors) do
            local userFacingMessage = error.userFacingMessage
            if userFacingMessage ~= nil then
                return userFacingMessage
            end
        end
    elseif bool1 then
        mutedError("No errors given in err.Body, err = " .. tutils.toString(arg1))
    end

    return nil
end

return function(arg1)
    local var1 = arg1 or {}
    assert(var1, "not nil")

    return function(arg2)
        local toastMessage = getUserFacingMessage(var1)
        if toastMessage then
            arg2:dispatch(
                SetCurrentToastMessage({ toastType = ToastType.InformationMessage, toastMessage = toastMessage, isLocalized = true })
            )

            return
        end

        local localizedToastStringFromHttpError = getLocalizedToastStringFromHttpError(var1.HttpError, var1.StatusCode)
        if localizedToastStringFromHttpError ~= nil then
            arg2:dispatch(
                SetCurrentToastMessage({ toastType = ToastType.NetworkingError, toastMessage = localizedToastStringFromHttpError })
            )
        end
    end
end
