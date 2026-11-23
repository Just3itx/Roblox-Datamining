-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")

local createInventoryPageStore = require(AvatarWorkshop.Stores.Creators.createInventoryPageStore)
local _InventoryPagesData = require(AvatarWorkshop.Constants.InventoryPagesData)

local tbl1 = ({})

local function getInventoryPageStore(arg1)
    if not tbl1[arg1] then
        tbl1[arg1] = createInventoryPageStore(arg1)
    end

    return tbl1[arg1]
end

return getInventoryPageStore
