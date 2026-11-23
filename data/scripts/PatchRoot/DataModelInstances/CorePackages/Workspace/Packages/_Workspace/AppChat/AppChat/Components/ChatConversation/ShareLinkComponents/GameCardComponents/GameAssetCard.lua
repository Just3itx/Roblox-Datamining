-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local Localization = require(AppChatParent.Localization)

local AssetCardTypes = require(AppChat.Components.ChatConversation.AssetCardView.AssetCardTypes)
local AssetCardView = require(AppChat.Components.ChatConversation.AssetCardView.AssetCardView)
local _MessageGroupShape = require(AppChat.Components.ChatConversation.Grouping.MessageGroupShape)

local IconName = Foundation.Enums.IconName
local Status = AssetCardTypes.Status
local useAbbreviatedNumberLocalization = Localization.Hooks.useAbbreviatedNumberLocalization
local useLocalization = Localization.Hooks.useLocalization

return React.memo(function(tbl1) -- name: GameAssetCard
    local playerCount = useAbbreviatedNumberLocalization(tbl1.gamePlayerCount)
    local var2 = useLocalization({ errorText = "Feature.Chat.Label.ContentLoadingFailed" })
    local status = if tbl1.isError then Status.Error elseif tbl1.isLoading then Status.Loading else Status.Ready
    local bool1 = not (tbl1.gameThumbnail == nil) and tbl1.gameThumbnail ~= ""
    local createElement = React.createElement
    local var4 = AssetCardView
    local tbl2 = {
        status = status,
        errorText = var2.errorText,
        groupShape = tbl1.groupShape,
        mediaRef = tbl1.mediaRef,
        LayoutOrder = tbl1.LayoutOrder,
        media = {
            image = if bool1 then Content.fromUri(tbl1.gameThumbnail) else nil,
            aspectRatio = 16 / 9,
            onActivated = tbl1.onThumbnailActivated,
            isSelectable = tbl1.onThumbnailActivated ~= nil
        },
        footer = 0
    }
    local footer = {
        titleText = tbl1.gameName,
        isTitleLoading = tbl1.isLoading,
        gameStats = {
            rating = tbl1.gameRating,
            playerCount = playerCount
        },
        isGameStatsLoading = tbl1.isLoading,
        onActivated = tbl1.onMetadataActivated,
        action = if tbl1.onPlayButtonActivated then {
            icon = if tbl1.playButtonLabel then nil else IconName.PlayLarge,
            label = tbl1.playButtonLabel,
            variant = if tbl1.playButtonLabel then Foundation.Enums.ButtonVariant.SubEmphasis else nil,
            onActivated = tbl1.onPlayButtonActivated,
            isSelectable = true
        } else nil
    }
    tbl2.footer = footer
    return createElement(var4, tbl2)
end)
