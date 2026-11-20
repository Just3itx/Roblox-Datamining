-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

return require(MomentsCreationFlowParent.Rodux).makeActionCreator(script.Name, function(capture)
    return { capture = capture }
end)
