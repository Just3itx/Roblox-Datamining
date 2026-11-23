-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local _React = require(AppChatParent.React)

local AssetCardTypes = require(AppChat.Components.ChatConversation.AssetCardView.AssetCardTypes)
local _MessageGroupShape = require(AppChat.Components.ChatConversation.Grouping.MessageGroupShape)
local MomentDetailsStatus = require(script.Parent.MomentDetailsStatus)
local _MomentShareCardView = require(script.Parent.MomentShareCardView)

local IconName = Foundation.Enums.IconName
local Status = AssetCardTypes.Status

local tbl1 = {
    [MomentDetailsStatus.Loading] = Status.Loading,
    [MomentDetailsStatus.Ready] = Status.Ready,
    [MomentDetailsStatus.Unavailable] = Status.Error,
    [MomentDetailsStatus.Locked] = Status.Error,
    [MomentDetailsStatus.Error] = Status.Error
}

local function toMomentAssetCardProps(arg1, tbl2)
    local status = tbl1[arg1.status] or Status.Loading

    return {
        status = status,
        errorText = if status ~= Status.Error then nil elseif arg1.status == MomentDetailsStatus.Error then tbl2.errorText else tbl2.unavailableText,
        groupShape = tbl2.groupShape,
        mediaRef = tbl2.mediaRef,
        media = {
            image = if arg1.hasMedia then arg1.posterContent else nil,
            aspectRatio = 1,
            isLoading = not arg1.isPosterLoaded,
            overlayIcon = if arg1.isVideo then IconName.PlayLarge else nil,
            onActivated = arg1.onActivated,
            isSelectable = arg1.selectable
        },
        footer = {
            titleText = arg1.username,
            isTitleLoading = arg1.isUsernameLoading,
            subtitleText = arg1.metadataText,
            subtitleIcon = if tbl2.showMomentsGlyph then IconName.Moments else nil,
            isSubtitleLoading = arg1.isMetadataLoading,
            onActivated = arg1.onActivated
        }
    }
end

return toMomentAssetCardProps
