-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local GetFFlagExpChatUseIsDefaultTextChannel = require(scriptParent.Flags.GetFFlagExpChatUseIsDefaultTextChannel)

local function markTextChannelAsDefault(arg1)
    if not GetFFlagExpChatUseIsDefaultTextChannel() then
        return
    end

    arg1.IsDefaultTextChannel = true
end

return markTextChannelAsDefault
