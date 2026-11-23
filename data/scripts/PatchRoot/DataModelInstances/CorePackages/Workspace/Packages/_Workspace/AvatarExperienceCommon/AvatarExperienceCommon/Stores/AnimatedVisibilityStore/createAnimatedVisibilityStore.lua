-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local Signals = require(AvatarExperienceCommonParent.Signals)
local Otter = require(AvatarExperienceCommonParent.Otter)

local tbl1 = {
    dampingRatio = 1,
    frequency = 3,
    restingVelocityLimit = 0.1,
    restingPositionLimit = 0.1
}

local function createAnimatedVisibilityStore(num1: number?)
    local num2 = num1 or 1

    local getVisibilityRatio, var2 = Signals.createSignal(num2)

    local getIsAnimating, var4 = Signals.createSignal(false)

    local getIsVisible, var6 = Signals.createSignal(num2 > 0.5)

    local singleMotor = Otter.createSingleMotor(num2)
    local tbl2 = tbl1

    singleMotor:onStep(function(arg1)
        var2(arg1)
    end)

    singleMotor:onComplete(function()
        var4(false)
    end)

    return {
        getVisibilityRatio = getVisibilityRatio,
        getIsVisible = getIsVisible,
        getIsAnimating = getIsAnimating,
        show = function()
            var6(true)
            var4(true)
            singleMotor:setGoal(Otter.spring(1, tbl2))
        end,
        hide = function()
            var6(false)
            var4(true)
            singleMotor:setGoal(Otter.spring(0, tbl2))
        end,
        destroy = function()
            singleMotor:destroy()
        end
    }
end
return createAnimatedVisibilityStore
