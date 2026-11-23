-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _MomentsTypes = require(AppChatParent.MomentsTypes)
local React = require(AppChatParent.React)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local AssetCardView = require(AppChat.Components.ChatConversation.AssetCardView.AssetCardView)
local _MessageGroupShape = require(AppChat.Components.ChatConversation.Grouping.MessageGroupShape)
local toMomentAssetCardProps = require(script.Parent.toMomentAssetCardProps)
local useMomentShareCardViewModel = require(script.Parent.useMomentShareCardViewModel)

local FFlagAppChatMomentShareCardHideMomentsGlyph = require(AppChat.Flags.FFlagAppChatMomentShareCardHideMomentsGlyph)

return React.memo(function(tbl1) -- name: MomentAssetCard
    local var1 = useMomentShareCardViewModel(
        {
            momentId = tbl1.momentId,
            targetIdType = tbl1.targetIdType,
            openMomentsDeepLink = tbl1.openMomentsDeepLink
        }
    )
    local var2 = useLocalization({
        errorText = "Feature.Chat.Label.ContentLoadingFailed",
        unavailableText = "Feature.Moments.Label.MomentUnavailableDefault"
    })

    return React.createElement(
        AssetCardView,
        toMomentAssetCardProps(var1, {
            groupShape = tbl1.groupShape,
            mediaRef = tbl1.mediaRef,
            errorText = var2.errorText,
            unavailableText = var2.unavailableText,
            showMomentsGlyph = not FFlagAppChatMomentShareCardHideMomentsGlyph
        })
    )
end)
