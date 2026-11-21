-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatIntegrationParent = script:FindFirstAncestor("ExpChatIntegration").Parent

local Signals = require(ExpChatIntegrationParent.Signals)

local _ChatPlatformTypes = require(script.Parent.ChatPlatformTypes)
local createDefaultChatPlatformValue = require(script.Parent.createDefaultChatPlatformValue)

local function createMockChatPlatformValue(tbl1)
    local tbl2 = tbl1 or {}
    local defaultChatPlatformValue = createDefaultChatPlatformValue()

    local getChatInputBarSettings = defaultChatPlatformValue.getChatInputBarSettings
    if tbl2.chatInputBarSettings ~= nil then
        getChatInputBarSettings = Signals.createSignal(tbl2.chatInputBarSettings)
    end

    local getInterpolators = defaultChatPlatformValue.getInterpolators
    if tbl2.interpolators ~= nil then
        getInterpolators = Signals.createSignal(tbl2.interpolators)
    end

    local getTransparencyStore = defaultChatPlatformValue.getTransparencyStore
    local transparencyStore = tbl2.transparencyStore
    return {
        getChatInputBarSettings = getChatInputBarSettings,
        chatWindowSettings = tbl2.chatWindowSettings or defaultChatPlatformValue.chatWindowSettings,
        getInterpolators = getInterpolators,
        getTransparencyStore = transparencyStore ~= nil and function(_: boolean)
            return transparencyStore
        end or getTransparencyStore
    }
end

return createMockChatPlatformValue
