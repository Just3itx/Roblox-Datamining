-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local PublishConfigurationContentContainer = require(BuildExperience.Components.PublishConfigurationContent.PublishConfigurationContentContainer)
local PublishFooter = require(BuildExperience.Components.GameConfigurations.PublishFooter.PublishFooter)
local PublishLatestPreviewCard = require(BuildExperience.Components.GameConfigurations.PublishPreviewCard.PublishLatestPreviewCard)
local PublishPreviewCard = require(BuildExperience.Components.GameConfigurations.PublishPreviewCard.PublishPreviewCard)
local PublishStatus = require(BuildExperience.Chat.PublishStatus)
local useScrollPerformanceTracker = require(BuildExperience.Telemetry.useScrollPerformanceTracker)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FFlagBuildExperienceConfigurationRowTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceConfigurationRowTelemetry)

local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local function PublishPreview(tbl1)
    local loading = useLocalization({ loading = LocalizationStrings.BUILD_MENU_LOADING }).loading
    local var1 = if PublishStatus.usePublishStatus(tbl1.target).isPublishLatest then PublishLatestPreviewCard else PublishPreviewCard
    local target = tbl1.target

    return React.createElement(var1, {
        target = {
            universeId = target.universeId,
            placeId = target.placeId,
            experienceName = target.experienceName or loading,
            creatorName = target.creatorName,
            gameIcon = target.gameIcon
        },
        isCreatorVerified = target.isCreatorVerified,
        layoutOrder = 1
    })
end

local function PublishSheetContent(tbl1)
    useScrollPerformanceTracker("LuaApp_Build_PublishSheet_Scroll", tbl1.scrollingFrameRef)

    return React.createElement(Sheet.Content, { scrollingFrameRef = tbl1.scrollingFrameRef }, tbl1.children)
end

local function PublishBottomSheet(tbl1)
    local publish = useLocalization({ publish = LocalizationStrings.BUILD_MENU_PUBLISH }).publish
    local testId = tbl1.testId or "publish-bottom-sheet"
    local scrollingFrameRef = React.useRef(nil)

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        isOpen = tbl1.isOpen,
        snapPoints = { 0.75, 1 },
        defaultSnapPointIndex = 2,
        onClose = tbl1.onClose,
        testId = testId
    }
    local tbl3 = {
        Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = publish,
                tag = "shrink auto-xy text-heading-small text-wrap text-align-x-left content-emphasis"
            })
        }),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local func1 = PublishSheetContent
    local tbl4 = { scrollingFrameRef = scrollingFrameRef }
    local tbl5 = { Body = 0 }
    local createElement3 = React.createElement
    local var2 = View
    local tbl6 = { tag = "col gap-large size-full-0 auto-y" }

    local tbl7 = {
        Preview = React.createElement(PublishPreview, { target = tbl1.target }),
        Configuration = React.createElement(PublishConfigurationContentContainer, {
            universeId = tbl1.target.universeId,
            placeId = if FFlagBuildExperienceConfigurationRowTelemetry then tbl1.target.placeId else nil,
            sessionId = if FFlagBuildExperienceConfigurationRowTelemetry then tbl1.target.sessionId else nil,
            onOpenTitleDescriptionPage = tbl1.onOpenTitleDescriptionPage,
            onOpenMediaSelectionPage = tbl1.onOpenMediaSelectionPage,
            onOpenVersionTitleDescriptionPage = tbl1.onOpenVersionTitleDescriptionPage,
            onOpenVersionHistory = tbl1.onOpenVersionHistory,
            isNewGame = if FFlagBuildCheckGamePermissions then tbl1.target.isNewGameTarget else nil,
            layoutOrder = 2
        })
    }
    tbl5.Body = createElement3(var2, tbl6, tbl7)
    tbl3.Content = createElement2(func1, tbl4, tbl5)

    local createElement4 = React.createElement
    local actions = Sheet.Actions
    local var3 = nil
    local tbl8 = {
        Footer = React.createElement(PublishFooter, {
            target = {
                universeId = tbl1.target.universeId,
                placeId = tbl1.target.placeId,
                sessionId = tbl1.target.sessionId,
                isNewGameTarget = if FFlagBuildCheckGamePermissions then tbl1.target.isNewGameTarget else nil
            },
            testId = testId,
            showPreviewButton = tbl1.showPreviewButton,
            onPreview = tbl1.onClose
        })
    }
    tbl3.Actions = createElement4(actions, var3, tbl8)
    return createElement(root, tbl2, tbl3)
end

return PublishBottomSheet
