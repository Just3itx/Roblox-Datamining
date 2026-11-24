-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local InExperienceContainer = script:FindFirstAncestor("InExperienceContainer")
local LocalizationService = game:GetService("LocalizationService")
local IXPService = game:GetService("IXPService")
local InExperienceContainerParent = InExperienceContainer.Parent
local React = require(InExperienceContainerParent.React)
local StyleProviderWithDefaultTheme = require(InExperienceContainerParent.Style).StyleProviderWithDefaultTheme
local openWebview = require(InExperienceContainer.Http.openWebview)
local RoactRodux = require(InExperienceContainerParent.RoactRodux)
local FetchingStatus = require(InExperienceContainerParent.Http).Reducers.FetchingStatus
local RoactAnalytics = require(InExperienceContainerParent.RoactServiceTags).RoactAnalytics
local RoactNetworking = require(InExperienceContainerParent.RoactServiceTags).RoactNetworking
local AppLinking = require(InExperienceContainerParent.RoactServiceTags).AppLinking
local LinkingProtocol = require(InExperienceContainerParent.LinkingProtocol).LinkingProtocol
local Analytics = require(InExperienceContainerParent.Analytics).Analytics
local requestInternalWrapper = require(InExperienceContainerParent.Http).NetworkLayers.requestInternalWrapper
local RoactServices = require(InExperienceContainerParent.RoactServices).RoactServices
local ProviderContainer = require(InExperienceContainerParent.RoactUtils).Components.ProviderContainer
local useSelectedTheme = require(InExperienceContainerParent.RoactUtils).Hooks.useSelectedTheme
local RoactAppExperiment = require(InExperienceContainerParent.RoactAppExperiment)
local RoactAppPolicy = require(InExperienceContainerParent.UniversalAppPolicy).RoactAppPolicy
local AppFeaturePolicies = require(InExperienceContainerParent.UniversalAppPolicy).AppFeaturePolicies
local Localization = require(InExperienceContainerParent.RobloxAppLocales).Localization
local LocalizationProvider = require(InExperienceContainerParent.Localization).LocalizationProvider
local UIBlox = require(InExperienceContainerParent.UIBlox)
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider
local CursorProvider = UIBlox.App.SelectionCursor.CursorProvider
local Rodux = require(InExperienceContainerParent.Rodux)
local CountryCodeList = require(InExperienceContainerParent.AuthCommon).Reducers.CountryCodeList
local Cryo = require(InExperienceContainerParent.Cryo)

local GetFFlagInExperienceContainerScreenSizeReducer = require(InExperienceContainerParent.SharedFlags).GetFFlagInExperienceContainerScreenSizeReducer
local SetScreenSize = if GetFFlagInExperienceContainerScreenSizeReducer() then require(InExperienceContainer.Actions.SetScreenSize) else nil
local GetFFlagInExperienceContainerAppLinking = require(InExperienceContainerParent.SharedFlags).GetFFlagInExperienceContainerAppLinking

local GetFFlagInExperienceContainerRespectUserTheme = require(InExperienceContainerParent.SharedFlags).GetFFlagInExperienceContainerRespectUserTheme
local FFlagUseSignalsForCountryCodeList = require(InExperienceContainerParent.SharedFlags).FFlagUseSignalsForCountryCodeList

local tbl1 = {
    reducer = {}
}

local function InExperienceProviderContainer(tbl2)
    local var1 = useSelectedTheme()
    local var2 = Cryo.Dictionary.union(tbl1, tbl2)
    local var3 = React.Children.only(var2.children)

    local tbl3 = { Rodux.thunkMiddleware }

    local new = Rodux.Store.new
    local combineReducers = Rodux.combineReducers
    local join = Cryo.Dictionary.join
    local tbl4 = {
        CountryCodeList = if FFlagUseSignalsForCountryCodeList then nil else CountryCodeList,
        FetchingStatus = FetchingStatus,
        ScreenSize = 0
    }
    local var4

    if GetFFlagInExperienceContainerScreenSizeReducer() then
        local createReducer = Rodux.createReducer
        local vector2 = Vector2.new(400, 400)
        local tbl5 = {}
        tbl5[SetScreenSize.name] = function(_, arg1)
            return arg1.screenSize
        end

        var4 = createReducer(vector2, tbl5)
    else
        var4 = function(_, _): Vector2
            return Vector2.new(400, 400)
        end
    end

    tbl4.ScreenSize = var4
    local store = new(combineReducers(join(tbl4, var2.reducer)), nil, tbl3)

    local providers = {}

    table.insert(providers, {
        class = StyleProviderWithDefaultTheme,
        props = {
            withDarkTheme = not GetFFlagInExperienceContainerRespectUserTheme() or var1 ~= "light"
        }
    })

    table.insert(providers, { class = RoactRodux.StoreProvider, props = { store = store } })

    table.insert(
        providers,
        {
            class = LocalizationProvider,
            props = {
                localization = Localization.new(LocalizationService.RobloxLocaleId)
            }
        }
    )
    table.insert(providers, { class = RoactAppExperiment.Provider, props = { value = IXPService } })

    table.insert(providers, { class = RoactAppPolicy.Provider, props = { policy = { AppFeaturePolicies } } })

    local tbl6 = {
        class = RoactServices.ServiceProvider,
        props = 0
    }
    local props = { services = 0 }
    local services = {
        [RoactAnalytics] = Analytics.new(),
        [RoactNetworking] = requestInternalWrapper(HttpService)
    }
    local var6 = AppLinking
    services[var6] = if GetFFlagInExperienceContainerAppLinking() then LinkingProtocol.default else nil
    props.services = services
    tbl6.props = props
    table.insert(providers, tbl6)

    table.insert(providers, { class = SelectionCursorProvider })

    table.insert(providers, { class = CursorProvider })

    return React.createElement(
        ProviderContainer,
        { providers = providers },
        {
            Child = React.cloneElement(var3, { showWebpage = openWebview })
        }
    )
end

return InExperienceProviderContainer
