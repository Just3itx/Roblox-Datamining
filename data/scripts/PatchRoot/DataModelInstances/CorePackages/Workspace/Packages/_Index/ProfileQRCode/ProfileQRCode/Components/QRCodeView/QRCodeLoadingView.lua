-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local React = require(ProfileQRCodeParent.React)
local Foundation = require(ProfileQRCodeParent.Foundation)
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton

return function()
    return React.createElement(Skeleton, { Size = UDim2.new(1, 0, 1, 0), radius = Radius.None })
end
