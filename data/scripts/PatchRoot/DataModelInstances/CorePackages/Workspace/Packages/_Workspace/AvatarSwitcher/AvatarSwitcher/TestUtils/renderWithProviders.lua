-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local ReactRoblox = require(AvatarSwitcherParent.ReactRoblox)

local ContextProviders = require(AvatarSwitcher.Internal.ContextProviders)

local function renderWithProviders(arg1, arg2)
    local frame = Instance.new("Frame")
    local root = ReactRoblox.createRoot(frame)
    ReactRoblox.act(function()
        root:render(React.createElement(ContextProviders, { theme = "Dark" }, { Child = React.createElement(arg1, arg2) }))
    end)

    return frame, root
end

return renderWithProviders
