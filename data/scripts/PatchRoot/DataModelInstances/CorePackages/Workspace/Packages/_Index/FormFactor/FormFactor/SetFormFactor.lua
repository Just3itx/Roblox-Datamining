-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FormFactorParent = script:FindFirstAncestor("FormFactor").Parent

return require(FormFactorParent.Rodux).makeActionCreator(script.Name, function(formFactor)
    return { formFactor = formFactor }
end)
