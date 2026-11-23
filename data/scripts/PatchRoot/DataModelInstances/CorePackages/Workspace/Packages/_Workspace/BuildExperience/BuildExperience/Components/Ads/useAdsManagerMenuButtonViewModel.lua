-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local _AdCampaigns = require(BuildExperienceParent.DataHydration.AdCampaigns)
local _CampaignStats = require(BuildExperienceParent.DataHydration.CampaignStats)
local getAdsManagerUrl = require(script.Parent.getAdsManagerUrl)
local _AdsManagerMenuButtonView = require(script.Parent.AdsManagerMenuButtonView)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local useOpenWebViewWithResumeRefresh = require(BuildExperience.utils.useOpenWebViewWithResumeRefresh)
local useRefreshAdsData = require(script.Parent.useRefreshAdsData)

local FFlagBuildAdsManagerUniverseUrl = require(BuildExperience.Flags.FFlagBuildAdsManagerUniverseUrl)

local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local useScaledValue = Foundation.Hooks.useScaledValue

local num1 = game:DefineFastInt("BuildAdsManagerMenuWidth", 162)

local function useAdsManagerMenuButtonViewModel(tbl1)
    local isMenuOpen, var2 = React.useState(false)
    local menuWidth = useScaledValue(num1)
    local adsManager = useLocalization({ adsManager = LocalizationStrings.ADS_STATS_ADS_MANAGER }).adsManager
    local universeId = tbl1.universeId
    local var4 = useRefreshAdsData(
        universeId,
        {
            adCampaignsStore = tbl1.adCampaignsStore,
            campaignStatsStore = tbl1.campaignStatsStore
        }
    )
    local var5

    if FFlagBuildAdsManagerUniverseUrl then
        local adsManagerUrl = getAdsManagerUrl.getAdsManagerUrl(universeId)

        var5 = useOpenWebViewWithResumeRefresh(adsManagerUrl, adsManager, var4, tbl1.appLifecycleObserverService)
    else
        var5 = useOpenWebViewWithResumeRefresh(
            getAdsManagerUrl.getDefaultAdsManagerUrl(),
            adsManager,
            var4,
            tbl1.appLifecycleObserverService
        )
    end

    local var6 = React.useCallback(function()
        var2(false)
        var5()
    end, { var5 })

    local onItemActivated = React.useCallback(function(arg1)
        if arg1 == "ads-manager" then
            var6()
        end
    end, { var6 })

    local onToggleMenu = React.useCallback(function()
        var2(function(arg1): boolean
            return not arg1
        end)
    end, {})

    local onCloseMenu = React.useCallback(function()
        var2(false)
    end, {})

    local menuItems = React.useMemo(function()
        return {{
            id = "ads-manager",
            text = adsManager,
            trailing = {
                iconName = IconName.ArrowUpRightFromSquare
            }
        }}
    end, { adsManager })

    return {
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId or "AdsManagerMenuButton",
        buttonSize = InputSize.Large,
        isMenuOpen = isMenuOpen,
        menuSize = InputSize.Large,
        menuWidth = menuWidth,
        menuItems = menuItems,
        onToggleMenu = onToggleMenu,
        onCloseMenu = onCloseMenu,
        onItemActivated = onItemActivated
    }
end

return useAdsManagerMenuButtonViewModel
