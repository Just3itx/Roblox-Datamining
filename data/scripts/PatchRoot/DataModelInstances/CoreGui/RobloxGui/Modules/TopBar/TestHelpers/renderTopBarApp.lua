-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local ReactSceneUnderstanding = require(CorePackages.Packages.ReactSceneUnderstanding)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider
local RobloxAppEnums = require(CorePackages.Workspace.Packages.RobloxAppEnums)
local DesignTokenProvider = require(CorePackages.Workspace.Packages.Style).DesignTokenProvider
local UniversalAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local scriptParentParent = script.Parent.Parent
local MenuNavigationPromptTokenMapper = require(scriptParentParent.TokenMappers.MenuNavigationPromptTokenMapper)
local Reducer = require(scriptParentParent.Reducer)
local TopBarAppPolicy = require(scriptParentParent.TopBarAppPolicy)

local RoactAppPolicy = UniversalAppPolicy.RoactAppPolicy
local AppFeaturePolicies = UniversalAppPolicy.AppFeaturePolicies
local FFlagShowGameAgeRating = SharedFlags.FFlagShowGameAgeRating

local style = {
    themeName = "dark",
    fontName = "gotham",
    deviceType = RobloxAppEnums.DeviceType.Console
}

if not CoreGui.RobloxGui:FindFirstChild("SendNotificationInfo") then
    local sendNotificationInfo = Instance.new("BindableEvent")
    sendNotificationInfo.Name = "SendNotificationInfo"
    sendNotificationInfo.Parent = CoreGui.RobloxGui
end

local function renderTopBarApp(arg1, arg2)
    local store = Rodux.Store.new(Reducer, nil, { Rodux.thunkMiddleware })

    local element = Roact.createElement(RoactRodux.StoreProvider, { store = store }, {
        PolicyProvider = Roact.createElement(
            if FFlagShowGameAgeRating then RoactAppPolicy.Provider else TopBarAppPolicy.Provider,
            {
                policy = FFlagShowGameAgeRating and { AppFeaturePolicies } or { TopBarAppPolicy.Mapper }
            },
            {
                LocalizationProvider = Roact.createElement(
                    LocalizationProvider,
                    {
                        localization = Localization.new(LocalizationService.RobloxLocaleId)
                    },
                    {
                        StyleProvider = Roact.createElement(UIBlox.App.Style.AppStyleProvider, {
                            style = style
                        }, {
                            DesignTokenProvider = Roact.createElement(
                                DesignTokenProvider,
                                {
                                    tokenMappers = {
                                        MenuNavigationPrompt = MenuNavigationPromptTokenMapper
                                    }
                                },
                                {
                                    SceneAnalysisProvider = Roact.createElement(ReactSceneUnderstanding.SceneAnalysisProvider, {}, { TopBarApp = Roact.createElement(arg1) })
                                }
                            )
                        })
                    }
                )
            }
        )
    })

    return Roact.mount(element, arg2)
end

return renderTopBarApp
