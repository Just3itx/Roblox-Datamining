-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local CreatorCredit = require(BuildExperienceParent.DataHydration.CreatorCredit)
local NumberLocalization = require(BuildExperienceParent.Localization).NumberLocalization
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local _CreatorCreditBalanceChipView = require(script.Parent.CreatorCreditBalanceChipView)
local useOpenBuyRobuxWebView = require(script.Parent.Parent.useOpenBuyRobuxWebView)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local GetBuildCreatorCreditRefreshStore = require(BuildExperience.Stores.GetBuildCreatorCreditRefreshStore)

local function formatBalance(robuxBalance: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return NumberLocalization.localize(string.format("%.0f", math.floor(robuxBalance)), LocalizationService.RobloxLocaleId)
end

local function useCreatorCreditBalanceChipViewModel()
    local creatorCreditStore = CreatorCredit.getCreatorCreditStore(false)
    local var1 = React.useMemo(function()
        return creatorCreditStore.getQuotaSummary()
    end, { creatorCreditStore })
    local var2 = SignalsReact.useSignalState(var1.data)
    local var3 = React.useCallback(function()
        if FFlagBuildExperienceModelPicker then
            GetBuildCreatorCreditRefreshStore(false).refresh()
            return
        end
        creatorCreditStore.refreshQuotaSummary():catch(function() end)
    end, { creatorCreditStore })
    local onActivated = useOpenBuyRobuxWebView(var3)

    return {
        balanceText = if var2 == nil then nil else formatBalance(var2.robuxBalance),
        onActivated = onActivated
    }
end

return useCreatorCreditBalanceChipViewModel
