-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)

return {
    expressionKey = function(arg1)
        if arg1.kind == "preset" then
            return "preset:" .. arg1.presetId
        elseif arg1.kind == "emoji" then
            return "emoji:" .. arg1.emojiId
        elseif arg1.kind == "asset" then
            return "asset:" .. arg1.assetId
        end

        return "plain-text"
    end
}
