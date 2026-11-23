-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local React = require(AvatarWorkshopParent.React)
local RoactNavigation = require(AvatarWorkshopParent.RoactNavigation)

local _NavigationTypes = require(AvatarWorkshop.Navigation.NavigationTypes)

local function useNavigation()
    return React.useContext(RoactNavigation.Context)
end

return useNavigation
