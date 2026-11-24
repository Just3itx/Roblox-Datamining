-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local React = require(InExperienceShopParent.React)

local CategoryPageView = require(script.Parent.CategoryPageView)
local useCategoryPageViewModel = require(script.Parent.useCategoryPageViewModel)

local function CategoryPageContainer(arg1)
    local var1 = useCategoryPageViewModel(arg1)
    return React.createElement(CategoryPageView, var1)
end

return CategoryPageContainer
