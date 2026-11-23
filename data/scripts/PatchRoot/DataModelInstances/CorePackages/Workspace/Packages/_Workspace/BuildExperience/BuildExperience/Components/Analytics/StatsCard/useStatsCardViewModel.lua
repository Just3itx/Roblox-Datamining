-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local _Foundation = require(BuildExperienceParent.Foundation)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local _StatsCardView = require(script.Parent.StatsCardView)
local _AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)
local _StatsCardValueFormat = require(script.Parent.StatsCardValueFormat)
local formatStatNumber = require(BuildExperience.Analytics.formatStatNumber)
local metricValueRoundsToZero = require(BuildExperience.Analytics.metricValueRoundsToZero)
local metricUnitTemplate = require(BuildExperience.Analytics.metricUnitTemplate)
local noDataPlaceholder = require(BuildExperience.Components.Analytics.noDataPlaceholder)

local templateFor = metricUnitTemplate.templateFor

local function useStatsCardViewModel(tbl1)
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local var1 = tbl1.hasData == nil or tbl1.hasData

    local var2 = formatStatNumber(tbl1.statValue, tbl1.statUnit, tbl1.statValueFormat, robloxLocaleId)
    local var3 = templateFor(tbl1.statUnit)

    local num1 = math.abs(tbl1.deltaValue)
    local bool1 = var1 and not (num1 == 0) and not metricValueRoundsToZero(num1, tbl1.deltaUnit, tbl1.deltaValueFormat, robloxLocaleId)
    local var4 = if bool1 then formatStatNumber(num1, tbl1.deltaUnit, tbl1.deltaValueFormat, robloxLocaleId) else nil
    local var5 = templateFor(tbl1.deltaUnit)

    local tbl2 = {}
    if var1 and var3 ~= nil then
        tbl2.statText = { var3, number = var2 }
    end
    if bool1 and var5 ~= nil then
        tbl2.deltaText = { var5, number = var4 }
    end
    local var6 = useLocalization(tbl2)

    if not var1 then
        var2 = noDataPlaceholder
    elseif var3 ~= nil then
        var2 = var6.statText
    end

    if bool1 then
        if var5 ~= nil then
            var4 = var6.deltaText
        end
    else
        var4 = nil
    end

    return {
        title = tbl1.title,
        statText = var2,
        statIcon = if var1 then tbl1.statIcon else nil,
        statIconPosition = tbl1.statIconPosition,
        deltaText = var4,
        deltaIcon = tbl1.deltaIcon,
        deltaIconPosition = tbl1.deltaIconPosition,
        isDeltaPositive = var1 and tbl1.deltaValue > 0,
        isLoading = tbl1.isLoading == true,
        isSelected = tbl1.isSelected,
        onActivated = tbl1.onActivated,
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    }
end

return useStatsCardViewModel
