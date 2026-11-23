-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local Foundation = require(BuildExperienceParent.Foundation)
local NumberLocalization = require(BuildExperienceParent.Localization).NumberLocalization
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local getCreatorCreditStore = require(BuildExperienceParent.DataHydration.CreatorCredit).getCreatorCreditStore
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local IconName = Foundation.Enums.IconName

local function formatNumber(num1: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    return NumberLocalization.localize(string.format("%.0f", math.floor(num1)), LocalizationService.RobloxLocaleId)
end

return {
    useCreatorCreditMenuItem = function(tbl1)
        local onOpenCreatorCreditPage = if tbl1 == nil then nil else tbl1.onOpenCreatorCreditPage

        local activate = React.useCallback(function()
            if onOpenCreatorCreditPage then
                onOpenCreatorCreditPage()
            end
        end, { onOpenCreatorCreditPage })

        local creatorCreditStore = getCreatorCreditStore(false)
        local var2 = React.useMemo(function()
            return creatorCreditStore.getQuotaSummary()
        end, { creatorCreditStore })
        local var3 = SignalsReact.useSignalState(var2.data)
        local var4 = useLocalization
        local tbl2 = {
            menuItem = LocalizationStrings.CREATOR_CREDIT_MENU_ITEM,
            usage = 0
        }
        local tbl3

        if var3 == nil then
            tbl3 = nil
        elseif var3.freeTrialPctUsed < 100 or not var3.limitSettings.additionalUsageEnabled then
            tbl3 = {
                [1] = nil,
                LocalizationStrings.CREATOR_CREDIT_PERCENT_USED
            }
            local num1 = math.floor(var3.freeTrialPctUsed + 0.5)
            tbl3.PERCENT = math.clamp(num1, 0, 100)
        else
            tbl3 = var3.limitSettings.dailyLimitSet
                and {
                    LocalizationStrings.CREATOR_CREDIT_ROBUX_USAGE,
                    USED = formatNumber(var3.robuxSpentToday),
                    LIMIT = formatNumber(var3.limitSettings.dailyLimit)
                }
                or {
                    LocalizationStrings.CREATOR_CREDIT_USAGE_USED,
                    USED = formatNumber(var3.robuxSpentToday)
                }
        end

        tbl2.usage = tbl3
        local var5 = var4(tbl2)

        local menuItem = var5.menuItem

        return {
            item = React.useMemo(function()
                local tbl4 = if var3 == nil then nil else {
                    type = "Badge",
                    icon = if var3.freeTrialPctUsed >= 100 and var3.limitSettings.additionalUsageEnabled then IconName.Robux else nil,
                    text = var5.usage or ""
                }
                return { id = "creator-credit-ai-usage", text = menuItem, trailing = tbl4 }
            end, { var3, var5, menuItem }),
            activate = activate
        }
    end,
    ITEM_ID = "creator-credit-ai-usage"
}
