-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local useSelector = require(AvatarExperienceInspectAndBuyParent.RoactUtils).Hooks.RoactRodux.useSelector
local tutils = require(AvatarExperienceInspectAndBuyParent.tutils)

return function(arg1)
    return (useSelector(function(arg2)
        if arg1 then
            return arg2.creatingExperiences[tostring(arg1)]
        end

        return nil
    end, tutils.deepEqual))
end
