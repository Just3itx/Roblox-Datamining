-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local React = require(scriptParentParent.React)
local Toast = require(scriptParentParent.UIBlox).App.Dialog.Toast

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParent.InExperienceLocales).Localization
local LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider
local StyleProviderWithDefaultTheme = require(scriptParentParent.Style).StyleProviderWithDefaultTheme

local root = nil

local function func1(toastContent)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            StyleProvider = React.createElement(StyleProviderWithDefaultTheme, {}, {
                ToastWrapper = React.createElement(
                    "ScreenGui",
                    {
                        IgnoreGuiInset = true,
                        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                        ResetOnSpawn = false,
                        DisplayOrder = 12
                    },
                    {
                        Toast = React.createElement(Toast, { duration = 3, toastContent = toastContent })
                    }
                )
            })
        }
    )
end
return function(arg1)
    if not root then
        local uiBloxToast = Instance.new("Folder")
        uiBloxToast.Name = "UIBloxToast"
        uiBloxToast.Parent = game:GetService("CoreGui")
        root = ReactRoblox.createRoot(uiBloxToast)
    end

    root:render(React.createElement(func1, arg1))
end
