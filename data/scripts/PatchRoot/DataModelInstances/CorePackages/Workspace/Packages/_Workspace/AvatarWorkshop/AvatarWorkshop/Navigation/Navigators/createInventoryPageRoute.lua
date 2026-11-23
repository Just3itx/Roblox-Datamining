-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local _React = require(AvatarWorkshopParent.React)

local InventoryPagesData = require(AvatarWorkshop.Constants.InventoryPagesData)
local _createPagesNavigator = require(script.Parent.createPagesNavigator)

local function createInventoryPageRoute(str1: string, screen)
    local pageData = InventoryPagesData[str1]

    assert(pageData ~= nil, `createInventoryPageRoute: no InventoryPagesData entry for screen "{str1}"`)

    return {
        [str1] = {
            screen = screen,
            params = { pageData = pageData }
        }
    }
end

return createInventoryPageRoute
