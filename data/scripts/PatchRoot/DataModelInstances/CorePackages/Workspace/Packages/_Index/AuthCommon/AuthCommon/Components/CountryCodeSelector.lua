-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Roact = require(AuthCommonParent.Roact)
local React = require(AuthCommonParent.React)
local RoactRodux = require(AuthCommonParent.RoactRodux)
local RoactServices = require(AuthCommonParent.RoactServices).RoactServices
local RoactNetworking = require(AuthCommonParent.RoactServiceTags).RoactNetworking
local Cryo = require(AuthCommonParent.Cryo)
local useSignalState = require(AuthCommonParent.SignalsReact).useSignalState
local FFlagUseSignalsForCountryCodeList = require(AuthCommonParent.SharedFlags).FFlagUseSignalsForCountryCodeList
local GetCountryCodeListStore = require(AuthCommon.Stores.GetCountryCodeListStore)

local ListSearchWidget = require(AuthCommon.Components.ListSearchWidget)
local ApiFetchCountryCodes = require(AuthCommon.Thunks.ApiFetchCountryCodes)

local CountryCodeSelectorButton = require(AuthCommon.Components.CountryCodeSelectorButton)

local var1 = Roact.PureComponent:extend("CountryCodeSelector")

function var1.init(arg1)
    arg1.props.fetchCountryCodes(arg1.props.networking):catch(function() end)
end

function var1.render(arg1)
    return Roact.createElement(ListSearchWidget, {
        Heading = "Authentication.SignUp.Heading.CountryCodeSelector",
        CloseCallback = arg1.props.CloseCallback,
        VisibilityTarget = if arg1.props.WidgetVisible then 1 else 0,
        List = arg1.props.countryCodeList,
        ListButton = CountryCodeSelectorButton,
        SelectionCallback = arg1.props.SelectionCallback
    })
end

local var2 = RoactRodux.connect(not FFlagUseSignalsForCountryCodeList and function(arg1)
    return {
        countryCodeList = arg1.CountryCodeList
    }
end or nil, function(arg1)
    return {
        fetchCountryCodes = function(arg2)
            return arg1(ApiFetchCountryCodes.Fetch(arg2))
        end
    }
end)(var1)

local var3 = if FFlagUseSignalsForCountryCodeList then React.memo(function(arg1)
    local countryCodeList = useSignalState(GetCountryCodeListStore(false).getCountryCodeList)
    return Roact.createElement(var2, Cryo.Dictionary.union(arg1, { countryCodeList = countryCodeList }))
end) else var2

return RoactServices.connect({ networking = RoactNetworking })(var3)
