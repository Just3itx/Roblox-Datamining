-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Features = scriptParentParent.Features
local PlatformEnum = require(scriptParentParent.Enums.PlatformEnum)

local EnableSafetyBubbleDummy = require(Features.EnableSafetyBubbleDummy)

function GetFeatures(questVr)
    if questVr == PlatformEnum.QuestVR then
        EnableSafetyBubbleDummy()
    end
end

return GetFeatures
