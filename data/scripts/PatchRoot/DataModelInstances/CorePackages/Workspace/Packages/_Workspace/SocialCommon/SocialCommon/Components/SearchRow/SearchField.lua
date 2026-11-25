-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local React = require(SocialCommonParent.React)

local SearchFieldView = require(script.Parent.SearchFieldView)
local useSearchFieldViewModel = require(script.Parent.useSearchFieldViewModel)

local function SearchField(arg1)
    local var1 = useSearchFieldViewModel(arg1)
    return React.createElement(SearchFieldView, var1)
end

return SearchField
