-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppUpdate = script:FindFirstAncestor("RobloxAppUpdate")
local RobloxAppUpdateParent = RobloxAppUpdate.Parent
local _Types = require(RobloxAppUpdate.Types)
local joinGamePlayButton = require(RobloxAppUpdateParent.DiscoveryAnalytics).Points.joinGamePlayButton
local UpdateMessageType = require(RobloxAppUpdate.UpdateMessageType)
local Promise = require(RobloxAppUpdateParent.Promise)

local tbl1 = {
    [Enum.AppUpdateStatus.Available] = UpdateMessageType.Default,
    [Enum.AppUpdateStatus.AvailableBoundChannel] = UpdateMessageType.InternalChannel,
    [Enum.AppUpdateStatus.AvailableBetaProgram] = UpdateMessageType.BetaProgram
}

return function(arg1, bool1: boolean, arg2, ctx: string)
    return function(_)
        if bool1 and not arg1:canPerformBinaryUpdate() then
            return Promise.resolve(nil)
        end

        return arg1:checkForUpdate():andThen(function(arg3)
            local appUpdateStatus = arg3.appUpdateStatus
            joinGamePlayButton(arg2.InfluxDb, "checkForUpdate", { ctx = ctx, appUpdateStatus = appUpdateStatus })

            if arg3.errorMessage then
                return Promise.reject(arg3.errorMessage)
            end

            return Promise.resolve(tbl1[appUpdateStatus])
        end)
    end
end
