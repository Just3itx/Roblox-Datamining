-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local PioneerInfo = require(PurchasePromptParent.PioneerUtils).PioneerInfo

return function()
    return PioneerInfo.isDaveyBazooka()
end
