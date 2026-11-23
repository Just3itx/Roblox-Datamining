-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent

local useWearTimeSelectedOptionViewModel = require(script.Parent.useWearTimeSelectedOptionViewModel)
local WearTimeSelectedOptionView = require(script.Parent.WearTimeSelectedOptionView)

local _AvatarExperienceCommon = require(AvatarExperienceTimedOptionsParent.AvatarExperienceCommon)

local function WearTimeSelectedOptionContainer(tbl1)
    local var1 = useWearTimeSelectedOptionViewModel(tbl1)
    return WearTimeSelectedOptionView(var1)
end

return WearTimeSelectedOptionContainer
