-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformCommonParent = script:FindFirstAncestor("ProfilePlatformCommon").Parent

local InputUi = require(ProfilePlatformCommonParent.InputUi)
local RobloxAppHooks = require(ProfilePlatformCommonParent.RobloxAppHooks)
local RoactUtils = require(ProfilePlatformCommonParent.RoactUtils)
local useScreenSize = RobloxAppHooks.useScreenSize
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local getSafeAreaSize = InputUi.getSafeAreaSize
local useNavBarSize = require(ProfilePlatformCommonParent.AppNavBar).useNavBarSize
local GetDisplayStore = require(ProfilePlatformCommonParent.Display).GetDisplayStore
local FFlagProfilePlatformNewProfileHeader = require(ProfilePlatformCommonParent.SharedFlags).FFlagProfilePlatformNewProfileHeader

local bool1 = game:DefineFastFlag("FixIsWideModeCheck", false)

return function(): number
    local var1 = useScreenSize()
    local var2 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)
    local safeAreaSize = getSafeAreaSize(var1, var2)
    local bool2 = if bool1 then safeAreaSize.X.Offset > safeAreaSize.Y.Offset else GetDisplayStore(false).getDisplaySize(false) ~= Enum.DisplaySize.Small
    local var3 = useNavBarSize()

    if not FFlagProfilePlatformNewProfileHeader then
        return math.min(safeAreaSize.X.Offset, 640)
    end

    if not bool2 then
        return math.min(safeAreaSize.X.Offset, 640)
    end

    return math.max(456, math.floor((safeAreaSize.X.Offset - var3) / 3))
end
