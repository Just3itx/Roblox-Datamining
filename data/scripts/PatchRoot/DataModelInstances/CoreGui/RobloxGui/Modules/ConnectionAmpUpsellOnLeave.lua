-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local TelemetryService = game:GetService("TelemetryService")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FStringLuaAppPlayButtonAgeCheckAmpFeatureName = SharedFlags.FStringLuaAppPlayButtonAgeCheckAmpFeatureName
local FStringLuaAppPlayButtonAgeCheckAmpNameSpace = SharedFlags.FStringLuaAppPlayButtonAgeCheckAmpNameSpace
local FFlagConnectionUpsellAnalytics = SharedFlags.FFlagConnectionUpsellAnalytics
local FFlagPioneerLeaveOnInExpFaeDownAge = SharedFlags.FFlagPioneerLeaveOnInExpFaeDownAge
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url

local maybeLeavePioneerOnFaeDownAge = require(CorePackages.Workspace.Packages.PioneerUtils.maybeLeavePioneerOnFaeDownAge)

local PlacelaunchAgeVerificationRequired = nil
local PlacelaunchParentalApprovalRequired = nil
pcall(function()
    PlacelaunchAgeVerificationRequired = Enum.ConnectionError.PlacelaunchAgeVerificationRequired
    PlacelaunchParentalApprovalRequired = Enum.ConnectionError.PlacelaunchParentalApprovalRequired
end)

local function logTelemetry(config, selectedItem)
    TelemetryService:LogCounter(config, { customFields = { selectedItem = selectedItem } }, 1)
end

local function fetchUniverseIdFromPlaceIdYielding(num1: number)
    local str1 = string.format("%suniverses/v1/places/%d/universe", Url.APIS_URL, num1)
    local success, result = pcall(HttpRbxApiService.GetAsyncFullUrl, HttpRbxApiService, str1)
    if not success or type(result) ~= "string" then
        return nil
    end
    local success2, result2 = pcall(HttpService.JSONDecode, HttpService, result)
    if not success2 or type(result2) ~= "table" then
        return nil
    end
    local universeId = result2.universeId
    return if type(universeId) == "number" and not (universeId <= 0) then universeId else nil
end

local var1 = FFlagConnectionUpsellAnalytics
    and {
        eventName = "unlockPlayIntent",
        backends = { "EventIngest" },
        throttlingPercentage = game:DefineFastInt("ConnectionAmpUnlockPlayIntentThrottleHundredthsPercent", 10000),
        lastUpdated = { 2026, 5, 11 },
        description = "Fired when a user clicks Continue on an AMP age check / parental approval upsell from a game-join flow."
    }
    or nil

local var2 = FFlagConnectionUpsellAnalytics
    and {
        eventName = "gameJoinUpsellImpression",
        backends = { "EventIngest" },
        throttlingPercentage = game:DefineFastInt("ConnectionAmpGameJoinUpsellImpressionThrottleHundredthsPercent", 10000),
        lastUpdated = { 2026, 5, 11 },
        description = "Fired when an AMP age check / parental approval upsell is shown during a game-join flow."
    }
    or nil

local standardizedFields = FFlagConnectionUpsellAnalytics and { "addSessionInfo", "addSessionId", "addOSInfo" } or nil

local var4 = FFlagConnectionUpsellAnalytics
    and {
        upsellName = "AgeCheckRequired",
        playabilityStatus = "ContextualPlayabilityAgeCheckRequired",
        missingPlaceIdItem = "AmpAgeCheckMissingPlaceId",
        universeIdLookupFailedItem = "AgeCheckImpressionUniverseIdLookupFailed"
    }
    or nil

local var5 = FFlagConnectionUpsellAnalytics
    and {
        upsellName = "ParentApprovalRequired",
        playabilityStatus = "ContextualPlayabilityRequireParentApproval",
        missingPlaceIdItem = "AmpParentApprovalMissingPlaceId",
        universeIdLookupFailedItem = "ParentApprovalImpressionUniverseIdLookupFailed"
    }
    or nil

local var6 = FFlagConnectionUpsellAnalytics and {} or nil

local var7 = FFlagConnectionUpsellAnalytics and function(tbl1, eventContext: string, config, universeId: string)
    TelemetryService:LogEvent(config, {
        eventContext = eventContext,
        standardizedFields = standardizedFields,
        customFields = {
            universeId = universeId,
            upsellName = tbl1.upsellName,
            playabilityStatus = tbl1.playabilityStatus
        }
    })
end or nil

local var8 = FFlagConnectionUpsellAnalytics and function(tbl1, num1: number, str1: string)
    local var8 = str1 ~= "" and str1 or var6[num1] or ""
    if str1 and str1 ~= "" then
        var6[num1] = str1
    end
    var7(tbl1, "GameJoin", var1, var8)
end or nil

local var9 = FFlagConnectionUpsellAnalytics and function(config, tbl1, num1: number)
    if not num1 or num1 == 0 then
        logTelemetry(config, tbl1.missingPlaceIdItem)
        return
    end
    local var9 = var6[num1]
    if var9 then
        var7(tbl1, tbl1.upsellName, var2, var9)
        return
    end
    task.spawn(function()
        local var10 = fetchUniverseIdFromPlaceIdYielding(num1)
        local str1 = if var10 then tostring(var10) else ""
        if var10 then
            var6[num1] = str1
        else
            logTelemetry(config, tbl1.universeIdLookupFailedItem)
        end
        var7(tbl1, tbl1.upsellName, var2, str1)
    end)
end or nil

local function loadAmpUpsell() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(require, CorePackages.Workspace.Packages.AmpUpsell)
    return if success then result else nil
end

local function loadCoreScriptsApolloClient() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(require, CoreGui.RobloxGui.Modules.ApolloClient)
    return if success then result else nil
end

local function openWizardThenReconnect(config, callback, num1: number, arg1, arg2, str1: string, arg3, arg4, selectedItem: string)
    logTelemetry(config, selectedItem)
    local var10 = loadAmpUpsell()

    if not var10 then
        logTelemetry(config, "AmpWizardLoadFailed")
        return
    end

    local var11 = loadCoreScriptsApolloClient()

    if not var11 then
        logTelemetry(config, "AmpWizardApolloLoadFailed")
        return
    end

    if not pcall(function()
        var10.InExpAmpWizardController.OpenAmpWizardContainerInExp(arg1, function(granted, arg5)
            local bool1 = granted == var10.AmpEnums.AccessResponseEnum.Granted
            if bool1 then
                logTelemetry(config, "AmpWizardGrantedReconnect")
                if not FFlagPioneerLeaveOnInExpFaeDownAge then
                    callback()
                end
            else
                logTelemetry(config, "AmpWizardNotGranted")
            end

            if not FFlagPioneerLeaveOnInExpFaeDownAge then
                return
            end

            local ampEnums = var10.AmpEnums
            local bool2 = not (arg5 == nil) and arg5[ampEnums.ActionTypeEnum.AgeEstimation] == ampEnums.ActionStatusEnum.Success

            maybeLeavePioneerOnFaeDownAge(bool2, function()
                if bool1 then
                    callback()
                end
            end)
        end, arg3, str1, arg4, arg2, var11, num1, true)
    end) then
        logTelemetry(config, "AmpWizardOpenError")
    end
end

return {
    PrimaryButtonText = "Continue",
    PrimaryButtonLocalizationKey = "InGame.ConnectionError.Action.Continue",
    AgeVerificationRequiredEnum = PlacelaunchAgeVerificationRequired,
    ParentalApprovalRequiredEnum = PlacelaunchParentalApprovalRequired,
    createAgeCheckCallback = function(config, callback, num1: number)
        local num2 = num1 + 1
        return function()
            if FFlagConnectionUpsellAnalytics then
                var8(var4, game.PlaceId, "")
            end
            openWizardThenReconnect(
                config,
                callback,
                num2,
                FStringLuaAppPlayButtonAgeCheckAmpFeatureName,
                FStringLuaAppPlayButtonAgeCheckAmpNameSpace,
                "gameJoinAgeCheckRequired",
                nil,
                nil,
                "AmpAgeCheckOpened"
            )
        end
    end,
    createParentalApprovalCallback = function(config, callback, num1: number)
        local num2 = num1 + 1
        return function()
            local placeId = game.PlaceId
            if not placeId or placeId == 0 then
                logTelemetry(config, "AmpParentApprovalMissingPlaceId")
                return
            end

            task.spawn(function()
                local var10 = fetchUniverseIdFromPlaceIdYielding(placeId)

                if FFlagConnectionUpsellAnalytics then
                    local str1 = if var10 then tostring(var10) else ""
                    var8(var5, placeId, str1)
                end

                if not var10 then
                    logTelemetry(config, "AmpParentApprovalUniverseIdLookupFailed")
                    return
                end
                local universeId = tostring(var10)

                openWizardThenReconnect(
                    config,
                    callback,
                    num2,
                    "CanApproveExperience",
                    nil,
                    "gameJoinContentMaturityLock",
                    { universeId = universeId, experienceManagementAction = "Approve" },
                    nil,
                    "AmpParentApprovalOpened"
                )
            end)
        end
    end,
    fireImpressionAgeCheck = FFlagConnectionUpsellAnalytics and function(arg1, num1: number)
        var9(arg1, var4, num1)
    end or nil,
    fireImpressionParentalApproval = FFlagConnectionUpsellAnalytics and function(arg1, num1: number)
        var9(arg1, var5, num1)
    end or nil
}
