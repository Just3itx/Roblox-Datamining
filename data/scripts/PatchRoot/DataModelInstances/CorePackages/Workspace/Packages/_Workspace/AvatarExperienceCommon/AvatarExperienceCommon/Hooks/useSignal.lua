-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Signals = require(AvatarExperienceCommonParent.Signals)

local function useSignal(arg1, func1: ((...any) -> (...any))?)
    local var1, var2 = React.useMemo(function()
        return Signals.createSignal(arg1, func1)
    end, {})
    return var1, var2
end

return useSignal
