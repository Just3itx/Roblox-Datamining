-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStoreAgeSignalsManager = script:FindFirstAncestor("AppStoreAgeSignalsManager")
local AppStoreAgeSignalsManagerParent = AppStoreAgeSignalsManager.Parent

local Promise = require(AppStoreAgeSignalsManagerParent.Promise)

local AppAgeSignalsServiceWrapper = require(script.Parent.AppAgeSignalsServiceWrapper)
local AppStoreAgeSignalsProvider = require(AppStoreAgeSignalsManager.Utils.AppStoreAgeSignalsProvider)
local AppAgeSignalsTelemetryConfigs = require(AppStoreAgeSignalsManager.Telemetry.AppAgeSignalsTelemetryConfigs)

return {
    requestAppAgeSignals = function()
        if not AppAgeSignalsServiceWrapper.isAvailable() then
            return Promise.reject("AppAgeSignalsService is not available")
        end

        return AppStoreAgeSignalsProvider.checkEligibility():andThen(function(arg1)
            if not arg1.eligible then
                return Promise.reject("User is not eligible for app age signals")
            end

            return AppAgeSignalsServiceWrapper.getAppAgeSignalsAsync():andThen(function(arg2)
                return AppStoreAgeSignalsProvider.publishResult(arg1.signalSource, arg2, "Complete")
            end):catch(function(arg2)
                AppAgeSignalsTelemetryConfigs.reportError({ error = tostring(arg2), signalSource = arg1.signalSource })

                return Promise.reject(arg2)
            end)
        end)
    end
}
