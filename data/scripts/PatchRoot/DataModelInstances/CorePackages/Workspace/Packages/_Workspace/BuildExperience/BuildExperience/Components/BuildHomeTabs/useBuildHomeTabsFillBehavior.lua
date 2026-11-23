-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local FormFactor = require(BuildExperienceParent.FormFactor).Enums.FormFactor
local RoactUtils = require(BuildExperienceParent.RoactUtils)

local FillBehavior = Foundation.Enums.FillBehavior
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local function selectFormFactor(arg1)
    return arg1.FormFactor
end

local function useBuildHomeTabsFillBehavior()
    return if useSelector(selectFormFactor) == FormFactor.COMPACT then FillBehavior.Fill else FillBehavior.Fit
end

return useBuildHomeTabsFillBehavior
