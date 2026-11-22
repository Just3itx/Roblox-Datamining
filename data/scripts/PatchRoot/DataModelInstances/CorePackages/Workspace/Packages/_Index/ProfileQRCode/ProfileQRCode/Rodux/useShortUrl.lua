-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local getDeepValue = require(ProfileQRCodeParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue
local useSelector = require(ProfileQRCodeParent.RoactUtils).Hooks.RoactRodux.useSelector
local Constants = require(ProfileQRCode.Common.Constants)

return function()
    return useSelector(function(arg1)
        return getDeepValue(arg1, Constants.RODUX_KEY .. ".ShareUrl.shortUrl")
    end)
end
