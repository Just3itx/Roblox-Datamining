-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local EventNames = require(ProfileQRCode.Analytics.EventNames)
local useEffectOnce = require(ProfileQRCodeParent.RoactUtils).Hooks.useEffectOnce
local _useAnalytics = require(ProfileQRCode.Analytics.useAnalytics)

return function(arg1, bool1: boolean)
    useEffectOnce(function()
        arg1.fireEvent(EventNames.QRPageLoadFailed)
    end, bool1)
end
