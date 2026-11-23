-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local UIBlox = require(AppChatParent.UIBlox)
local LuaAppNavigationContext = require(AppChat.LuaAppNavigationContext)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local ChatLanding = script:FindFirstAncestor("ChatLanding")
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local ChatLandingTelemetryEvents = require(ChatLanding.ChatLandingTelemetryEvents)

local getAppChatCommunitiesVisualConfig = require(AppChat.Utils.getAppChatCommunitiesVisualConfig)
local Images = UIBlox.App.ImageSet.Images
local IconName = Foundation.Enums.IconName
local DomLocators = require(AppChat.Utils.DomLocators)

local CustomConversationListEntry = require(script.Parent.CustomConversationListEntry)
local CustomConversationListRow = require(script.Parent.CustomConversationListRow.CustomConversationListRow)

local FFlagAppChatUseFoundationCustomConversationListRow = require(AppChat.Flags.FFlagAppChatUseFoundationCustomConversationListRow)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)

function ConversationGroupsEntryContainer(tbl1)
    local appChatCommunitiesVisualConfig = getAppChatCommunitiesVisualConfig()
    local var1 = useLocalization({
        groupsText = appChatCommunitiesVisualConfig.label,
        createAndExploreGroupsText = "Feature.SocialTab.Label.CreateAndExploreGroups"
    })

    local var2 = React.useContext(LuaAppNavigationContext)
    local var3 = useTelemetry(ChatLandingTelemetryLayer.Context)
    local entryIcon = Images[appChatCommunitiesVisualConfig.icon]
    local testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatLandingConversationListHeader("communities") else nil

    local onActivated = React.useCallback(function()
        var3.emit(ChatLandingTelemetryEvents.ChatLandingGroupsBtnClicked, {})

        var2.navigateToGroups()
    end, { var3, var2 })

    if FFlagAppChatUseFoundationCustomConversationListRow then
        return React.createElement(CustomConversationListRow, {
            entryHeight = tbl1.entryHeight,
            entryIcon = IconName.ThreePeople,
            key = "ConversationGroupsEntry",
            onActivated = onActivated,
            subTitleText = var1.createAndExploreGroupsText,
            titleText = var1.groupsText,
            testId = testId
        })
    end

    return React.createElement(CustomConversationListEntry, {
        entryHeight = tbl1.entryHeight,
        entryIcon = entryIcon,
        key = "ConversationGroupsEntry",
        onActivated = onActivated,
        subTitleText = var1.createAndExploreGroupsText,
        titleText = var1.groupsText,
        testId = testId
    })
end

return ConversationGroupsEntryContainer
