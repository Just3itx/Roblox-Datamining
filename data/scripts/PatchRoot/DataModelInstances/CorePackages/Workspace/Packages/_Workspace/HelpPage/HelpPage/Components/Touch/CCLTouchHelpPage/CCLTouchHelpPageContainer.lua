-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HelpPageParent = script:FindFirstAncestor("HelpPage").Parent
local React = require(HelpPageParent.React)

local CCLTouchHelpPageView = require(script.Parent.CCLTouchHelpPageView)
local useCCLTouchHelpPageViewModel = require(script.Parent.useCCLTouchHelpPageViewModel)

local function CCLTouchHelpPageContainer()
    local var1 = useCCLTouchHelpPageViewModel()
    return React.createElement(CCLTouchHelpPageView, var1)
end

return CCLTouchHelpPageContainer
