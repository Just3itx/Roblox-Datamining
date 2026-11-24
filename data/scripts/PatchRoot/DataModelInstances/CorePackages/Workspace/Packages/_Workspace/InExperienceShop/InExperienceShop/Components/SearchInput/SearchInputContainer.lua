-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local React = require(InExperienceShopParent.React)

local SearchInputView = require(script.Parent.SearchInputView)
local useSearchInputViewModel = require(script.Parent.useSearchInputViewModel)

local function SearchInputContainer(arg1)
    local var1 = useSearchInputViewModel(arg1)
    return React.createElement(SearchInputView, var1)
end

return SearchInputContainer
