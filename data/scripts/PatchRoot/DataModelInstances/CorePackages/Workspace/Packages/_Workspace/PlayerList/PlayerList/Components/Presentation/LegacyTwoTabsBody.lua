-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local Foundation = require(scriptParentParentParentParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local View = Foundation.View
local Theme = Foundation.Enums.Theme

local LocalizationService = game:GetService("LocalizationService")
local InExperienceLocales = require(scriptParentParentParentParent.InExperienceLocales)
local LocalizationProvider = require(scriptParentParentParentParent.Localization).LocalizationProvider

local useLegacyVisibilityMirror = require(scriptParentParentParent.Hooks.useLegacyVisibilityMirror)
local LeaderboardTabs = require(scriptParentParentParent.Components.Presentation.LeaderboardTabs)
local PlatformLeaderboardView = require(scriptParentParentParent.Components.Presentation.PlatformLeaderboardView)
local Constants = require(scriptParentParentParent.Common.Constants)
local FFlagPlayerListFixPlatformLeaderboardSizing = require(scriptParentParentParent.Flags.FFlagPlayerListFixPlatformLeaderboardSizing)
local FFlagPlayerListLocalizeGameText = require(scriptParentParentParent.Flags.FFlagPlayerListLocalizeGameText)
local FFlagPlayerListTwoTabsOnLegacyPerformance = require(scriptParentParentParent.Flags.FFlagPlayerListTwoTabsOnLegacyPerformance)
local FFlagPlatformLeaderboardsExposure3Enabled = require(scriptParentParentParent.Flags.FFlagPlatformLeaderboardsExposure3Enabled)

return React.memo(function(tbl1) -- name: LegacyTwoTabsBody
    local activeTabId, onActivated = React.useState("server")

    local localization = if FFlagPlayerListLocalizeGameText then React.useMemo(function()
        return InExperienceLocales.Localization.new(LocalizationService.RobloxLocaleId)
    end, {}) else nil

    local onPlatformTabsUnavailable = React.useCallback(function()
        onActivated("server")
    end, {})

    local isVisible

    if FFlagPlayerListTwoTabsOnLegacyPerformance then
        isVisible = tbl1.isVisible
    else
        local var5 = useLegacyVisibilityMirror(tbl1.isVisible)
        isVisible = SignalsReact.useSignalState(var5)
    end
    local bool1 = activeTabId == "server" or not isVisible
    local bool2 = tbl1.platformBodyHeight == nil
    local var5

    if bool1 then
        if bool2 then
            var5 = React.createElement("Frame", {
                Name = "LegacyTwoTabsServerBody",
                LayoutOrder = 3,
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }, {
                ServerBody = tbl1.serverBody
            })
        else
            var5 = tbl1.serverBody
        end
    else
        local tab = if activeTabId == "friends" then "Friends" else "Global"
        local platformBodyHeight = tbl1.platformBodyHeight
        if FFlagPlayerListFixPlatformLeaderboardSizing and platformBodyHeight ~= nil then
            platformBodyHeight = math.max(platformBodyHeight, Constants.PLATFORM_BODY_MIN_HEIGHT)
        end

        local uDim2 = if platformBodyHeight then UDim2.new(1, 0, 0, platformBodyHeight) else UDim2.new(1, 0, 1, 0)
        var5 = React.createElement("Frame", {
            Name = "LegacyTwoTabsPlatformBody",
            LayoutOrder = 3,
            Size = uDim2,
            BackgroundColor3 = tbl1.backgroundColor,
            BackgroundTransparency = tbl1.backgroundTransparency,
            BorderSizePixel = 0,
            ClipsDescendants = true
        }, {
            FlexRoot = React.createElement(View, {
                Size = UDim2.fromScale(1, 1),
                tag = "col"
            }, {
                PlatformLeaderboardView = React.createElement(PlatformLeaderboardView, {
                    tab = tab,
                    layoutOrder = 1,
                    legacyPanelBackgroundColor = tbl1.backgroundColor,
                    legacyPanelBackgroundTransparency = tbl1.backgroundTransparency
                })
            })
        })
    end

    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        Size = if bool2 then UDim2.fromScale(1, 1) else UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1
    }

    if not bool2 then
        tbl2.AutomaticSize = Enum.AutomaticSize.Y
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        }),
        TabsRow = 0,
        TitleBar = 0,
        Body = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Name = "LegacyTwoTabsTabsRow",
        LayoutOrder = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = tbl1.backgroundColor,
        BackgroundTransparency = tbl1.backgroundTransparency,
        BorderSizePixel = 0
    }
    local tbl5 = {
        LeaderboardTabs = React.createElement(LeaderboardTabs, {
            activeTabId = activeTabId,
            onActivated = onActivated,
            onPlatformTabsUnavailable = onPlatformTabsUnavailable,
            isVisible = if FFlagPlatformLeaderboardsExposure3Enabled then tbl1.isVisible else nil
        })
    }
    tbl3.TabsRow = createElement2(str2, tbl4, tbl5)

    tbl3.TitleBar = if bool1 then tbl1.titleBar else nil
    tbl3.Body = var5
    local element = createElement(str1, tbl2, tbl3)

    if FFlagPlayerListLocalizeGameText then
        element = React.createElement(LocalizationProvider, { localization = localization }, { Column = element })
    end

    return React.createElement(FoundationProvider, { theme = Theme.Dark }, { Column = element })
end)
