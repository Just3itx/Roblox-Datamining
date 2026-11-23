-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent

local useWearTimeSelectedOptionViewModel = require(script.Parent.useWearTimeSelectedOptionViewModel)
local WearTimeSelectedOptionInListView = require(script.Parent.WearTimeSelectedOptionInListView)

local _AvatarExperienceCommon = require(AvatarExperienceTimedOptionsParent.AvatarExperienceCommon)

local function WearTimeSelectedOptionContainer(tbl1)
    local var1 = useWearTimeSelectedOptionViewModel(tbl1)
    return WearTimeSelectedOptionInListView(var1)
end

return WearTimeSelectedOptionContainer
