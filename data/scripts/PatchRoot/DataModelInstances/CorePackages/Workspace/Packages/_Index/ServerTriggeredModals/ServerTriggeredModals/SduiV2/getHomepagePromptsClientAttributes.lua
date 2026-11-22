-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent
local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)

local FFlagEdpGameLeavePromptsHandlerEnabled = SharedFlags.FFlagEdpGameLeavePromptsHandlerEnabled
local FFlagSplitPaneEducationalTour = SharedFlags.FFlagSplitPaneEducationalTour
local FFlagPlusUpsellSheetHomePrompt = require(ServerTriggeredModals.Flags.FFlagPlusUpsellSheetHomePrompt)
local FFlagTTOnboardingSheet = require(ServerTriggeredModalsParent.RobloxSubscriptionPurchaseApp).Flags.FFlagTTOnboardingSheet

local FFlagHomepagePromptsHalloween2026Theme = require(ServerTriggeredModals.Flags.FFlagHomepagePromptsHalloween2026Theme)
local FFlagAppThemeHalloween2026 = require(ServerTriggeredModalsParent.SharedFlags.FFlagAppThemeHalloween2026)
local FFlagAppThemeHalloween2026ForAll = require(ServerTriggeredModalsParent.SharedFlags.FFlagAppThemeHalloween2026ForAll)

local Promise = require(ServerTriggeredModalsParent.Promise)
local NotificationsUpsell = require(ServerTriggeredModalsParent.NotificationsUpsell)
local React = require(ServerTriggeredModalsParent.React)
local RobloxAppEnums = require(ServerTriggeredModalsParent.RobloxAppEnums)
local useSelector = require(ServerTriggeredModalsParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalUserId = require(ServerTriggeredModalsParent.RobloxAppHooks).useLocalUserId
local getAppFeaturePolicies = require(ServerTriggeredModalsParent.UniversalAppPolicy).getAppFeaturePolicies
local PromptsEntryPoint = require(script.Parent.PromptsEntryPoint)

local AppPage = RobloxAppEnums.AppPage

local num1 = game:DefineFastInt("PushNotificationsUpsellPromptsClientAttributesTimeoutMs", 1000)

local var1 = nil
local num2 = 0

local function homePageSessionOrdinalFor(num3: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num3 ~= nil and num3 ~= var1 then
        var1 = num3
        num2 += 1
    end

    return num2
end

local function readStoredNumber(str1: string): (boolean, number) -- Luacid: unused: defined but never referenced
    local success, result = pcall(AppStorageService.GetItem, AppStorageService, str1)
    if not success then
        return false, -1
    end

    return true, tonumber(result) or 0
end

local function getExistingHomepageClientAttributes()
    local existingHomepageClientAttributes = ({})

    if FFlagSplitPaneEducationalTour and require(ServerTriggeredModalsParent.SplitPane).isSplitPaneTourSupported() then
        existingHomepageClientAttributes.isSplitPaneTourSupported = "true"
    end

    if FFlagPlusUpsellSheetHomePrompt
        and FFlagTTOnboardingSheet
        and not getAppFeaturePolicies().getDisableBlackbirdEntrypoints()
    then
        existingHomepageClientAttributes.isPlusUpsellSheetPromptSupported = "true"
    end

    local success, result = pcall(AppStorageService.GetItem, AppStorageService, "KidsAccountHasResetToDefaultTheme")
    if success and typeof(result) == "string" and result ~= "" then
        existingHomepageClientAttributes.KidsAccountHasResetToDefaultTheme = result
    end
    if FFlagHomepagePromptsHalloween2026Theme then
        existingHomepageClientAttributes.applicablePlusThemes = if FFlagAppThemeHalloween2026 then "Halloween2026" else ""
        existingHomepageClientAttributes.applicableDeviceThemes = if FFlagAppThemeHalloween2026 and FFlagAppThemeHalloween2026ForAll then "Halloween2026" else ""
    end

    return existingHomepageClientAttributes
end

local function getHomepagePromptsClientAttributes(): {[any]: any}? -- Luacid: Inlined by compiler; 1 call site recovered
    local existingHomepageClientAttributes = getExistingHomepageClientAttributes()

    return if next(existingHomepageClientAttributes) == nil then nil else existingHomepageClientAttributes
end

return {
    get = getHomepagePromptsClientAttributes,
    use = function(homepageLaunch: string, tbl1) -- name: useHomepagePromptsClientAttributes
        local bool1 = homepageLaunch == PromptsEntryPoint.HomepageLaunch and not (FFlagEdpGameLeavePromptsHandlerEnabled and tbl1 ~= nil)
        local var2 = useLocalUserId()
        local var3 = useSelector(function(arg1)
            return arg1.LaunchContext
        end)
        local homePageSessionTimestamp = useSelector(function(arg1)
            return arg1.Personalization and arg1.Personalization.PageSessionTimestamp[AppPage.Home]
        end)
        local var5, var6 = React.useState(nil)
        local userId = tonumber(var2) or 0

        React.useEffect(function()
            if not bool1 then
                return
            end

            local bool2 = true
            local launchContext = var3 or "Unknown"
            local attributes = getHomepagePromptsClientAttributes() or {}

            local promptShownCount = NotificationsUpsell.NotificationsUpsellConstants.LocalStorageKeys.PromptShownCount

            local sysPromptShownTimestamp = NotificationsUpsell.NotificationsUpsellConstants.LocalStorageKeys.SysPromptShownTimestamp
            local success, result = pcall(AppStorageService.GetItem, AppStorageService, promptShownCount)
            local var8, bool3

            if success then
                var8 = tonumber(result) or 0
                bool3 = true
            else
                bool3 = false
                var8 = -1
            end

            local success2, result2 = pcall(AppStorageService.GetItem, AppStorageService, sysPromptShownTimestamp)
            local var9, bool4

            if success2 then
                var9 = tonumber(result2) or 0
                bool4 = true
            else
                bool4 = false
                var9 = -1
            end

            local num4 = homePageSessionOrdinalFor(homePageSessionTimestamp)
            local bool5 = false

            local function resolveWithNativeStatus(nativePushPermissionUpsellStatus: string)
                if bool5 then
                    return
                end
                bool5 = true

                attributes.nativePushPermissionUpsellStatus = nativePushPermissionUpsellStatus
                attributes.launchContext = launchContext
                if homePageSessionTimestamp ~= nil then
                    attributes.homePageSessionTimestamp = tostring(homePageSessionTimestamp)
                    attributes.homePageSessionOrdinal = tostring(num4)
                end
                attributes.legacyPushHistoryReadStatus = if bool3 and bool4 then "SUCCESS" else "ERROR"

                attributes.legacyPushPromptShownCount = tostring(var8)
                attributes.legacyPushSystemPromptShownTimestamp = tostring(var9)

                if not bool2 then
                    return
                end

                var6({
                    attributes = attributes,
                    homePageSessionTimestamp = homePageSessionTimestamp,
                    launchContext = launchContext,
                    userId = userId
                })
            end

            NotificationsUpsell.setupPushNotificationsUpsell.GetPushNotificationPermissionUpsellStatus():andThen(
                resolveWithNativeStatus
            )

            Promise.delay(num1 / 1000):andThen(function()
                resolveWithNativeStatus("TIMEOUT")
            end)

            return function()
                bool2 = false
            end
        end, {
            bool1,
            homePageSessionTimestamp,
            var3,
            userId
        })

        local attributes = if var5 == nil
            or var5.homePageSessionTimestamp ~= homePageSessionTimestamp
            or var5.launchContext ~= (var3 or "Unknown")
            or var5.userId ~= userId then nil else var5.attributes
        return if bool1 then attributes else nil
    end,
    sessionClientAttribute = "homePageSessionOrdinal"
}
