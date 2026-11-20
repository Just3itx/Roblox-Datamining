-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStoreAgeSignalsManager = script:FindFirstAncestor("AppStoreAgeSignalsManager")
local AppStoreAgeSignalsManagerParent = AppStoreAgeSignalsManager.Parent

local Promise = require(AppStoreAgeSignalsManagerParent.Promise)
local AppAgeSignalsTelemetryConfigs = require(AppStoreAgeSignalsManager.Telemetry.AppAgeSignalsTelemetryConfigs)

local bool1 = game:DefineFastFlag("EnableAppAgeSignalsService", false)

return {
    isAvailable = function()
        if not bool1 then
            return false
        end
        local success, result = pcall(function(): AppAgeSignalsService
            return game:GetService("AppAgeSignalsService")
        end)
        if not (success and result) then
            return false
        end
        local success2, result2 = pcall(function()
            return result:IsAvailable()
        end)
        if success2 then
            return result2
        end

        AppAgeSignalsTelemetryConfigs.reportError(
            {
                error = "IsAvailable threw: " .. tostring(result2),
                signalSource = "unknown"
            }
        )
        return false
    end,
    getAppAgeSignalsAsync = function()
        return Promise.new(function(callback, callback2)
            local success, result = pcall(function()
                return game:GetService("AppAgeSignalsService"):GetAppAgeSignalsAsync()
            end)

            if not success then
                callback2(result)
                return
            end

            if result.Error and result.Error ~= "" then
                callback2(result.Error)
            else
                callback(result.PlatformPayload)
            end
        end)
    end
}
