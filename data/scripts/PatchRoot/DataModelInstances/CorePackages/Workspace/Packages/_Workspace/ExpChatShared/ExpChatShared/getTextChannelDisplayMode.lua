-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local GetFFlagExpChatUseIsDefaultTextChannel = require(scriptParent.Flags.GetFFlagExpChatUseIsDefaultTextChannel)

local TextChatService = game:GetService("TextChatService")

local function getTextChannelDisplayMode()
    if not GetFFlagExpChatUseIsDefaultTextChannel() then
        return nil
    end

    local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
    return if chatWindowConfiguration == nil then nil else chatWindowConfiguration.TextChannelDisplayMode
end

return getTextChannelDisplayMode
