-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)
local Signals = require(MomentsParent.Signals)

local GetImmersiveChromeStore = require(Moments.Stores.GetImmersiveChromeStore)

local tbl1 = {
    dampingRatio = 1,
    frequency = 3,
    restingVelocityLimit = 0.1,
    restingPositionLimit = 0.1
}

local function useChromeRatio()
    local immersiveChromeStore = GetImmersiveChromeStore(false)
    local var1, var2 = ReactOtter.useAnimatedBinding(1)

    React.useEffect(function()
        return (Signals.createEffect(function(arg1)
            local chromeVisible = immersiveChromeStore.getChromeVisible(arg1)
            var2((ReactOtter.spring(if chromeVisible then 1 else 0, tbl1)))
        end))
    end, { immersiveChromeStore })

    return var1
end

return useChromeRatio
