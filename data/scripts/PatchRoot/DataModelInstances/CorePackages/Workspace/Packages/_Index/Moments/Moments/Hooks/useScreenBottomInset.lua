-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local AppNavBar = require(MomentsParent.AppNavBar)
local AppSystemBar = require(MomentsParent.AppSystemBar)
local FFlagMomentsFeedAboveNavBar = require(Moments.Flags.FFlagMomentsFeedAboveNavBar)

local useNavBarSize = AppNavBar.useNavBarSize
local useNavBarPlacement = AppNavBar.useNavBarPlacement
local Placement = AppNavBar.Placement

local function useScreenBottomInset()
    local var1 = useNavBarPlacement()
    local var2 = useNavBarSize()
    if FFlagMomentsFeedAboveNavBar then
        var2 = AppSystemBar.Constants.BOTTOM_BAR_SIZE
    end

    return if var1 == Placement.Bottom then var2 else 0
end

return useScreenBottomInset
