-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Signals = require(AvatarExperienceCommonParent.Signals)

local useStore = require(AvatarExperienceCommonParent.RoactUtils).Hooks.RoactRodux.useStore

local function func1(arg1, arg2): boolean
    return arg1 == arg2
end

local function useSelectorSignal<T>(func2: (...any) -> (...any), func3: ((...any) -> (...any))?)
    local var1 = useStore()
    local state = var1:getState()

    local var2, var3 = React.useMemo(function()
        return Signals.createSignal(state)
    end, {})

    React.useEffect(function()
        local state2 = var1:getState()
        var3(state2)
        local connection = var1.changed:connect(var3)
        return function()
            connection:disconnect()
        end
    end, { var1 })

    return React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return func2(var2(arg1))
        end, func3 or func1)
    end, { var2, func2, func3 })
end

return useSelectorSignal
