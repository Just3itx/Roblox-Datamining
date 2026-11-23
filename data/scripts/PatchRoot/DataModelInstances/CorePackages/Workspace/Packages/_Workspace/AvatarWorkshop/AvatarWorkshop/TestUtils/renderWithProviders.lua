-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local React = require(AvatarWorkshopParent.React)
local ReactRoblox = require(AvatarWorkshopParent.ReactRoblox)

local ContextProviders = require(AvatarWorkshop.Internal.ContextProviders)

local function renderWithProviders(arg1, arg2)
    local frame = Instance.new("Frame")
    local root = ReactRoblox.createRoot(frame)
    ReactRoblox.act(function()
        root:render(React.createElement(ContextProviders, { theme = "Dark" }, { Child = React.createElement(arg1, arg2) }))
    end)

    return frame, root
end

return renderWithProviders
