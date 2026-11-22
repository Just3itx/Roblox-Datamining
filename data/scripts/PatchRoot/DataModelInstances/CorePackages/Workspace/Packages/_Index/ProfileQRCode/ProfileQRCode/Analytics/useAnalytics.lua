-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local React = require(ProfileQRCodeParent.React)
local ProfileQRCodeAnalytics = require(script.Parent.ProfileQRCodeAnalytics)

return function()
    return React.useContext(ProfileQRCodeAnalytics)
end
