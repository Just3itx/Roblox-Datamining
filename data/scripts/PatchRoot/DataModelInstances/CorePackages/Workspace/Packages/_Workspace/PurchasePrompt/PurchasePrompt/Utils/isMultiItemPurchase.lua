-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local RequestType = require(scriptParentParent.Enums.RequestType)

function isMultiItemPurchase(look): boolean
    return look == RequestType.Look
end

return isMultiItemPurchase
