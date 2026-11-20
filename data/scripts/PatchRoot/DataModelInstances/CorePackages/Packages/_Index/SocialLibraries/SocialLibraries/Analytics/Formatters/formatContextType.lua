-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local ContextTypes = require(scriptParentParentParent.Analytics.Enums).ContextTypes

return function(arg1)
    if arg1 == nil then
        return nil
    end

    return ContextTypes[arg1.rawValue()].rawValue()
end
