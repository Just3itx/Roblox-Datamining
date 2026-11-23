-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local EventNames = require(AppChat.Analytics.EventNames)
local useAnalytics = require(AppChat.Analytics.useAnalytics)
local useChatPlacementContext = ChatPlacementContext.useChatPlacementContext

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local UIBlox = require(AppChatParent.UIBlox)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useNavigation = require(AppChatParent.Navigation).useNavigation

local Images = UIBlox.App.ImageSet.Images
local IconName = Foundation.Enums.IconName
local DomLocators = require(AppChat.Utils.DomLocators)

local CustomConversationListEntry = require(script.Parent.CustomConversationListEntry)
local CustomConversationListRow = require(script.Parent.CustomConversationListRow.CustomConversationListRow)

local FFlagAppChatUseFoundationCustomConversationListRow = require(AppChat.Flags.FFlagAppChatUseFoundationCustomConversationListRow)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)

local EnumScreens = require(AppChat.EnumScreens)
local var1 = if game.PlaceId > 0 then tostring(game.PlaceId) else nil
local var2 = if game.GameId > 0 then tostring(game.GameId) else nil

function PartyQuickStartContainer(tbl1)
    local var3 = useAnalytics()
    local var4 = useChatPlacementContext()
    local var5 = useNavigation()
    local var6 = useLocalization(
        {
            titleText = "Feature.Squads.Label.StartParty",
            subTitleText = "Feature.Squads.Label.JoinExperiencesTogether"
        }
    )

    local onActivated = React.useCallback(function()
        local partyAttemptId = HttpService:GenerateGUID(false)
        var3.fireAnalyticsEvent(
            EventNames.ChatLandingPartyQuickStartButtonClicked,
            {
                clickLocation = var4.chatPlacement,
                partyAttemptId = partyAttemptId,
                placeId = var1,
                universeId = var2
            }
        )
        var5.navigate(EnumScreens.QuickStartSquadInviteFriends, { partyAttemptId = partyAttemptId })
    end, { var3, var5, var4.chatPlacement })

    local testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatLandingConversationListHeader("startParty") else nil

    if FFlagAppChatUseFoundationCustomConversationListRow then
        return React.createElement(CustomConversationListRow, {
            entryHeight = tbl1.entryHeight,
            entryIcon = IconName.PersonPlay,
            onActivated = onActivated,
            titleText = var6.titleText,
            subTitleText = var6.subTitleText,
            testId = testId
        })
    end

    return React.createElement(CustomConversationListEntry, {
        entryHeight = tbl1.entryHeight,
        entryIcon = Images["icons/actions/friends/friendsplaying"],
        onActivated = onActivated,
        titleText = var6.titleText,
        subTitleText = var6.subTitleText,
        testId = testId
    })
end

return PartyQuickStartContainer
