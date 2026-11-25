-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local InputUi = require(ProfilePlatformParent.InputUi)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useScreenSize = RobloxAppHooks.useScreenSize
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local getSafeAreaSize = InputUi.getSafeAreaSize
local useNavBarSize = require(ProfilePlatformParent.AppNavBar).useNavBarSize
local Constants = require(ProfilePlatform.Common.Constants)

return function(bool1: boolean): number
    local var1 = useScreenSize()
    local var2 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)
    local safeAreaSize = getSafeAreaSize(var1, var2)
    local var3 = useNavBarSize()

    if not bool1 then
        return math.min(safeAreaSize.X.Offset, Constants.MAXIMUM_CONTAINER_WIDTH)
    end

    return math.max(Constants.MINIMUN_CONTAINER_WIDTH, math.floor((safeAreaSize.X.Offset - var3) / 3))
end
