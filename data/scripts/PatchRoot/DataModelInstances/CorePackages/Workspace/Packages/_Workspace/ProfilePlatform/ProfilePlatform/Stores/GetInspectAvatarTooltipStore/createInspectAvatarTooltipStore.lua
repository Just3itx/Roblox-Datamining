-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local Signals = require(ProfilePlatformParent.Signals)

local InspectAvatarTooltipImpressionCache = require(script.Parent.InspectAvatarTooltipImpressionCache)

local num1 = game:DefineFastInt("ProfilePlatformInspectAvatarTooltipMaxImpressions", 3)

local function createInspectAvatarTooltipStore()
    local getIsOpen, var2 = Signals.createSignal(false)

    return {
        getIsOpen = getIsOpen,
        tryShow = function()
            local value = InspectAvatarTooltipImpressionCache.getValue()
            if value < 0 or num1 <= value then
                var2(false)
                return
            end

            InspectAvatarTooltipImpressionCache.incrementValue()
            var2(true)
        end,
        hide = function()
            var2(false)
        end,
        permanentlyDismiss = function()
            InspectAvatarTooltipImpressionCache.dismissValue()
            var2(false)
        end
    }
end
return createInspectAvatarTooltipStore
