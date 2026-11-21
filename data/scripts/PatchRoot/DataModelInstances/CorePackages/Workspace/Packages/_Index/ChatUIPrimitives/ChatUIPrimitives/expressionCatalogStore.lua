-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
return require(ChatUIPrimitives.createExpressionCatalogStore)(function()
    local success, result = pcall(function()
        return TextChatService:GetPresetsAsync()
    end)
    return if success then result else nil
end)
