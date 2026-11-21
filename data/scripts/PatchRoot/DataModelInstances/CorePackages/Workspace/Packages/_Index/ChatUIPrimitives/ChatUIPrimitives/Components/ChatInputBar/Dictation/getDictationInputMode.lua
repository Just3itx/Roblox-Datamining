-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local DictationInputMode = require(ChatUIPrimitivesParent.DictationCore.Constants).DictationInputMode

local function getDictationInputMode(bool1: boolean?)
    return if bool1 then DictationInputMode.Hybrid else nil
end

return getDictationInputMode
