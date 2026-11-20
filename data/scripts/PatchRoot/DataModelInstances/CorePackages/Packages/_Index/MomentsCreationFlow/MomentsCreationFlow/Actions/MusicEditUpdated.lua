-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

local _MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
return require(MomentsCreationFlowParent.Rodux).makeActionCreator(script.Name, function(musicEdit)
    return { musicEdit = musicEdit }
end)
