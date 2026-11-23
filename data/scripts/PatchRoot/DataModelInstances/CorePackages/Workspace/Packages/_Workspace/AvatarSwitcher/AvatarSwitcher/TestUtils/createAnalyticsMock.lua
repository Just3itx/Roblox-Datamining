-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local jest = require(AvatarSwitcherParent.Dev.JestGlobals).jest

local function createAnalyticsMock()
    local addUnifiedEventLogging = jest.fn()

    return {
        addUnifiedEventLogging = addUnifiedEventLogging,
        sendAXCounterV2 = jest.fn(),
        useUnifiedEventListener = {
            useUnifiedEventListenerInExperience = jest.fn()
        },
        UnifiedEventLogEnums = {
            MarketplaceUnifiedAction = { UI_ELEMENT_CLICK = "UI_ELEMENT_CLICK" }
        }
    }, addUnifiedEventLogging
end

return createAnalyticsMock
