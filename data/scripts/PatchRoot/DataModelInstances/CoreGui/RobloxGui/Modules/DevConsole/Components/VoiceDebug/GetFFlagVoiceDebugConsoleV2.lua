-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("VoiceDebugConsoleV2", false)

local VoiceDebugConsoleV2TestOverride = require(script.Parent.VoiceDebugConsoleV2TestOverride)

return function()
    local var1 = VoiceDebugConsoleV2TestOverride.get()
    if var1 ~= nil then
        return var1
    end
    return game:GetFastFlag("VoiceDebugConsoleV2")
end
