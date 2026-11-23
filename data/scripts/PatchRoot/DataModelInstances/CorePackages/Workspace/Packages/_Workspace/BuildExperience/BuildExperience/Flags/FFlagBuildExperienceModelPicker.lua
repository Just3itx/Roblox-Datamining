-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:31:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

return require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceModelPickerData
    and require(BuildExperience.Flags.FFlagBuildExperienceUseCommonTextArea)
    and require(BuildExperienceParent.SharedFlags).FFlagComposerFooter
