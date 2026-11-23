-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local CreatorCreditPageView = require(script.Parent.CreatorCreditPageView)
local DailyLimitBottomSheet = require(script.Parent.DailyLimitBottomSheet)
local useCreatorCreditPageViewModel = require(script.Parent.useCreatorCreditPageViewModel)

local function CreatorCreditPageContainer(_)
    local var1 = useCreatorCreditPageViewModel()
    return React.createElement(React.Fragment, nil, {
        Page = React.createElement(CreatorCreditPageView, var1.pageProps),
        LimitSheet = React.createElement(DailyLimitBottomSheet, var1.limitSheetProps)
    })
end

return CreatorCreditPageContainer
