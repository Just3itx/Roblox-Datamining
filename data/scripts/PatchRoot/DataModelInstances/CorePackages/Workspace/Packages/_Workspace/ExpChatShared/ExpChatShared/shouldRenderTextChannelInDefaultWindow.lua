-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local GetFFlagExpChatUseIsDefaultTextChannel = require(scriptParent.Flags.GetFFlagExpChatUseIsDefaultTextChannel)

local function shouldRenderTextChannelInDefaultWindow(arg1, arg2): boolean
    return not GetFFlagExpChatUseIsDefaultTextChannel()
        or arg2 == nil
        or arg2.Value ~= 1
        or arg1 == nil
        or arg1.IsDefaultTextChannel == true
end

return shouldRenderTextChannelInDefaultWindow
