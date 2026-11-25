-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local _Signals = require(ProfilePlatformParent.Signals)
local createSessionScopedSignal = require(ProfilePlatformParent.SignalsUtils).createSessionScopedSignal

local function createInspectAvatarSpinIntroStore()
    local getHasPlayedIntro, var2 = createSessionScopedSignal(false)
    local getHasDragged, var4 = createSessionScopedSignal(false)

    return {
        getHasPlayedIntro = getHasPlayedIntro,
        markIntroPlayed = function()
            var2(true)
        end,
        getHasDragged = getHasDragged,
        markDragged = function()
            var4(true)
        end,
        reset = function()
            var2(false)
            var4(false)
        end
    }
end
return createInspectAvatarSpinIntroStore
