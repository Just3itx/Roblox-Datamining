-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")

local _Types = require(SocialUpsell.Types)

return function(arg1): boolean
    return not (arg1.buttons and not (#arg1.buttons < 2) or arg1.labelItems and #arg1.labelItems ~= 0)
        and not (arg1.image or arg1.body or arg1.isDismissable)
end
