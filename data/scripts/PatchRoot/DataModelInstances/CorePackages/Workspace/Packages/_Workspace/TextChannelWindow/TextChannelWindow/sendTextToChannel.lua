-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindow = script:FindFirstAncestor("TextChannelWindow")
local TextChannelWindowParent = TextChannelWindow.Parent
local TextChannelWindowAnalytics = require(TextChannelWindow.TextChannelWindowAnalytics)
local Logger = require(TextChannelWindow.Logger)
local getFFlagExpChatProtectedChatInternalAPIs = require(TextChannelWindowParent.SharedFlags).getFFlagExpChatProtectedChatInternalAPIs

local function sendTextToChannel(textChannel, str1: string): boolean
    local success, result = pcall(function()
        if getFFlagExpChatProtectedChatInternalAPIs() then
            textChannel:SendInternalAsync(str1)
            return
        end
        textChannel:SendAsync(str1)
    end)

    if not success then
        Logger:warning("SendAsync failed: {}", result)
    end
    TextChannelWindowAnalytics.emit(TextChannelWindowAnalytics.Counters.Send, {
        result = if success then "success" else "failure",
        has_target = true,
        target_text_channel_category = TextChannelWindowAnalytics.getChannelCategory(textChannel.Name)
    })
    return success
end

return sendTextToChannel
