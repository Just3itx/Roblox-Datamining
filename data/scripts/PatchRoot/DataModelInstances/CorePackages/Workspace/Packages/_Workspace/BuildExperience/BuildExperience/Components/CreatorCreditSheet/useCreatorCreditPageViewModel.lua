-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local DataHydration = require(BuildExperienceParent.DataHydration)
local CreatorCredit = require(BuildExperienceParent.DataHydration.CreatorCredit)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local CreatorCreditConfig = require(BuildExperience.CreatorCreditConfig)
local _CreatorCreditPageView = require(script.Parent.CreatorCreditPageView)
local _DailyLimitBottomSheet = require(script.Parent.DailyLimitBottomSheet)
local getHoursUntilReset = require(script.Parent.getHoursUntilReset)
local useOpenBuyRobuxWebView = require(script.Parent.useOpenBuyRobuxWebView)
local useRefreshCreatorCreditOnUnhide = require(script.Parent.useRefreshCreatorCreditOnUnhide)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local GetBuildCreatorCreditRefreshStore = require(BuildExperience.Stores.GetBuildCreatorCreditRefreshStore)

local DataStatus = DataHydration.DataStatus

local function useCreatorCreditPageViewModel()
    local creatorCreditStore = CreatorCredit.getCreatorCreditStore(false)

    local var1 = React.useMemo(function()
        return creatorCreditStore.getQuotaSummary()
    end, { creatorCreditStore })
    local var2 = React.useMemo(function()
        return creatorCreditStore.getDailyLimit()
    end, { creatorCreditStore })
    local var3 = SignalsReact.useSignalState(var1.data)
    local var4 = SignalsReact.useSignalState(var2.data)
    local var5 = SignalsReact.useSignalState(var2.status)
    local var6 = var4 or (if var3 then var3.limitSettings else nil)
    local robuxAvailable = if var3 then var3.robuxBalance else 0
    local additionalUsed = if var3 then var3.robuxSpentToday else 0
    local additionalUsageEnabled = if var6 then var6.additionalUsageEnabled else false
    local dailyLimit = if var6 and var6.dailyLimitSet then var6.dailyLimit else nil
    local hasLimitConfigured = var6 ~= nil
    local bool2 = var5 == DataStatus.Ready and var4 ~= nil
    local isOpen, var10 = React.useState(false)
    local isSaving, var12 = React.useState(false)
    local var13, var14 = React.useState(false)
    local var15 = React.useRef(0)

    local var16 = React.useCallback(function()
        local var16 = var15
        var16.current += 1
        var12(true)
        var14(false)
        return var15.current
    end, {})
    local var17 = React.useCallback(function(current: number, bool3: boolean)
        if var15.current ~= current then
            return
        end
        var12(false)
        var14(bool3)
    end, {})

    local onToggleAdditional = React.useCallback(function(additionalUsageEnabled2: boolean)
        if not bool2 or isSaving or var6 == nil then
            return
        end
        local var18 = var16()
        creatorCreditStore.setDailyLimit(
            {
                additionalUsageEnabled = additionalUsageEnabled2,
                dailyLimitSet = var6.dailyLimitSet,
                dailyLimit = var6.dailyLimit
            }
        ):andThen(
            function()
                var17(var18, false)
            end
        ):catch(
            function()
                var17(var18, true)
            end
        )
    end, {
        var16,
        creatorCreditStore,
        var17,
        isSaving,
        var6,
        bool2
    })

    local onOpenLimitSheet = React.useCallback(function()
        if bool2 and not isSaving then
            var14(false)
            var10(true)
        end
    end, { isSaving, bool2 })
    local onConfirm = React.useCallback(function(dailyLimit2: number?)
        if not bool2 or isSaving or var6 == nil then
            return
        end
        local var20 = var16()
        creatorCreditStore.setDailyLimit({
            additionalUsageEnabled = var6.additionalUsageEnabled,
            dailyLimitSet = dailyLimit2 ~= nil,
            dailyLimit = dailyLimit2 or 0
        }):andThen(
            function()
                if var15.current == var20 then
                    var17(var20, false)
                    var10(false)
                end
            end
        ):catch(
            function()
                var17(var20, true)
            end
        )
    end, {
        var16,
        creatorCreditStore,
        var17,
        isSaving,
        var6,
        bool2
    })

    local onCancel = React.useCallback(function()
        var10(false)
    end, {})
    local var22 = React.useCallback(function()
        if FFlagBuildExperienceModelPicker then
            GetBuildCreatorCreditRefreshStore(false).refresh()
            return
        end
        creatorCreditStore.refreshQuotaSummary():catch(function() end)
    end, { creatorCreditStore })
    local onOpenBuyRobux = useOpenBuyRobuxWebView(var22)
    if FFlagBuildExperienceModelPicker then
        React.useEffect(function()
            return GetBuildCreatorCreditRefreshStore(false).acquire()
        end, {})
    else
        useRefreshCreatorCreditOnUnhide(var22)
    end

    return {
        pageProps = {
            dailyPctUsed = if var3 then var3.freeTrialPctUsed else 0,
            resetHours = if var3 then getHoursUntilReset(var3.nextResetEligibleTime) else nil,
            resetPeriod = if var3 then var3.freeTrialResetPeriod else nil,
            additionalEnabled = additionalUsageEnabled,
            dailyLimit = dailyLimit,
            hasLimitConfigured = hasLimitConfigured,
            additionalUsed = additionalUsed,
            robuxAvailable = robuxAvailable,
            settingsDisabled = not bool2 or isSaving,
            settingsError = var13 or var5 == DataStatus.Failed,
            showBuyRobux = not (var3 == nil or not (var3.freeTrialRemaining <= 0))
                and var3.robuxBalance < CreatorCreditConfig.FIntMinimumUsableRobuxBalance,
            onToggleAdditional = onToggleAdditional,
            onOpenLimitSheet = onOpenLimitSheet,
            onOpenBuyRobux = onOpenBuyRobux
        },
        limitSheetProps = {
            isOpen = isOpen,
            initialValue = dailyLimit,
            initialIsNoLimit = hasLimitConfigured and dailyLimit == nil,
            additionalUsed = additionalUsed,
            isSaving = isSaving,
            saveError = var13,
            onConfirm = onConfirm,
            onCancel = onCancel
        }
    }
end

return useCreatorCreditPageViewModel
