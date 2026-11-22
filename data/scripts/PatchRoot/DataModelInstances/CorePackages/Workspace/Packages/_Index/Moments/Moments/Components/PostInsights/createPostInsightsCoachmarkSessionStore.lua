-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local function createPostInsightsCoachmarkSessionStore()
    local getIsHandled, var2 = Signals.createSignal(false)

    return {
        getIsHandled = getIsHandled,
        markHandled = function()
            var2(true)
        end,
        reset = function()
            var2(false)
        end
    }
end

return createPostInsightsCoachmarkSessionStore
