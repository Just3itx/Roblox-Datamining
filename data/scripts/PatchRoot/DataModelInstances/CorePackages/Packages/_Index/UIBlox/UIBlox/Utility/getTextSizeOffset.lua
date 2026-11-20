-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local getTextSizeOffset = require(scriptParentParentParent.Foundation).Utility.getTextSizeOffset

return function(_)
    local textSizeOffset = getTextSizeOffset()
    return textSizeOffset ~= nil, textSizeOffset
end
