-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local CreatorCredit = require(BuildExperienceParent.DataHydration.CreatorCredit)
local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local DataHydration = require(BuildExperienceParent.DataHydration)
local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local Foundation = require(BuildExperienceParent.Foundation)
local InputHandlers = require(BuildExperienceParent.InputHandlers)
local NumberLocalization = require(BuildExperienceParent.Localization).NumberLocalization
local React = require(BuildExperienceParent.React)
local ReactFocusNavigation = require(BuildExperienceParent.ReactFocusNavigation)
local Responsive = require(BuildExperienceParent.Responsive)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local useOpenWebView = require(BuildExperienceParent.WebViewUtils).useOpenWebView

local FFlagEnablePaidAds = require(BuildExperience.Flags.FFlagEnablePaidAds)
local FFlagBuildAdsManagerUniverseUrl = require(BuildExperience.Flags.FFlagBuildAdsManagerUniverseUrl)
local getAdsManagerUrl = require(script.Parent.Parent.getAdsManagerUrl)
local adCampaignEligibilityUtils = require(script.Parent.Parent.adCampaignEligibilityUtils)
local adCampaignScheduleUtils = require(script.Parent.Parent.adCampaignScheduleUtils)
local CreateAdCampaignSheetConfig = require(script.Parent.CreateAdCampaignSheetConfig)
local _CreateAdCampaignSheetView = require(script.Parent.CreateAdCampaignSheetView)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local useOpenBuyRobuxWebView = require(BuildExperience.Components.CreatorCreditSheet.useOpenBuyRobuxWebView)
local useOpenWebViewWithResumeRefresh = require(BuildExperience.utils.useOpenWebViewWithResumeRefresh)

local DataStatus = DataHydration.DataStatus
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local IconName = Foundation.Enums.IconName
local campaignEndMs = adCampaignScheduleUtils.campaignEndMs
local useDefaultFocusBehavior = ReactFocusNavigation.useDefaultFocusBehavior
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local signal = Signals.createSignal({ status = "succeeded" })

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function formatNumber(num1: number) -- Luacid: Inlined by compiler; 4 call sites recovered
    return NumberLocalization.localize(string.format("%.0f", math.floor(num1)), LocalizationService.RobloxLocaleId)
end

local function requireCampaignValue(num1: number?, str1: string): number? -- Luacid: unused: defined but never referenced
    if num1 == nil then
        error(`{str1} is required for the two-option ad campaign sheet`)
    end
    return num1
end

local function requireCampaignOffers(campaignOffers) -- Luacid: Inlined by compiler; 1 call site recovered
    if campaignOffers == nil or campaignOffers.feedback == nil and campaignOffers.plays == nil then
        error("campaignOffers is required for the two-option ad campaign sheet")
    end
    return campaignOffers
end

local function getCampaignOffer(bool1: boolean, str1: string?) -- Luacid: Inlined by compiler; 4 call sites recovered
    return if str1 == "feedback" then bool1.feedback elseif str1 == "plays" then bool1.plays else nil
end

local function toCampaignOption(arg1, title: string, runDates: string, description: string, priceText: string)
    local bool1 = arg1.fundingType == "free"
    local tbl2 = {
        value = arg1.campaignOption,
        title = title,
        runDates = runDates,
        description = description,
        priceText = 0,
        originalPriceText = 0
    }

    if not bool1 then
        priceText = formatNumber(arg1.priceRobux)
    end

    tbl2.priceText = priceText
    tbl2.originalPriceText = if bool1 then formatNumber(arg1.priceRobux) else nil
    return tbl2
end

local function useTwoOptionsControls(isFocusable: boolean, callback: (...any) -> (...any), callback2: (...any) -> (...any), bool2: boolean, bool3: boolean, bool4: boolean, callback3: (...any) -> (...any), arg1, str1: string, num1: number?)
    local var1 = Responsive.usePreferredInput()
    local adCampaignCheckFunds = CreatorAgentChat.getCreatorAgentChatStore(false).adCampaignCheckFunds
    local defaultOffer = adCampaignEligibilityUtils.getDefaultOffer(bool2)
    local campaignOption = if arg1 ~= nil then arg1.campaignOption else defaultOffer.campaignOption
    local selectedOption, var3 = React.useState(campaignOption)
    local var4 = React.useRef(nil)

    local var5, var6 = React.useState(nil)

    local var7 = SignalsReact.useSignalState(if var5 ~= nil then var5.state else signal)
    local var8 = React.useCallback(function(arg2)
        if arg2 == nil or arg2.fundingType ~= "paid" then
            var6(nil)
            return
        end
        var6(adCampaignCheckFunds({ campaignOption = arg2.campaignOption }))
    end, { adCampaignCheckFunds })
    React.useEffect(function()
        if var5 ~= nil then
            return function()
                var5.dispose()
            end
        end
    end, { var5 or false })

    React.useEffect(function()
        if not isFocusable then
            if not bool4 then
                var3(campaignOption)
            end
            var6(nil)
            return
        end
        var3(function(arg2)
            if bool3 or bool4 then
                local bool5 = bool2

                if (if arg2 == "feedback" then getCampaignOffer(bool5, "feedback") elseif arg2 == "plays" then getCampaignOffer(bool5, "plays") else nil) ~= nil then
                    return arg2
                end
            end

            return campaignOption
        end)
    end, {
        isFocusable,
        bool3,
        bool4,
        campaignOption,
        bool2
    })

    local campaignOffer = if selectedOption == "feedback" then getCampaignOffer(bool2, "feedback") elseif selectedOption == "plays" then getCampaignOffer(bool2, "plays") else nil
    local isErrorForSelectedOption = bool4 and (var4.current == nil or var4.current == selectedOption)
    React.useEffect(function()
        if isFocusable and not (isErrorForSelectedOption or bool3) then
            var8(campaignOffer)
        end
    end, {
        isFocusable,
        bool3,
        isErrorForSelectedOption,
        campaignOffer,
        var8
    })
    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg2)
                    callback()
                    arg2:cancel()
                end)
            }
        }
    end, { callback })
    local var10 = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        isFocusable = isFocusable,
        shouldRestoreFocus = false,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })
    local defaultOptionRef, sheetRootRef = useDefaultFocusBehavior(var10)
    local onOptionChanged = React.useCallback(function(str2: string)
        var3(str2)
    end, {})
    local result = var7.result
    local bool6 = not (campaignOffer == nil) and campaignOffer.fundingType == "paid"
    local isFundingCheckPending = not bool3 and not isErrorForSelectedOption and bool6 and (var5 == nil or var7.status == "pending")
    local bool8 = not bool3 and not isErrorForSelectedOption and bool6 and var7.status == "failed"
    local canFund = bool6 and var7.status == "succeeded" and result ~= nil and result.canFund
    local bool9 = not (bool3 or isErrorForSelectedOption)

    if bool9 then
        if bool6 then
            if var7.status == "succeeded" and result ~= nil then
                bool9 = not result.canFund
            else
                bool9 = false
            end
        else
            bool9 = bool6
        end
    end

    local var14 = React.useCallback(function()
        callback3()
        if isFocusable and bool6 then
            var8(campaignOffer)
        end
    end, {
        isFocusable,
        bool6,
        campaignOffer,
        var8,
        callback3
    })

    local onOpenBuyRobux = useOpenBuyRobuxWebView(var14)
    local var16

    if FFlagBuildAdsManagerUniverseUrl then
        local adsManagerUrl = getAdsManagerUrl.getAdsManagerUrl(num1)
        var16 = useOpenWebViewWithResumeRefresh(adsManagerUrl, str1, var14)
    else
        var16 = useOpenWebViewWithResumeRefresh(getAdsManagerUrl.getDefaultAdsManagerUrl(), str1, var14)
    end

    local onCreate = React.useCallback(function()
        if bool9 then
            onOpenBuyRobux()
            return
        end

        if bool8 then
            var8(campaignOffer)
            return
        end

        if bool6 and not isErrorForSelectedOption and not canFund or campaignOffer == nil then
            return
        end

        var4.current = campaignOffer.campaignOption
        callback2({ paymentType = campaignOffer.fundingType, campaignOption = campaignOffer.campaignOption })
    end, {
        callback2,
        campaignOffer,
        bool9,
        onOpenBuyRobux,
        bool6,
        isErrorForSelectedOption,
        canFund,
        bool8,
        var8
    })

    return {
        sheetRootRef = sheetRootRef,
        defaultOptionRef = defaultOptionRef,
        selectedOption = selectedOption,
        showCloseButton = var1 ~= Responsive.Input.Directional,
        isFundingCheckPending = isFundingCheckPending,
        isPrimaryActionDisabled = campaignOffer == nil or not isErrorForSelectedOption and bool6 and not canFund and not (bool9 or bool8),
        shouldBuyRobux = bool9,
        showAdCreditsCallout = not bool3 and canFund and result.fundingSource == "ad_credit",
        isErrorForSelectedOption = isErrorForSelectedOption,
        onOptionChanged = onOptionChanged,
        onOpenBuyRobux = onOpenBuyRobux,
        onOpenAdsManager = var16,
        onCreate = onCreate
    }
end

local function useCreateAdCampaignSheetViewModel(tbl2)
    local creatorCreditStore = CreatorCredit.getCreatorCreditStore(false)
    local var1 = React.useMemo(function()
        return creatorCreditStore.getQuotaSummary()
    end, { creatorCreditStore })
    local var2 = SignalsReact.useSignalState(var1.data)
    local var3 = SignalsReact.useSignalState(var1.status)

    local var4 = useOpenWebView()
    local var5 = FFlagEnablePaidAds
    local var6 = if var5 then requireCampaignOffers(tbl2.campaignOffers) else nil
    local feedback = if var6 == nil then nil else var6.feedback
    local plays = if var6 == nil then nil else var6.plays
    local durationDays = if var5 and feedback ~= nil then feedback.durationDays else tbl2.campaignDurationDays or CreateAdCampaignSheetConfig.DEFAULT_CAMPAIGN_DURATION_DAYS
    local var8 = if var5 and feedback ~= nil then feedback.priceRobux else tbl2.estimatedPriceRobux or CreateAdCampaignSheetConfig.DEFAULT_ESTIMATED_PRICE_ROBUX
    local runStartTimeMs

    if var5 then
        runStartTimeMs = tbl2.runStartTimeMs

        if runStartTimeMs == nil then
            error("runStartTimeMs is required for the two-option ad campaign sheet")
        end
    else
        runStartTimeMs = tbl2.runStartTimeMs or CreateAdCampaignSheetConfig.DEFAULT_RUN_START_TIME_MS
    end

    local var9 = if var5 then campaignEndMs(runStartTimeMs, durationDays) elseif tbl2.runEndTimeMs ~= nil then tbl2.runEndTimeMs else CreateAdCampaignSheetConfig.DEFAULT_RUN_END_TIME_MS
    local var10 = if tbl2.useLocalRunDates == true then LocalizationStrings.formatAdCampaignSheetLocalDate else LocalizationStrings.formatAdCampaignSheetDate
    local startDate = var10(runStartTimeMs)
    local endDate = var10(var9)
    local title = if var5 then LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_TITLE else LocalizationStrings.AD_CAMPAIGN_SHEET_TITLE
    local moderationNotice = if var5 then LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_MODERATION_NOTICE else LocalizationStrings.AD_CAMPAIGN_SHEET_MODERATION_NOTICE
    local tbl3 = {
        title = title,
        description = {
            LocalizationStrings.AD_CAMPAIGN_SHEET_DESCRIPTION,
            durationDays = durationDays
        },
        campaignTitle = {
            LocalizationStrings.AD_CAMPAIGN_SHEET_CAMPAIGN_TITLE,
            durationDays = durationDays
        },
        runDates = {
            LocalizationStrings.AD_CAMPAIGN_SHEET_RUN_DATES,
            startDate = startDate,
            endDate = endDate
        },
        free = LocalizationStrings.AD_CAMPAIGN_SHEET_FREE,
        earnedRobuxDisclaimer = LocalizationStrings.AD_CAMPAIGN_SHEET_EARNED_ROBUX_DISCLAIMER,
        includedTitle = LocalizationStrings.AD_CAMPAIGN_SHEET_INCLUDED_TITLE,
        maximizePlays = LocalizationStrings.AD_CAMPAIGN_SHEET_MAXIMIZE_PLAYS,
        targetPlayers = LocalizationStrings.AD_CAMPAIGN_SHEET_TARGET_PLAYERS,
        performanceReport = LocalizationStrings.AD_CAMPAIGN_SHEET_PERFORMANCE_REPORT,
        legal = {
            LocalizationStrings.AD_CAMPAIGN_SHEET_LEGAL,
            advertisingTermsStart = CreateAdCampaignSheetConfig.ADVERTISING_TERMS_START_MARKER,
            advertisingTermsEnd = CreateAdCampaignSheetConfig.ADVERTISING_TERMS_END_MARKER,
            advertisingStandardsStart = CreateAdCampaignSheetConfig.ADVERTISING_STANDARDS_START_MARKER,
            advertisingStandardsEnd = CreateAdCampaignSheetConfig.ADVERTISING_STANDARDS_END_MARKER
        },
        create = LocalizationStrings.AD_CAMPAIGN_SHEET_CREATE,
        moderationNotice = moderationNotice,
        createError = LocalizationStrings.AD_CAMPAIGN_SHEET_CREATE_ERROR
    }
    if var5 then
        tbl3.forbiddenError = LocalizationStrings.AD_CAMPAIGN_SHEET_FORBIDDEN_ERROR
        tbl3.insufficientFundsError = LocalizationStrings.AD_CAMPAIGN_SHEET_INSUFFICIENT_FUNDS_ERROR
        tbl3.internalError = LocalizationStrings.AD_CAMPAIGN_SHEET_INTERNAL_ERROR
        tbl3.missingThumbnailError = LocalizationStrings.AD_CAMPAIGN_SHEET_MISSING_THUMBNAIL_ERROR
        tbl3.introduction = LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_INTRODUCTION
        tbl3.startCampaignTitle = LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_CAMPAIGN_PICKER_TITLE
        if feedback ~= nil then
            tbl3.feedbackOptionTitle = {
                LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_OPTION_TITLE,
                durationDays = feedback.durationDays
            }
            tbl3.feedbackRunDates = {
                LocalizationStrings.AD_CAMPAIGN_SHEET_RUN_DATES,
                startDate = startDate,
                endDate = var10(campaignEndMs(runStartTimeMs, feedback.durationDays))
            }
            tbl3.feedbackDescription = LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_SHORT_DESCRIPTION
        end
        if plays ~= nil then
            tbl3.playsOptionTitle = {
                LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_OPTION_TITLE,
                durationDays = plays.durationDays
            }
            tbl3.playsRunDates = {
                LocalizationStrings.AD_CAMPAIGN_SHEET_RUN_DATES,
                startDate = startDate,
                endDate = var10(campaignEndMs(runStartTimeMs, plays.durationDays))
            }
            tbl3.playsDescription = LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_LONG_DESCRIPTION
        end
        tbl3.buyRobux = LocalizationStrings.CREATOR_CREDIT_BUY_ROBUX_BUTTON
        tbl3.adCreditsTitle = LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_AD_CREDITS_TITLE
        tbl3.adCreditsAction = LocalizationStrings.TWO_OPTIONS_AD_CAMPAIGN_SHEET_AD_CREDITS_ACTION
        tbl3.adsManager = LocalizationStrings.ADS_STATS_ADS_MANAGER
    end
    local var15 = useLocalization(tbl3)

    local bool1 = tbl2.waitForCreateResult == true
    local isCreatePending = bool1 and tbl2.isCreatePending == true
    local hasCreateError = bool1 and tbl2.hasCreateError == true
    local createError = var15.createError
    if var5 and hasCreateError then
        local createErrorKind = tbl2.createErrorKind
        if createErrorKind == "payment_required" then
            createError = var15.insufficientFundsError
        elseif createErrorKind == "ineligible" then
            createError = var15.forbiddenError
        elseif createErrorKind == "missing_thumbnail" then
            createError = var15.missingThumbnailError
        else
            createError = var15.internalError
        end
    end

    local onClose = React.useCallback(function()
        if isCreatePending then
            return
        end
        tbl2.onClose()
    end, { tbl2.onClose, isCreatePending })

    local onCreate = React.useCallback(function(arg1)
        tbl2.onCreate(arg1)
        if not bool1 then
            onClose()
        end
    end, { tbl2.onCreate, onClose, bool1 })
    local onAdvertisingTerms = React.useCallback(function(str1: string)
        var4(CreateAdCampaignSheetConfig.ADVERTISING_TERMS_URL, str1)
    end, { var4 })
    local onAdvertisingStandards = React.useCallback(function(str1: string)
        var4(CreateAdCampaignSheetConfig.ADVERTISING_STANDARDS_URL, str1)
    end, { var4 })

    local var20

    if FFlagEnablePaidAds then
        local var21 = React.useCallback(function()
            creatorCreditStore.refreshQuotaSummary():catch(function() end)
        end, { creatorCreditStore })

        local func1 = useTwoOptionsControls
        local isOpen = tbl2.isOpen

        local attemptedOption = tbl2.attemptedOption
        local adsManager = var15.adsManager
        local universeId = if FFlagBuildAdsManagerUniverseUrl then tbl2.universeId else nil
        var20 = func1(isOpen, onClose, onCreate, var6, isCreatePending, hasCreateError, var21, attemptedOption, adsManager, universeId)
    else
        var20 = nil
    end

    local var21, str1

    if var2 ~= nil then
        var21 = formatNumber(var2.robuxBalance)
        str1 = "ready"
    elseif var3 == DataStatus.Failed then
        var21 = CreateAdCampaignSheetConfig.BALANCE_UNAVAILABLE
        str1 = "failed"
    else
        var21 = CreateAdCampaignSheetConfig.BALANCE_LOADING
        str1 = "loading"
    end

    if var5 then
        return {
            variant = "twoOptions",
            isOpen = tbl2.isOpen,
            sheetRootRef = var20.sheetRootRef,
            title = var15.title,
            description = var15.introduction,
            startCampaignTitle = var15.startCampaignTitle,
            selectedOption = var20.selectedOption,
            defaultOptionRef = var20.defaultOptionRef,
            feedbackOption = if feedback == nil then nil else toCampaignOption(feedback, var15.feedbackOptionTitle, var15.feedbackRunDates, var15.feedbackDescription, var15.free),
            playsOption = if plays == nil then nil else toCampaignOption(plays, var15.playsOptionTitle, var15.playsRunDates, var15.playsDescription, var15.free),
            legalText = var15.legal,
            createText = if var20.shouldBuyRobux then var15.buyRobux else var15.create,
            moderationNotice = var15.moderationNotice,
            isCreatePending = isCreatePending,
            isFundingCheckPending = var20.isFundingCheckPending,
            isCreateDisabled = var20.isPrimaryActionDisabled,
            showAdCreditsCallout = var20.showAdCreditsCallout,
            adCreditsTitle = var15.adCreditsTitle,
            adCreditsAction = var15.adCreditsAction,
            hasCreateError = var20.isErrorForSelectedOption,
            createErrorText = createError,
            balanceState = str1,
            balanceText = var21,
            showCloseButton = var20.showCloseButton,
            onOptionChanged = var20.onOptionChanged,
            onOpenBuyRobux = var20.onOpenBuyRobux,
            onOpenAdsManager = var20.onOpenAdsManager,
            onClose = onClose,
            onCreate = var20.onCreate,
            onAdvertisingTerms = onAdvertisingTerms,
            onAdvertisingStandards = onAdvertisingStandards
        }
    end

    return {
        variant = "freeOptionOnly",
        isOpen = tbl2.isOpen,
        title = var15.title,
        description = var15.description,
        campaignTitle = var15.campaignTitle,
        estimatedPriceText = formatNumber(var8),
        freeText = var15.free,
        earnedRobuxDisclaimer = var15.earnedRobuxDisclaimer,
        includedTitle = var15.includedTitle,
        benefits = {
            {
                icon = IconName.Calendar,
                text = var15.runDates
            },
            {
                icon = IconName.CirclePlay,
                text = var15.maximizePlays
            },
            {
                icon = IconName.ThreePeople,
                text = var15.targetPlayers
            },
            {
                icon = IconName.ChartScatterPlot,
                text = var15.performanceReport
            }
        },
        legalText = var15.legal,
        createText = var15.create,
        moderationNotice = var15.moderationNotice,
        balanceState = str1,
        balanceText = var21,
        isCreatePending = isCreatePending,
        hasCreateError = hasCreateError,
        createErrorText = createError,
        onClose = onClose,
        onCreate = onCreate,
        onAdvertisingTerms = onAdvertisingTerms,
        onAdvertisingStandards = onAdvertisingStandards
    }
end

return useCreateAdCampaignSheetViewModel
