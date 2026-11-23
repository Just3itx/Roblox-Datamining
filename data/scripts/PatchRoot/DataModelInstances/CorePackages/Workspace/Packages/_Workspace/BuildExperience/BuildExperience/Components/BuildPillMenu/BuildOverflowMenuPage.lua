-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FFlagBuildExperienceConfigurationRowTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceConfigurationRowTelemetry)

local GameConfigurationContent = require(BuildExperience.Components.GameConfigurations.GameConfigurationContent.GameConfigurationContent)

local PublishConfigurationContentContainer = require(BuildExperience.Components.PublishConfigurationContent.PublishConfigurationContentContainer)
local OverflowMenuPageShell = require(script.Parent.OverflowMenuPageShell)
local PublishFooter = require(BuildExperience.Components.GameConfigurations.PublishFooter.PublishFooter)
local PublishLatestPreviewCard = require(BuildExperience.Components.GameConfigurations.PublishPreviewCard.PublishLatestPreviewCard)
local PublishPreviewCard = require(BuildExperience.Components.GameConfigurations.PublishPreviewCard.PublishPreviewCard)
local PublishStatus = require(BuildExperience.Chat.PublishStatus)

local View = Foundation.View

local tbl1 = { publish = "LuaApp_Build_Publish_Scroll", settings = "LuaApp_Build_Settings_Scroll" }

local function getPublishPreview(isPublishLatest: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return if isPublishLatest then PublishLatestPreviewCard else PublishPreviewCard
end

local function PublishPreview(tbl2)
    local var1 = useLocalization({ loading = LocalizationStrings.BUILD_MENU_LOADING })

    local publishPreview = getPublishPreview(PublishStatus.usePublishStatus(tbl2.target).isPublishLatest)
    local target = tbl2.target

    return React.createElement(publishPreview, {
        target = {
            universeId = target.universeId,
            placeId = target.placeId,
            experienceName = target.experienceName or var1.loading,
            creatorName = target.creatorName,
            gameIcon = target.gameIcon
        },
        isCreatorVerified = target.isCreatorVerified,
        layoutOrder = 1
    })
end

local function BuildOverflowMenuPageComponent(tbl2)
    local var1 = useLocalization({
        loading = LocalizationStrings.BUILD_MENU_LOADING,
        publish = LocalizationStrings.BUILD_MENU_PUBLISH,
        settings = LocalizationStrings.BUILD_MENU_SETTINGS
    })
    local testId = tbl2.testId or `BuildOverflowMenuPage.{tbl2.page}`
    local experienceName = tbl2.target.experienceName or var1.loading
    local leadingContent = if tbl2.page == "publish" then React.createElement(PublishPreview, { target = tbl2.target }) else nil
    local element2

    if tbl2.page == "publish" then
        element2 = React.createElement(PublishConfigurationContentContainer, {
            universeId = tbl2.target.universeId,
            placeId = if FFlagBuildExperienceConfigurationRowTelemetry then tbl2.target.placeId else nil,
            sessionId = if FFlagBuildExperienceConfigurationRowTelemetry then tbl2.target.sessionId else nil,
            onOpenTitleDescriptionPage = tbl2.onOpenTitleDescriptionPage,
            onOpenMediaSelectionPage = tbl2.onOpenMediaSelectionPage,
            onOpenVersionTitleDescriptionPage = tbl2.onOpenVersionTitleDescriptionPage,
            onOpenVersionHistory = tbl2.onOpenVersionHistory,
            isNewGame = if FFlagBuildCheckGamePermissions then tbl2.target.isNewGameTarget else nil,
            layoutOrder = 2
        })
    else
        element2 = React.createElement(GameConfigurationContent, {
            universeId = tbl2.target.universeId,
            placeId = tbl2.target.placeId,
            sessionId = if FFlagBuildExperienceConfigurationRowTelemetry then tbl2.target.sessionId else nil,
            experienceName = experienceName,
            onOpenAudiencePage = tbl2.onOpenAudiencePage,
            onOpenTitleDescriptionPage = tbl2.onOpenTitleDescriptionPage,
            onOpenMediaSelectionPage = tbl2.onOpenMediaSelectionPage,
            onOpenMonetizationPage = if FFlagBuildExperienceMonetizationNativeUI then tbl2.onOpenMonetizationPage else nil,
            onOpenPlaytestPicker = tbl2.onOpenPlaytestPicker,
            onOpenPlaytestManagement = tbl2.onOpenPlaytestManagement,
            isNewGame = if FFlagBuildCheckGamePermissions then tbl2.target.isNewGameTarget else nil
        })
    end

    if leadingContent then
        element2 = React.createElement(
            View,
            { tag = "col gap-large size-full-0 auto-y" },
            { LeadingContent = leadingContent, GameConfigurationContent = element2 }
        )
    end

    local createElement = React.createElement
    local var4 = OverflowMenuPageShell
    local tbl3 = {
        title = if tbl2.page == "publish" then var1.publish else var1.settings,
        testId = testId,
        onClose = tbl2.onClose,
        content = element2,
        scrollPerformanceIntervalName = tbl1[tbl2.page],
        footer = 0
    }
    local element3

    if tbl2.page == "publish" then
        element3 = React.createElement(PublishFooter, {
            target = {
                universeId = tbl2.target.universeId,
                placeId = tbl2.target.placeId,
                sessionId = tbl2.target.sessionId,
                isNewGameTarget = if FFlagBuildCheckGamePermissions then tbl2.target.isNewGameTarget else nil
            },
            testId = testId,
            showPreviewButton = tbl2.showPreviewButton
        })
    else
        element3 = nil
    end

    tbl3.footer = element3
    return createElement(var4, tbl3)
end

return BuildOverflowMenuPageComponent
