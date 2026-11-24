-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
return require(scriptParent.ActionCreator)(script.Name, function(onSelectionLost: ((...any) -> (...any))?, keybinds)
    return { onSelectionLost = onSelectionLost, keybinds = keybinds }
end)
