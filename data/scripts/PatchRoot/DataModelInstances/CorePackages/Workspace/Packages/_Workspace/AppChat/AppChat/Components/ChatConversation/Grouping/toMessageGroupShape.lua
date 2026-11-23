-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local MessageGroupShape = require(AppChat.Components.ChatConversation.Grouping.MessageGroupShape)

local function toMessageGroupShape(bool1: boolean?, bool2: boolean?, bool3: boolean?, bool4: boolean?)
    local position = if bool1 and bool2 or bool3 then MessageGroupShape.Position.Only elseif bool1 then MessageGroupShape.Position.First elseif bool2 then MessageGroupShape.Position.Last else MessageGroupShape.Position.Middle
    return {
        direction = if bool4 then MessageGroupShape.Direction.Incoming else MessageGroupShape.Direction.Outgoing,
        position = position
    }
end

return toMessageGroupShape
