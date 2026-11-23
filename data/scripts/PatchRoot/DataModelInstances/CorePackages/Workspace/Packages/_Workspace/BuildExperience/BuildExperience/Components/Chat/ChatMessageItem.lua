-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local chatTypes = require(BuildExperience.Chat.chatTypes)
local adCampaignEligibilityTool = require(BuildExperience.Chat.adCampaignEligibilityTool)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)

local ChatTurnBlock = require(script.Parent.ChatTurnBlock)
local ChatUserMessage = require(script.Parent.ChatUserMessage)

local function areUserImagesEqual(images, images2)
    local tbl1 = images or {}
    local tbl2 = images2 or {}
    if #tbl1 ~= #tbl2 then
        return false
    end
    for value, value2 in tbl1 do
        local var1 = tbl2[value]
        if var1 == nil or value2.capture ~= var1.capture or value2.uri ~= var1.uri then
            return false
        end
    end
    return true
end

local function areResourceAttachmentsEqual(resourceAttachments, resourceAttachments2)
    local tbl1 = resourceAttachments or {}
    local tbl2 = resourceAttachments2 or {}
    if #tbl1 ~= #tbl2 then
        return false
    end
    for value, value2 in tbl1 do
        local var1 = tbl2[value]
        if var1 == nil
            or value2.type ~= var1.type
            or chatTypes.getResourceAttachmentUri(value2) ~= chatTypes.getResourceAttachmentUri(var1)
        then
            return false
        end
        if value2.type == "resource_link" and var1.type == "resource_link" and value2.name ~= var1.name then
            return false
        end
    end

    return true
end

local function hasCampaignCard(message)
    if message.turnState ~= nil and message.turnState.toolCalls ~= nil then
        for _, toolCall in message.turnState.toolCalls do
            if adCampaignEligibilityTool.isCompletedEligibilityToolCall(toolCall) then
                return true
            end
        end
    end
    return false
end

return React.memo(function(tbl1) -- name: ChatMessageItem
    local message = tbl1.message
    if message.kind == "user_message" then
        return React.createElement(ChatUserMessage, { message = message, LayoutOrder = tbl1.LayoutOrder })
    end

    return React.createElement(ChatTurnBlock, {
        turn = message,
        LayoutOrder = tbl1.LayoutOrder,
        clockBinding = tbl1.clockBinding,
        localToolActions = tbl1.localToolActions,
        onPlaytest = tbl1.onPlaytest,
        onPublish = tbl1.onPublish,
        isPlaytestLoading = tbl1.isPlaytestLoading,
        onAgentAdCampaignOfferSelected = if FFlagBuildAgentAdCampaignCard then tbl1.onAgentAdCampaignOfferSelected else nil,
        isPageVisible = tbl1.isPageVisible,
        scrollingFrameRef = tbl1.scrollingFrameRef,
        isAgentAdCampaignCreateDisabled = tbl1.isAgentAdCampaignCreateDisabled,
        getAgentAdCampaignCardState = if FFlagBuildAgentAdCampaignCard then tbl1.getAgentAdCampaignCardState else nil,
        onAgentAdCampaignActive = if FFlagBuildAgentAdCampaignCard then tbl1.onAgentAdCampaignActive else nil
    })
end, function(tbl1, tbl2) -- name: arePropsEqual
    local message = tbl1.message
    local message2 = tbl2.message
    if message.id == nil or message.id ~= message2.id then
        return false
    end
    if message.kind ~= message2.kind then
        return false
    end
    if tbl1.LayoutOrder ~= tbl2.LayoutOrder then
        return false
    end
    if message2.kind == "user_message" then
        return message.text == message2.text
            and areUserImagesEqual(message.images, message2.images)
            and areResourceAttachmentsEqual(message.resourceAttachments, message2.resourceAttachments)
    end

    if tbl1.isPlaytestLoading ~= tbl2.isPlaytestLoading then
        return false
    end

    if FFlagBuildAgentAdCampaignCard
        and (hasCampaignCard(message) or hasCampaignCard(message2))
        and (tbl1.onAgentAdCampaignOfferSelected ~= tbl2.onAgentAdCampaignOfferSelected
            or tbl1.getAgentAdCampaignCardState ~= tbl2.getAgentAdCampaignCardState
            or tbl1.onAgentAdCampaignActive ~= tbl2.onAgentAdCampaignActive
            or tbl1.isPageVisible ~= tbl2.isPageVisible
            or tbl1.scrollingFrameRef ~= tbl2.scrollingFrameRef
            or tbl1.isAgentAdCampaignCreateDisabled ~= tbl2.isAgentAdCampaignCreateDisabled)
    then
        return false
    end

    if message.isLatestPublishTurn ~= message2.isLatestPublishTurn then
        return false
    end
    local bool1 = message.isDone == true
    local bool2 = message2.isDone == true
    return bool1 and bool2
end)
