-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)

local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local GetFFlagMomentsFeedStartExpanded = require(Moments.Flags.GetFFlagMomentsFeedStartExpanded)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local function createMomentsPreferencesStore()
    local getMinimized, var2 = createSignal(not GetFFlagMomentsFeedStartExpanded())
    local getFeedGlobalMute, var4 = createSignal(false)
    local getDebugModeEnabled, var6 = createSignal(false)
    local getIsTeleporting, var8 = createSignal(false)

    return {
        getMinimized = getMinimized,
        getMediaScaleType = createComputed(function(arg1): Enum.ScaleType
            return if getMinimized(arg1) then Enum.ScaleType.Fit else Enum.ScaleType.Crop
        end),
        toggleFeedScaleType = function()
            if FFlagEnableArgus then
                var2(not getMinimized(false))
            end
        end,
        getFeedGlobalMute = getFeedGlobalMute,
        toggleFeedGlobalMute = function()
            if FFlagEnableArgus then
                var4(not getFeedGlobalMute(false))
            end
        end,
        getDebugModeEnabled = getDebugModeEnabled,
        toggleFeedDebugMode = function()
            if FFlagEnableArgus then
                var6(not getDebugModeEnabled(false))
            end
        end,
        getIsTeleporting = getIsTeleporting,
        setTeleporting = function(bool1: boolean)
            var8(bool1)
        end
    }
end
return createMomentsPreferencesStore
