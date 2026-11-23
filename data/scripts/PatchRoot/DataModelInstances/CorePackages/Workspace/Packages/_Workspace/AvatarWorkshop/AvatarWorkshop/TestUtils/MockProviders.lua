-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local React = require(AvatarWorkshopParent.React)

local ContextProviders = require(AvatarWorkshop.Internal.ContextProviders)

local function MockProviders(tbl1)
    return React.createElement(ContextProviders, { theme = "Dark" }, tbl1.children)
end

return MockProviders
