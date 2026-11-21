-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local _PlayButtonTypes = require(GamePlayButton.PlayButtonTypes)
local FetchGamePlayButtonData = require(GamePlayButton.FetchGamePlayButtonData)
local PlayButtonUpsellBody = require(GamePlayButton.PlayButtonUpsellBody)

local GamePlayButtonParent = GamePlayButton.Parent
local React = require(GamePlayButtonParent.React)
local useDispatch = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useSelector
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(GamePlayButtonParent.RoactServiceTags).RoactNetworking
local AppEventIngestService = require(GamePlayButtonParent.RoactServiceTags).AppEventIngestService
local flaggedMutedError = require(GamePlayButtonParent.Loggers).flaggedMutedError
local GameHydrationReact = require(GamePlayButtonParent.GameHydrationReact)
local FetchUserSettingsAndOptions = require(GamePlayButtonParent.GameDetailRodux).FetchUserSettingsAndOptions
local Dash = require(GamePlayButtonParent.Dash)
local AppPage = require(GamePlayButtonParent.RobloxAppEnums).AppPage
local NavigateDown = require(GamePlayButtonParent.NavigationRodux).Thunks.NavigateDown
local NavigateBack = require(GamePlayButtonParent.NavigationRodux).Thunks.NavigateBack
local FFlagSignalsNavP3Dispatch = require(GamePlayButtonParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GamePlayButtonParent.RobloxAppNavigation).NavigationCommands else nil
local OpenCloseOnlyInteractiveAlert = require(GamePlayButtonParent.DiscoveryRouting).OpenCloseOnlyInteractiveAlert
local OpenPlayButtonUpsellDialog = require(GamePlayButtonParent.DiscoveryRouting).OpenPlayButtonUpsellDialog
local CloseCentralOverlay = require(GamePlayButtonParent.CentralOverlay).Thunks.CloseCentralOverlay
local useLocalization = require(GamePlayButtonParent.Localization).Hooks.useLocalization
local useAppPolicy = require(GamePlayButtonParent.UniversalAppPolicy).useAppPolicy
local OpenAmpWizardContainer = require(GamePlayButtonParent.AmpUpsell).OpenAmpWizardContainer
local _AmpUpsell = require(GamePlayButtonParent.AmpUpsell)
local authButtonClick = require(GamePlayButtonParent.AuthAnalytics).Events.authButtonClick
local LoggingProtocol = require(GamePlayButtonParent.LoggingProtocol)
local PlayabilityStatusEnum = require(GamePlayButtonParent.DiscoveryTypes).PlayabilityStatusEnum
local unlockPlayIntent = require(GamePlayButtonParent.DiscoveryAnalytics).Events.unlockPlayIntent

local delayedAmpWizardCompletionCallbackOverride = require(GamePlayButton.PlayButtonLaunchChecks.delayedAmpWizardCompletionCallbackOverride)

local throttlingPercentage = game:DefineFastInt("UnknownUpsellErrorEventHundredthsPercent", 0)
local str1 = game:DefineFastString(
    "LuaAppUpsellMaturityRatingToSettingMapping",
    "mild=NinePlus,moderate=ThirteenPlus,restricted=SeventeenPlus,unrated=ThirteenPlus"
)

local FFlagLuaAppParentUpsellPolicy = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppParentUpsellPolicy
local FFlagLuaAppPlayButtonAmpAgeCheckFlow = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonAmpAgeCheckFlow

local FStringLuaAppPlayButtonAgeCheckAmpFeatureName = require(GamePlayButtonParent.SharedFlags).FStringLuaAppPlayButtonAgeCheckAmpFeatureName

local FStringLuaAppPlayButtonAgeCheckAmpNameSpace = require(GamePlayButtonParent.SharedFlags).FStringLuaAppPlayButtonAgeCheckAmpNameSpace
local FFlagLuaAppVpcUpsellNamespace = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppVpcUpsellNamespace

local FStringLuaAppVpcSettingsChangeAmpNameSpace = require(GamePlayButtonParent.SharedFlags).FStringLuaAppVpcSettingsChangeAmpNameSpace

local FStringLuaAppVpcAccountManagementAmpNameSpace = require(GamePlayButtonParent.SharedFlags).FStringLuaAppVpcAccountManagementAmpNameSpace
local FFlagLuaAppParentApprovedExperiences = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppParentApprovedExperiences
local GetFFlagEnableAmpWizardVPCNavigationFix = require(GamePlayButtonParent.AmpUpsell).GetFFlagEnableAmpWizardVPCNavigationFix
local FFlagEnablePlayButtonWizardVPCPrologue = require(GamePlayButton.Flags.FFlagEnablePlayButtonWizardVPCPrologue)
local FFlagLuaAppPlayButtonOdpEventUniverseId = require(GamePlayButton.Flags.FFlagLuaAppPlayButtonOdpEventUniverseId)
local FFlagLuaAppPlayButtonWizardCloseDelay = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonWizardCloseDelay
local FIntLuaAppPlayButtonWizardCloseDelayMs = require(GamePlayButtonParent.SharedFlags).FIntLuaAppPlayButtonWizardCloseDelayMs

local function parseContentMaturityMappingString(str2: string)
    if str2 == "" then
        return {}
    end

    local result = {}

    for _, value in string.split(str2, ",") do
        local tbl1 = string.split(value, "=")

        if #tbl1 == 2 and tbl1[1] ~= "" and tbl1[2] ~= "" then
            result[tbl1[1]] = tbl1[2]
        else
            error(`Invalid content maturity mapping string {str2}`)
        end
    end

    return result
end

local function safeParseContentMaturityMappingString(str2: string)
    local success, result = pcall(function()
        return (parseContentMaturityMappingString(str2))
    end)

    if success then
        return result
    end

    flaggedMutedError(
        "ExperienceParentalControlsUpsellContentMaturityMappingParsingError",
        `Error parsing content maturity mapping string {str2}, error is: {result}`
    )

    return {}
end

local var1 = safeParseContentMaturityMappingString(str1)

return function(universeId: string, callback, pageName: string?)
    local var2 = useRoactService(RoactNetworking)
    local var3 = useRoactService(AppEventIngestService)
    local var4 = useDispatch()

    local var5 = useSelector(function(arg1)
        local ageRecommendation = arg1.AgeRecommendations[universeId]

        if ageRecommendation
            and ageRecommendation.summary
            and ageRecommendation.summary.ageRecommendation
            and ageRecommendation.summary.ageRecommendation.contentMaturity
        then
            return ageRecommendation.summary.ageRecommendation.contentMaturity
        end

        return nil
    end)

    local var6 = GameHydrationReact.useGameInfo(universeId)
    local contentMaturity = var6 and var6.contentMaturity

    local contentMaturityRating = var5 or contentMaturity

    local var8 = useLocalization({
        unplayableTitleText = "Feature.ExperienceDetails.RestrictedUnplayableModal.Label.Title",
        unplayableBodyText = "Feature.ExperienceDetails.RestrictedUnplayableModal.Label.Body",
        unplayableButtonText = "Feature.ExperienceDetails.RestrictedUnplayableModal.Action.Ok",
        askYourParentTitleText = "Feature.ExperienceDetails.AskYourParentModal.Label.Title",
        askYourParentBodyText = "Feature.ExperienceDetails.AskYourParentModal.Label.Body",
        askYourParentToAllowGameBodyText = if FFlagLuaAppParentApprovedExperiences then "Feature.ExperienceDetails.AskYourParentToAllowGameModal.Label.Body" else nil,
        askYourParentActionButtonText = "Feature.ExperienceDetails.AskYourParentModal.Action.AskNow",
        askYourParentCancelButtonText = "Feature.ExperienceDetails.AskYourParentModal.Action.Cancel",
        consoleSelfUpdateSettingTitleText = "Feature.ExperienceDetails.UpdateMaturitySettingModal.Console.Label.Title",
        consoleSelfUpdateSettingBodyText = "Feature.ExperienceDetails.UpdateMaturitySettingModal.Console.Label.Body",
        consoleSelfUpdateSettingButtonText = "Feature.ExperienceDetails.UpdateMaturitySettingModal.Console.Action.Ok"
    })

    local var9 = React.useCallback(function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        local var9 = var4
        local var10 = OpenAmpWizardContainer

        if not FFlagLuaAppPlayButtonAmpAgeCheckFlow then
            arg5 = nil
        end

        if not (FFlagLuaAppPlayButtonAmpAgeCheckFlow or FFlagLuaAppVpcUpsellNamespace) then
            arg6 = nil
        end

        local var11 = nil
        local var12 = nil
        if not FFlagLuaAppPlayButtonWizardCloseDelay then
            arg7 = nil
        end

        local var13 = if FFlagEnablePlayButtonWizardVPCPrologue and arg8 then true else nil
        if not FFlagEnablePlayButtonWizardVPCPrologue then
            arg8 = nil
        end

        var9(var10(arg1, arg2, arg3, arg4, arg5, arg6, var11, var12, arg7, var13, arg8))
    end, { var4 })

    local var10 = React.useCallback(function(featureName, localizationStrings, onCloseModal, onCancelled)
        local tbl1 = {
            name = AppPage.AccountSettingsUpsell,
            extraProps = {
                featureName = featureName,
                localizationStrings = localizationStrings,
                onCloseModal = onCloseModal,
                onCancelled = onCancelled
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1), true)
            return
        end
        var4(NavigateDown(tbl1, true))
    end, { var4 })

    local var11 = React.useCallback(function(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
        var4(OpenPlayButtonUpsellDialog(arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    end, { var4 })

    local var12 = React.useCallback(function(arg1, arg2, arg3, arg4, arg5)
        var4(OpenCloseOnlyInteractiveAlert(arg1, arg2, arg3, arg4, arg5))
    end, { var4 })

    local var13 = React.useCallback(function()
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.back(true)
            return
        end
        var4(NavigateBack(true))
    end, { var4 })

    local var14 = React.useCallback(function()
        var4(CloseCentralOverlay())
    end, { var4 })

    local var15 = React.useCallback(function()
        var4(FetchGamePlayButtonData.Fetch(var2, universeId, true))
    end, { var4, var2, universeId })

    local var16 = React.useCallback(function()
        var13()

        var15()
    end, { var13, var15 })

    local onCloseModal = React.useCallback(function()
        var14()

        authButtonClick("gameJoinContentMaturityLock", "cancelAskParent")

        var15()
    end, { var14, var15 })

    local var18 = nil
    if FFlagEnablePlayButtonWizardVPCPrologue then
        local useCallback = React.useCallback
        local function func1(bodyText: string)
            local module = {
                config = {
                    titleText = var8.askYourParentTitleText,
                    bodyText = if FFlagLuaAppVpcUpsellNamespace then bodyText else nil,
                    bodyContent = React.createElement(PlayButtonUpsellBody, { bodyText = bodyText, onCloseModal = onCloseModal }),
                    confirmText = var8.askYourParentActionButtonText,
                    cancelText = var8.askYourParentCancelButtonText,
                    cancelFirst = true,
                    dialogSize = "Medium",
                    hasBackdrop = true,
                    onCloseCancels = true
                },
                onConfirm = 0,
                onCancel = 0,
                odpEventUniverseId = 0
            }

            function module.onConfirm()
                authButtonClick("gameJoinContentMaturityLock", "askParent")
            end
            function module.onCancel()
                authButtonClick("gameJoinContentMaturityLock", "cancelAskParent")
            end

            module.odpEventUniverseId = if FFlagLuaAppPlayButtonOdpEventUniverseId then universeId else nil
            return module
        end

        local askYourParentTitleText = var8.askYourParentTitleText
        local askYourParentActionButtonText = var8.askYourParentActionButtonText
        local askYourParentCancelButtonText = var8.askYourParentCancelButtonText
        local var19 = if FFlagLuaAppPlayButtonOdpEventUniverseId then universeId else nil
        var18 = useCallback(
            func1,
            {
                askYourParentTitleText,
                askYourParentActionButtonText,
                askYourParentCancelButtonText,
                onCloseModal,
                var19
            }
        )
    end

    local useCallback = React.useCallback
    local function func1(contentAgeRestriction: string?, arg1)
        var14()

        if not FFlagEnablePlayButtonWizardVPCPrologue then
            authButtonClick("gameJoinContentMaturityLock", "askParent")
        end

        if FFlagLuaAppParentApprovedExperiences then
            local var19 = var9
            local str4 = "CanApproveExperience"
            local var20 = if GetFFlagEnableAmpWizardVPCNavigationFix() then var15 else var13
            local tbl1 = { universeId = universeId, experienceManagementAction = "Approve" }

            local str5 = "gameJoinContentMaturityLock"
            local var21 = nil
            local var22 = if FFlagLuaAppVpcUpsellNamespace then FStringLuaAppVpcAccountManagementAmpNameSpace else nil
            local var23 = nil
            if not FFlagEnablePlayButtonWizardVPCPrologue then
                arg1 = nil
            end

            var19(str4, var20, tbl1, str5, var21, var22, var23, arg1)
            return
        end

        local var19 = var9
        local str4 = "CanChangeSetting"
        local var20 = if GetFFlagEnableAmpWizardVPCNavigationFix() then var15 else var13
        local tbl1 = { contentAgeRestriction = contentAgeRestriction }

        local str5 = "gameJoinContentMaturityLock"
        local var21 = nil
        local var22 = if FFlagLuaAppVpcUpsellNamespace then FStringLuaAppVpcSettingsChangeAmpNameSpace else nil
        local var23 = nil
        if not FFlagEnablePlayButtonWizardVPCPrologue then
            arg1 = nil
        end

        var19(str4, var20, tbl1, str5, var21, var22, var23, arg1)
    end

    local var19 = if GetFFlagEnableAmpWizardVPCNavigationFix() then var15 else nil
    local var20 = if GetFFlagEnableAmpWizardVPCNavigationFix() then nil else var13
    local var21 = if FFlagLuaAppParentApprovedExperiences then universeId elseif FFlagEnablePlayButtonWizardVPCPrologue then if FFlagLuaAppPlayButtonOdpEventUniverseId then universeId else nil else nil
    local var22 = useCallback(func1, { var9, var19, var20, var14, var21 })

    local var23 = React.useCallback(function(upsellName: string, str4: string?)
        unlockPlayIntent(var3, {
            universeId = universeId,
            upsellName = upsellName,
            playabilityStatus = if FFlagLuaAppParentApprovedExperiences then str4 or PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls else PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls,
            pageName = pageName
        })
    end, { var3, universeId, pageName })

    local var24 = if FFlagLuaAppParentUpsellPolicy then useAppPolicy(function(arg1)
        return arg1.getShouldShowVpcPlayButtonUpsells()
    end) else nil

    local var25 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local var26

    if FFlagLuaAppParentApprovedExperiences then
        local useCallback2 = React.useCallback

        local function func2(arg1)
            if FFlagLuaAppParentUpsellPolicy and not var24 then
                callback(arg1)

                var23("GameLaunch", PlayabilityStatusEnum.ContextualPlayabilityRequireParentApproval)

                return
            end

            if FFlagEnablePlayButtonWizardVPCPrologue then
                var22(nil, var18(var8.askYourParentToAllowGameBodyText))
            else
                var11(
                    var8.askYourParentTitleText,
                    var8.askYourParentToAllowGameBodyText,
                    var8.askYourParentActionButtonText,
                    var8.askYourParentCancelButtonText,
                    var22,
                    onCloseModal,
                    onCloseModal
                )
            end

            var23("ParentApprovedExperience", PlayabilityStatusEnum.ContextualPlayabilityRequireParentApproval)
        end

        local var27 = var24
        local askYourParentTitleText = var8.askYourParentTitleText
        local askYourParentToAllowGameBodyText = var8.askYourParentToAllowGameBodyText
        local askYourParentActionButtonText = var8.askYourParentActionButtonText
        local askYourParentCancelButtonText = var8.askYourParentCancelButtonText
        local var28 = if FFlagEnablePlayButtonWizardVPCPrologue then var18 else nil
        var26 = useCallback2(func2, {
            var11,
            var22,
            onCloseModal,
            var23,
            callback,
            var27,
            askYourParentTitleText,
            askYourParentToAllowGameBodyText,
            askYourParentActionButtonText,
            askYourParentCancelButtonText,
            var28
        })
    else
        var26 = nil
    end

    local useCallback2 = React.useCallback

    local function func2(arg1)
        if FFlagLuaAppParentUpsellPolicy and not var24 then
            callback(arg1)

            var23("GameLaunch")
            return
        end

        FetchUserSettingsAndOptions(var2):andThen(function(arg2)
            local contentAgeRestriction = arg2.contentAgeRestriction

            if not (contentAgeRestriction and contentMaturityRating) then
                flaggedMutedError(
                    "ExperienceParentalControlsUpsellUnknownContentMaturityRating",
                    `Unknown content maturity rating {contentMaturityRating} or age restriction setting {contentAgeRestriction} for Contextual Parental Controls upsell on play button click`
                )
                callback(arg1)

                var23("GameLaunch")
                return
            end

            assert(contentMaturityRating, "Content maturity rating must be present to show correct upsell")

            if not var1[contentMaturityRating] then
                LoggingProtocol.default:logRobloxTelemetryEvent({
                    eventName = "ExperienceParentalControlsUpsellUnexpectedContentMaturityRating",
                    backends = { LoggingProtocol.TelemetryBackends.Points },
                    throttlingPercentage = throttlingPercentage,
                    lastUpdated = { 25, 8, 26 },
                    description = "Unexpected content maturity rating for Contextual Parental Controls upsell on play button click"
                }, { LoggingProtocol.default.StandardizedFields.addOsInfo }, {
                    eventName = "ExperienceParentalControlsUpsellUnexpectedContentMaturityRating",
                    contentMaturityRating = contentMaturityRating,
                    universeId = universeId
                })
                callback(arg1)

                var23("GameLaunch")
                return
            end

            local var27 = var1[contentMaturityRating]

            local var28 = Dash.find(contentAgeRestriction.options, function(arg3): boolean
                return not not (arg3 and arg3.option and arg3.option.optionValue == var27)
            end)

            if not var28 then
                var12(var8.unplayableTitleText, var8.unplayableBodyText, var14, var8.unplayableButtonText, true)

                var23("RestrictedUnplayableOptionNotFound")

                return
            end

            local requirement = var28.requirement

            if requirement == "SelfUpdateSetting" then
                if not var25 then
                    var12(
                        var8.consoleSelfUpdateSettingTitleText,
                        var8.consoleSelfUpdateSettingBodyText,
                        var14,
                        var8.consoleSelfUpdateSettingButtonText,
                        true
                    )
                else
                    var10("gameJoinContentMaturityLock", {
                        title = "Feature.ExperienceDetails.UpdateMaturitySettingModal.Label.Title",
                        message = "Feature.ExperienceDetails.UpdateMaturitySettingModal.Label.Body",
                        buttonCancel = "Feature.ExperienceDetails.UpdateMaturitySettingModal.Action.Cancel",
                        buttonSettings = "Feature.ExperienceDetails.UpdateMaturitySettingModal.Action.GoToSettings"
                    }, var16, var16)
                end
            elseif requirement == "ParentalConsent" then
                if FFlagEnablePlayButtonWizardVPCPrologue then
                    var22(var28.option.optionValue, var18(var8.askYourParentBodyText))
                else
                    var11(
                        var8.askYourParentTitleText,
                        var8.askYourParentBodyText,
                        var8.askYourParentActionButtonText,
                        var8.askYourParentCancelButtonText,
                        function()
                            var22(var28.option.optionValue)
                        end,
                        onCloseModal,
                        onCloseModal
                    )
                end
            elseif requirement == "ContentAgeRestrictionVerification" then
                var9(
                    if FFlagLuaAppPlayButtonAmpAgeCheckFlow then FStringLuaAppPlayButtonAgeCheckAmpFeatureName else "ShouldNotPromptSeventeenPlusSettingVerifications",
                    var15,
                    nil,
                    if FFlagLuaAppPlayButtonAmpAgeCheckFlow then if pageName then `gameJoinContentMaturityLock-{pageName}` else "gameJoinContentMaturityLock" else nil,
                    nil,
                    if FFlagLuaAppPlayButtonAmpAgeCheckFlow then FStringLuaAppPlayButtonAgeCheckAmpNameSpace else nil,
                    if FFlagLuaAppPlayButtonWizardCloseDelay then delayedAmpWizardCompletionCallbackOverride(var15, FIntLuaAppPlayButtonWizardCloseDelayMs) else nil
                )
            else
                flaggedMutedError(
                    "ExperienceParentalControlsUnknownUpsellRequirement",
                    `Unknown requirement {requirement} for ContentAgeRestriction option {var28} on play button click`
                )
                callback(arg1)
            end

            var23(requirement or "GameLaunch")
        end, function()
            callback(arg1)

            var23("GameLaunch")
        end)
    end

    local var27 = if FFlagLuaAppPlayButtonAmpAgeCheckFlow then var15 else nil
    local tableValue1 = var2
    local tableValue2 = universeId
    local tableValue3 = callback
    local tableValue4 = contentMaturityRating
    local tableValue5 = var4
    local tableValue6 = var10
    local tableValue7 = var9
    local tableValue8 = var12
    local tableValue9 = var11
    local tableValue10 = var22
    local tableValue11 = var16
    local tableValue12 = onCloseModal
    local tableValue13 = var14
    local tableValue14 = var27
    local tableValue15 = var23
    local tableValue16 = var8.unplayableTitleText
    local unplayableBodyText = var8.unplayableBodyText
    local unplayableButtonText = var8.unplayableButtonText
    local askYourParentTitleText = var8.askYourParentTitleText
    local askYourParentBodyText = var8.askYourParentBodyText
    local askYourParentActionButtonText = var8.askYourParentActionButtonText
    local askYourParentCancelButtonText = var8.askYourParentCancelButtonText
    local consoleSelfUpdateSettingTitleText = var8.consoleSelfUpdateSettingTitleText
    local consoleSelfUpdateSettingBodyText = var8.consoleSelfUpdateSettingBodyText
    local consoleSelfUpdateSettingButtonText = var8.consoleSelfUpdateSettingButtonText
    local var28 = var24
    local var29 = if FFlagEnablePlayButtonWizardVPCPrologue then var18 else nil
    local var30 = useCallback2(func2, {
        tableValue1,
        tableValue2,
        tableValue3,
        tableValue4,
        tableValue5,
        tableValue6,
        tableValue7,
        tableValue8,
        tableValue9,
        tableValue10,
        tableValue11,
        tableValue12,
        tableValue13,
        tableValue14,
        tableValue15,
        tableValue16,
        unplayableBodyText,
        unplayableButtonText,
        askYourParentTitleText,
        askYourParentBodyText,
        askYourParentActionButtonText,
        askYourParentCancelButtonText,
        consoleSelfUpdateSettingTitleText,
        consoleSelfUpdateSettingBodyText,
        consoleSelfUpdateSettingButtonText,
        var28,
        var25,
        pageName,
        var29
    })

    if not FFlagLuaAppParentApprovedExperiences then
        var26 = nil
    end

    return var30, var26
end
