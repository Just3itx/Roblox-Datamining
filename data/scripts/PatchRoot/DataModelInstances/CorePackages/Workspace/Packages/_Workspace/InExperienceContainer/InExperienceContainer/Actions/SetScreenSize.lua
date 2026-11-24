-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceContainerParent = script:FindFirstAncestor("InExperienceContainer").Parent

return require(InExperienceContainerParent.Rodux).makeActionCreator(script.Name, function(screenSize)
    return { screenSize = screenSize }
end)
