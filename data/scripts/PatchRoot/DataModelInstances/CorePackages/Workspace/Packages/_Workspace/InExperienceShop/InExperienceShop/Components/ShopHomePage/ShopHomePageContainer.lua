-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local React = require(InExperienceShopParent.React)

local ShopHomePageView = require(script.Parent.ShopHomePageView)
local useShopHomePageViewModel = require(script.Parent.useShopHomePageViewModel)

return React.memo(function(arg1) -- name: ShopHomePageContainer
    local var1 = useShopHomePageViewModel(arg1)
    return React.createElement(ShopHomePageView, var1)
end)
