-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getUIScaleFromTokens(arg1)
    if arg1 and arg1.Config and arg1.Config.UI and arg1.Config.UI.Scale then
        return arg1.Config.UI.Scale
    end

    return 1
end

return getUIScaleFromTokens
