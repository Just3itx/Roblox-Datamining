-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local ReactTestingLibrary = require(InExperienceShopParent.Dev.ReactTestingLibrary)
local FoundationProvider = require(InExperienceShopParent.Foundation).FoundationProvider

local function renderWithProviders(arg1)
    return ReactTestingLibrary.render(React.createElement(FoundationProvider, { colorMode = "Dark" }, arg1))
end

return renderWithProviders
