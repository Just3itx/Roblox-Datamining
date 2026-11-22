-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local React = require(ProfileQRCodeParent.React)
local Dash = require(ProfileQRCodeParent.Dash)

return React.createContext({ fireEvent = Dash.noop })
