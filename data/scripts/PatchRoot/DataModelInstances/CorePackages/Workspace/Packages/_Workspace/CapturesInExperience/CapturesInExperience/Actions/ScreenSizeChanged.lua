-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

return require(scriptParentParentParent.Rodux).makeActionCreator(script.Name, function(screenSize)
    return { screenSize = screenSize }
end)
