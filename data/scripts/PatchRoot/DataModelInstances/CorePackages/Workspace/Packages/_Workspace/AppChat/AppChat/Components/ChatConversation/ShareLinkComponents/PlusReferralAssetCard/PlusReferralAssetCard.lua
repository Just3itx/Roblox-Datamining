-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)

local AssetCardView = require(AppChat.Components.ChatConversation.AssetCardView.AssetCardView)
local usePlusReferralAssetCardViewModel = require(script.Parent.usePlusReferralAssetCardViewModel)

return React.memo(function(arg1) -- name: PlusReferralAssetCard
    local var1 = usePlusReferralAssetCardViewModel(arg1)
    return React.createElement(AssetCardView, var1)
end)
