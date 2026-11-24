-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local Promise = require(InExperienceShopParent.Promise)

return {
    getPassOwnership = function(_, _: number)
        return Promise.resolve(false)
    end
}
