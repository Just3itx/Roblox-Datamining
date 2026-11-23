-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local FIntAppChatScrollToLatestThresholdPercent = require(AppChat.Flags.FIntAppChatScrollToLatestThresholdPercent)

local function isScrolledAwayFromLatest(num1: number, num2: number, num3: number?): boolean
    return not (num2 <= 0) and num2 * math.max(0, num3 or FIntAppChatScrollToLatestThresholdPercent) / 100 < num1
end

return isScrolledAwayFromLatest
