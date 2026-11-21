-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")

local _Types = require(ChatLineReporting.Common.Types)
local AnalyticsActions = require(ChatLineReporting.Common.Constants).AnalyticsActions
local function analyticsReducer(arg1, arg2)
    local var1 = table.clone(arg1)
    local type = arg2.type

    if type == AnalyticsActions.SetPlaceId then
        var1.place_id = arg2.place_id
        return var1
    end

    if type == AnalyticsActions.AccumulateForTimeSpent then
        var1.accumulated_time_ms = arg2.accumulated_time_ms
        return var1
    end

    if type == AnalyticsActions.SetReasonSelection then
        var1.reason_selection = arg2.reason_selection
        return var1
    end

    if type == AnalyticsActions.SetCommentAdded then
        var1.comment_added = arg2.comment_added
        return var1
    end

    if type == AnalyticsActions.SetChatLineSelected then
        var1.chat_line_selected = true
        var1.selected_chat_line_index = arg2.selected_chat_line_index
        return var1
    end

    if type == AnalyticsActions.SetChatHistoryInformation then
        var1.selectable_chat_history_size = arg2.selectable_chat_history_size
        var1.total_chat_history_size = arg2.total_chat_history_size
        var1.num_non_general_channel_chats = arg2.num_non_general_channel_chats
        return var1
    end

    if type == AnalyticsActions.SetViewportInformation then
        var1.viewport_size_x = arg2.viewport_size_x
        var1.viewport_size_y = arg2.viewport_size_y
        var1.is_portrait_mode = arg2.is_portrait_mode
    end

    return var1
end

return analyticsReducer
