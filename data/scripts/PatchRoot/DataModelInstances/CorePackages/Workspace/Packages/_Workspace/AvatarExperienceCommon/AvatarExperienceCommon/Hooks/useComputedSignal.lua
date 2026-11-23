-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Signals = require(AvatarExperienceCommonParent.Signals)

local function useComputedSignal(func1: (...any) -> (...any), func2: ((...any) -> (...any))?)
    return (React.useMemo(function()
        return Signals.createComputed(func1, func2)
    end, {}))
end

return useComputedSignal
