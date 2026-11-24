-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)

local function findSection(tbl1, id: string)
    for _, value in tbl1 do
        if value.id == id then
            return value
        end
    end
    return nil
end

return findSection
