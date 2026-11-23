-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local chatConstants = require(BuildExperience.Chat.chatConstants)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)

local View = Foundation.View

local ChatHistoryLoadingState = require(script.Parent.ChatHistoryLoadingState)
local ChatMessageItem = require(script.Parent.ChatMessageItem)

local function ChatMessageList(tbl1)
    local result = {}

    if #tbl1.messages == 0 then
        local emptyState = tbl1.emptyState
        if tbl1.isHistoryLoading then
            emptyState = React.createElement(ChatHistoryLoadingState)
        end
        if emptyState ~= nil then
            result.EmptyState = React.createElement(
                View,
                {
                    LayoutOrder = 0,
                    Size = UDim2.fromScale(1, 1),
                    tag = "col align-x-center align-y-center padding-large"
                },
                emptyState
            )
        end

        return result
    end

    for value, message in tbl1.messages do
        local var1 = message.id or `Message{value}`
        result[var1] = React.createElement(ChatMessageItem, {
            message = message,
            LayoutOrder = value * chatConstants.MESSAGE_LAYOUT_ORDER_STRIDE,
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
    end

    return result
end

return ChatMessageList
