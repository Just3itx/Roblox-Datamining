-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatIntegrationParent = script:FindFirstAncestor("ExpChatIntegration").Parent

local Signals = require(ExpChatIntegrationParent.Signals)

local _ChatPlatformTypes = require(script.Parent.ChatPlatformTypes)

local chatWindowSettings = {
    ChatWindowBackgroundColor3 = Color3.fromRGB(34, 34, 34),
    ChatWindowBackgroundTransparency = 0.3,
    ChatWindowMaxWidth = 600,
    ChatWindowMaxHeight = 400
}

local tbl2 = {
    getBackgroundColor = function(arg1)
        return arg1.BackgroundColor3
    end,
    getBackgroundTransparency = function(arg1)
        return arg1.BackgroundTransparency
    end
}

local getTransparencyStore = {
    setTextboxFocus = function() end,
    clearTextboxFocus = function() end
}

local function createDefaultChatPlatformValue()
    return {
        getChatInputBarSettings = Signals.createSignal({}),
        chatWindowSettings = chatWindowSettings,
        getInterpolators = Signals.createSignal(tbl2),
        getTransparencyStore = function(_: boolean)
            return getTransparencyStore
        end
    }
end

return createDefaultChatPlatformValue
