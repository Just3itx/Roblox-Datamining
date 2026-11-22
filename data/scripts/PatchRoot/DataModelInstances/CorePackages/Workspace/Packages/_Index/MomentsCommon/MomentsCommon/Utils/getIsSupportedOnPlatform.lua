-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local AppCommonLib = require(MomentsCommonParent.AppCommonLib)
local IsVRAppBuild = AppCommonLib.IsVRAppBuild
local isTenFootInterface = AppCommonLib.isTenFootInterface

local function getIsSupportedOnPlatform(): boolean
    return not (IsVRAppBuild() or isTenFootInterface())
end

return getIsSupportedOnPlatform
