-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorCredit = require(BuildExperienceParent.DataHydration.CreatorCredit)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local Localization = require(BuildExperienceParent.Localization)
local useLocalization = Localization.Hooks.useLocalization
local NumberLocalization = Localization.NumberLocalization

local CreatorCreditConfig = require(BuildExperience.CreatorCreditConfig)
local useOpenBuyRobuxWebView = require(BuildExperience.Components.CreatorCreditSheet.useOpenBuyRobuxWebView)

local useRefreshCreatorCreditOnUnhide = require(BuildExperience.Components.CreatorCreditSheet.useRefreshCreatorCreditOnUnhide)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagBuildExperienceFreeLimitCard = require(BuildExperience.Flags.FFlagBuildExperienceFreeLimitCard)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local GetBuildCreatorCreditRefreshStore = require(BuildExperience.Stores.GetBuildCreatorCreditRefreshStore)
local LocalUserIdStore = require(BuildExperienceParent.LocalUserIdStore).LocalUserIdStore

local function formatRobux(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return NumberLocalization.localize(string.format("%.0f", math.floor(num1)), LocalizationService.RobloxLocaleId)
end

local function getQuotaBlockReason(arg1)
    if arg1 == nil then
        return nil
    end

    if FFlagBuildExperienceModelPicker then
        if arg1.allowed == false then
            return arg1.reason
        end

        return nil
    end

    if arg1.allowed ~= nil then
        if arg1.allowed then
            return nil
        end

        return arg1.reason
    end

    if arg1.freeTrialRemaining > 0 then
        return nil
    end

    if not arg1.limitSettings.additionalUsageEnabled then
        return "FreeTrialExhausted"
    end

    if arg1.robuxBalance < CreatorCreditConfig.FIntMinimumUsableRobuxBalance then
        return "InsufficientRobuxBalance"
    end

    if arg1.limitSettings.dailyLimitSet and arg1.limitRemaining < CreatorCreditConfig.FIntMinimumUsableRobuxBalance then
        return "DailyLimitReached"
    end

    return nil
end

local function useCreatorCreditChatUpsellViewModel(tbl1)
    local creatorCreditStore = CreatorCredit.getCreatorCreditStore(false)
    local var1 = if FFlagBuildExperienceModelPicker then SignalsReact.useSignalState(LocalUserIdStore.getCurrentUserId) else nil
    local useMemo = React.useMemo

    local function func1()
        if not FFlagBuildExperienceModelPicker then
            return creatorCreditStore.getQuotaSummary()
        end

        return assert(creatorCreditStore.getTierQuotaSummary, "Model picker requires tier quotas")(
            "PRODUCT_BUILD",
            tbl1.namedTier or "default"
        )
    end

    local namedTier = if FFlagBuildExperienceModelPicker then tbl1.namedTier else nil
    local var2 = useMemo(func1, { creatorCreditStore, namedTier, var1 })
    local var3 = SignalsReact.useSignalState(var2.data)
    local nextResetEligibleTime = if var3 == nil then nil else var3.nextResetEligibleTime
    local var4 = nil
    if FFlagBuildExperienceModelPicker and var3 ~= nil and var3.blockDetails ~= nil then
        local requiredRobux = var3.blockDetails.requiredRobux
        if requiredRobux ~= nil and requiredRobux > 0 then
            var4 = requiredRobux
        end
    end

    local var5 = useLocalization
    local tbl2 = {
        adjustLimit = LocalizationStrings.CREATOR_CREDIT_ADJUST_LIMIT_BUTTON,
        buyMoreDescription = LocalizationStrings.CREATOR_CREDIT_BUY_MORE_ROBUX_DESCRIPTION,
        buyMoreTitle = LocalizationStrings.CREATOR_CREDIT_BUY_MORE_ROBUX_TITLE,
        buyRobux = LocalizationStrings.CREATOR_CREDIT_BUY_ROBUX_SHEET_CONFIRM,
        modelBuyRobux = if var4 == nil then nil else LocalizationStrings.CREATOR_CREDIT_BUY_ROBUX_BUTTON,
        insufficientTitle = if var4 == nil then nil else LocalizationStrings.CREATOR_CREDIT_INSUFFICIENT_ROBUX_TITLE,
        insufficientDescription = if var4 == nil then nil else {
            if tbl1.namedTier == "advanced" then LocalizationStrings.CREATOR_CREDIT_INSUFFICIENT_ROBUX_ADVANCED_AMOUNT_DESCRIPTION else LocalizationStrings.CREATOR_CREDIT_INSUFFICIENT_ROBUX_DEFAULT_AMOUNT_DESCRIPTION,
            ROBUX = formatRobux(var4)
        },
        dailyLimitDescription = LocalizationStrings.CREATOR_CREDIT_DAILY_LIMIT_REACHED_DESCRIPTION,
        dailyLimitTitle = LocalizationStrings.CREATOR_CREDIT_DAILY_LIMIT_REACHED_TITLE,
        freeTrialDescription = if FFlagBuildExperienceFreeLimitCard then LocalizationStrings.CREATOR_CREDIT_FREE_LIMIT_REACHED_DESCRIPTION else LocalizationStrings.CREATOR_CREDIT_FREE_TRIAL_EXHAUSTED_DESCRIPTION,
        freeTrialTitle = if FFlagBuildExperienceFreeLimitCard then LocalizationStrings.CREATOR_CREDIT_FREE_LIMIT_REACHED_TITLE else LocalizationStrings.CREATOR_CREDIT_FREE_TRIAL_EXHAUSTED_TITLE,
        freeTrialAction = if FFlagBuildExperienceFreeLimitCard then LocalizationStrings.CREATOR_CREDIT_MANAGE_USAGE_BUTTON else LocalizationStrings.CREATOR_CREDIT_VIEW_USAGE_BUTTON,
        notNow = LocalizationStrings.CREATOR_CREDIT_NOT_NOW_BUTTON,
        viewUsage = LocalizationStrings.CREATOR_CREDIT_VIEW_USAGE_BUTTON
    }
    local var6 = var5(tbl2)

    local var7, var8 = React.useState(false)
    local outOfCreditsPromptFailureCount = tbl1.outOfCreditsPromptFailureCount or 0
    local var9 = React.useRef(outOfCreditsPromptFailureCount)
    local var10 = React.useRef(0)

    local var11, var12 = React.useState(nil)
    local var13 = if FFlagBuildExperienceModelPicker then React.useRef(var3) else nil
    local useCallback = React.useCallback

    local function func2()
        local current = var10.current
        if FFlagBuildExperienceModelPicker then
            GetBuildCreatorCreditRefreshStore(false).refresh()
            return
        end
        creatorCreditStore.refreshQuotaSummary():andThen(function(arg1)
            if arg1 ~= nil and current == var10.current then
                var12((getQuotaBlockReason(arg1)))
            end
        end):catch(function() end)
    end

    local namedTier2 = if FFlagBuildExperienceModelPicker then tbl1.namedTier else nil
    local var14 = useCallback(func2, { creatorCreditStore, namedTier2 })
    if FFlagBuildExperienceModelPicker then
        React.useEffect(function()
            var12(nil)
            return function()
                local var15 = var10
                var15.current += 1
            end
        end, { var1, tbl1.namedTier })
    end
    local useEffect = React.useEffect
    local function func3()
        if outOfCreditsPromptFailureCount > var9.current then
            local var15 = var10
            var15.current += 1
            if var13 then
                var13.current = var2.data(false)
            end
            var12(tbl1.outOfCreditsPromptFailureReason)
            var8(false)
            var14()
        end
        var9.current = outOfCreditsPromptFailureCount
    end

    local outOfCreditsPromptFailureReason = tbl1.outOfCreditsPromptFailureReason
    local var15 = if FFlagBuildExperienceModelPicker then var2 else nil
    useEffect(func3, { outOfCreditsPromptFailureCount, outOfCreditsPromptFailureReason, var14, var15 })

    if FFlagBuildExperienceModelPicker then
        React.useEffect(function()
            if var13 and var3 ~= var13.current and var2.status(false) == "Ready" then
                var12(nil)
            end
        end, { var3, var2 })
    end

    local var16 = React.useRef(tbl1.isAssistantResponding)
    React.useEffect(function()
        if FFlagBuildExperienceModelPicker then
            return
        end
        local var17 = var16.current and not tbl1.isAssistantResponding
        var16.current = tbl1.isAssistantResponding
        if var17 then
            local var18 = task.delay(CreatorCreditConfig.FIntPostTurnRefreshDelaySeconds, var14)
            return function()
                task.cancel(var18)
            end
        end
    end, { tbl1.isAssistantResponding, var14 })

    React.useEffect(function()
        if FFlagBuildExperienceModelPicker or nextResetEligibleTime == nil or nextResetEligibleTime == "" then
            return
        end

        local dateTime = DateTime.fromIsoDate(nextResetEligibleTime)
        if dateTime == nil then
            return
        end

        local num1 = math.max(1, dateTime.UnixTimestamp - DateTime.now().UnixTimestamp + CreatorCreditConfig.FIntResetRefreshBufferSeconds)

        local var17 = task.delay(num1, var14)
        return function()
            task.cancel(var17)
        end
    end, { nextResetEligibleTime, var14 })

    local var17 = React.useCallback(function()
        var14()
        var8(true)
    end, { var14 })
    local var18 = useOpenBuyRobuxWebView(var17)
    if not FFlagBuildExperienceModelPicker then
        useRefreshCreatorCreditOnUnhide(var14)
    end

    local var19 = React.useCallback(function()
        var8(true)
        if tbl1.onOpenCreatorCreditPage then
            tbl1.onOpenCreatorCreditPage()
        end
    end, { tbl1.onOpenCreatorCreditPage })
    local var20 = React.useCallback(function()
        var8(true)
    end, {})

    local var21 = var11 or getQuotaBlockReason(var3)

    local buyMoreTitle = var6.buyMoreTitle
    local buyMoreDescription = var6.buyMoreDescription
    local buyRobux = var6.buyRobux
    local viewUsage = var6.viewUsage

    if var21 == "FreeTrialExhausted" then
        buyMoreTitle = var6.freeTrialTitle
        buyMoreDescription = var6.freeTrialDescription
        buyRobux = var6.freeTrialAction
        viewUsage = var6.notNow
    elseif var21 == "DailyLimitReached" then
        buyMoreTitle = var6.dailyLimitTitle
        buyMoreDescription = var6.dailyLimitDescription
        buyRobux = var6.adjustLimit
        viewUsage = var6.notNow
    elseif var21 == "InsufficientRobuxBalance" and var4 ~= nil then
        buyMoreTitle = var6.insufficientTitle
        buyMoreDescription = var6.insufficientDescription
        buyRobux = var6.modelBuyRobux
        viewUsage = var6.notNow
        var19 = var18
    else
        var20 = var19
        var19 = var18
    end

    return {
        showBuyMoreRobuxCard = not (var21 == nil) and not var7 and tbl1.onOpenCreatorCreditPage ~= nil,
        buyMoreRobuxCardTitle = buyMoreTitle,
        buyMoreRobuxCardDescription = buyMoreDescription,
        buyMoreRobuxCardPrimaryActionText = buyRobux,
        onBuyMoreRobuxCardPrimaryAction = var19,
        buyMoreRobuxCardSecondaryActionText = viewUsage,
        onBuyMoreRobuxCardSecondaryAction = var20
    }
end

return useCreatorCreditChatUpsellViewModel
