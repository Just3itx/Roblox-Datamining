-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local useNineDotActivityIndicator = require(Chrome.ChromeShared.Hooks.useNineDotActivityIndicator)

local submitFreeTrialBlueDot = require(CorePackages.Workspace.Packages.InExperienceShop.submitFreeTrialBlueDot)

local function useFreeTrialNineDotActivityIndicator()
    local var1 = SignalsReact.useSignalState(submitFreeTrialBlueDot.isHamburgerBlueDotShowing)

    useNineDotActivityIndicator("free_trial_blue_dot", var1 == true)

    React.useEffect(function()
        if var1 ~= true then
            return
        end
        submitFreeTrialBlueDot.reportMounted()
        submitFreeTrialBlueDot.reportViewed()
    end, { var1 })
end

return useFreeTrialNineDotActivityIndicator
