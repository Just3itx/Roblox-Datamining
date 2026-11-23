-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent
local Signals = require(AvatarExperienceCommonParent.Signals)

local _useSelectorSignal = require(AvatarExperienceCommon.Hooks.useSelectorSignal)

local function func1(arg1, arg2): boolean
    return arg1 == arg2
end

local function createSelectorSignal(arg1, arg2, arg3)
    local state = arg1:getState()
    local var1, var2 = Signals.createSignal(state)

    arg1.changed:connect(var2)

    return Signals.createComputed(function(arg4)
        return arg2(var1(arg4))
    end, arg3 or func1)
end

return createSelectorSignal
