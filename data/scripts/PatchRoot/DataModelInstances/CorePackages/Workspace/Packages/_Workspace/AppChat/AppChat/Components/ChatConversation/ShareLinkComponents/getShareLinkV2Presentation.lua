-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)

local ShareLinkClassification = require(AppChat.Components.ChatConversation.Utils.RobloxUrlUtils.ShareLinkClassification)
local ShareLinkV2Presentation = require(script.Parent.ShareLinkV2Presentation)
local isAssetCardClassification = require(script.Parent.isAssetCardClassification)
local FFlagAppChatMomentShareCard = require(AppChat.Flags.FFlagAppChatMomentShareCard)

local DataStatus = DataHydration.DataStatus

local function getShareLinkV2Presentation(arg1, notReady)
    if arg1 == nil then
        if notReady == DataStatus.NotReady then
            return ShareLinkV2Presentation.Loading
        end

        return ShareLinkV2Presentation.Fallback
    end

    if FFlagAppChatMomentShareCard and arg1.type == ShareLinkClassification.Moment then
        return ShareLinkV2Presentation.Card
    end

    if isAssetCardClassification(arg1) then
        return ShareLinkV2Presentation.Card
    end

    return ShareLinkV2Presentation.Fallback
end

return getShareLinkV2Presentation
