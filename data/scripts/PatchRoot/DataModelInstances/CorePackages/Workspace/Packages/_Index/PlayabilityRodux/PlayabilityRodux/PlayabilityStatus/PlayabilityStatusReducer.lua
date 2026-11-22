-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayabilityRodux = script:FindFirstAncestor("PlayabilityRodux")
local PlayabilityRoduxParent = PlayabilityRodux.Parent

local Immutable = require(PlayabilityRoduxParent.AppCommonLib).Immutable
local SetPlayabilityStatus = require(PlayabilityRodux.PlayabilityStatus.SetPlayabilityStatus)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == SetPlayabilityStatus.name then
        arg1 = Immutable.JoinDictionaries(arg1, arg2.playabilityStatus)
    end

    return arg1
end
