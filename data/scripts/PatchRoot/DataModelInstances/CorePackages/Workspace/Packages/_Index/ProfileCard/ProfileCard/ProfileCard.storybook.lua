-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local ProfileCard = script:FindFirstAncestor("ProfileCard")
local ProfileCardParent = ProfileCard.Parent

local Foundation = require(ProfileCardParent.Foundation)
local LocalizationProvider = require(ProfileCardParent.Localization).LocalizationProvider
local React = require(ProfileCardParent.React)
local ReactRoblox = require(ProfileCardParent.Dev.ReactRoblox)
local Localization = require(ProfileCardParent.Dev.RobloxAppLocales).Localization
local UIBlox = require(ProfileCardParent.UIBlox)
local UniversalAppPolicy = require(ProfileCardParent.UniversalAppPolicy)

UIBlox.init(require(ProfileCardParent.Dev.RobloxAppUIBloxConfig))

local AppFeaturePolicies = UniversalAppPolicy.AppFeaturePolicies
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local RoactAppPolicy = UniversalAppPolicy.RoactAppPolicy

local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    Default = ColorMode.Dark,
    Dark = ColorMode.Dark,
    Light = ColorMode.Light
}

local function isControlEnabled(controls, str1: string)
    if controls == nil then
        return false
    end
    if controls[str1] == true then
        return true
    end
    for k, control in controls do
        if type(k) ~= "string" then
            continue
        end

        local num1 = #str1

        if string.sub(k, 1, num1) == str1 and control == true then
            return true
        end
    end
    return false
end

return {
    name = "ProfileCard",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local localization = React.useMemo(function()
                return Localization.new(LocalizationService.RobloxLocaleId)
            end, {})

            local var2 = tbl1[arg2.theme] or tbl1.Default
            local showUncheckedBadge = isControlEnabled(arg2.controls, "showUncheckedBadge")

            return React.createElement(LocalizationProvider, { localization = localization }, {
                Policy = React.createElement(RoactAppPolicy.Provider, {
                    key = tostring(showUncheckedBadge),
                    policy = { AppFeaturePolicies },
                    policyData = { ShowUncheckedBadge = showUncheckedBadge }
                }, {
                    Foundation = React.createElement(FoundationProvider, {
                        colorMode = var2,
                        device = Device[arg2.platform] or Device.Desktop,
                        preferences = arg2.settings,
                        scale = arg2.settings and arg2.settings.scale
                    }, {
                        AppStyle = React.createElement(
                            AppStyleProvider,
                            {
                                style = { themeName = var2, fontName = "Gotham" }
                            },
                            {
                                Story = React.createElement(arg1, arg2)
                            }
                        )
                    })
                })
            })
        end
    end,
    storyRoots = { ProfileCard }
}
