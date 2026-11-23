-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local _React = require(AvatarWorkshopParent.React)

local createPagesNavigator = require(script.Parent.createPagesNavigator)

local function createPageGroupRoute(str1: string, arg1, tbl1)
    return {
        [str1] = {
            screen = createPagesNavigator(arg1, tbl1)
        }
    }
end

return createPageGroupRoute
