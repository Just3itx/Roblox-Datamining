-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppUpdate = script:FindFirstAncestor("RobloxAppUpdate")
local RobloxAppUpdateParent = RobloxAppUpdate.Parent
local _Types = require(RobloxAppUpdate.Types)
local Thunks = require(RobloxAppUpdate.Thunks)
local GetUpdateMessageType = Thunks.GetUpdateMessageType
local OpenCentralOverlayForUpdateRequiredPrompt = Thunks.OpenCentralOverlayForUpdateRequiredPrompt
local SetNetworkingErrorToast = require(RobloxAppUpdateParent.RobloxAppToastsRodux).Thunks.SetNetworkingErrorToast

return function(arg1, arg2, bool1: boolean, arg3, str1: string, callback)
    arg1(GetUpdateMessageType(arg2, bool1, arg3, str1)):andThen(function(arg4)
        if arg4 then
            arg1(OpenCentralOverlayForUpdateRequiredPrompt(arg2:canPerformBinaryUpdate(), false, arg4))
            return
        end

        callback()
    end):catch(function(arg4)
        warn(arg4)
        arg1(SetNetworkingErrorToast({ HttpError = Enum.HttpError.OK }))
    end)
end
