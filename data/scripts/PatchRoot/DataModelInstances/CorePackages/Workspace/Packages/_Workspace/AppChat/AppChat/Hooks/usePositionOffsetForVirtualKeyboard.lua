-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local useChatPlacementContext = ChatPlacementContext.useChatPlacementContext
local isPlacementInExperience = ChatPlacementContext.isPlacementInExperience

return function(_): number?
    local chatPlacement = useChatPlacementContext().chatPlacement
    return if isPlacementInExperience(chatPlacement) then 0 else nil
end
