-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local React = require(AuthCommonParent.React)
local RoactNetworking = require(AuthCommonParent.RoactServiceTags).RoactNetworking
local ApiFetchCountryCodes = require(AuthCommon.Thunks.ApiFetchCountryCodes)
local CountryCodeDropdownView = require(AuthCommon.Components.InGame.CountryCodeDropdownView)
local useRoactService = require(AuthCommonParent.RobloxAppHooks).useRoactService
local RoactUtils = require(AuthCommonParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useSignalState = require(AuthCommonParent.SignalsReact).useSignalState
local FFlagUseSignalsForCountryCodeList = require(AuthCommonParent.SharedFlags).FFlagUseSignalsForCountryCodeList
local GetCountryCodeListStore = require(AuthCommon.Stores.GetCountryCodeListStore)
local _Types = require(AuthCommon.Common.Types)

local function CountryCodeDropdownContainer(tbl1)
    local var1 = useRoactService(RoactNetworking)
    local var2 = useDispatch()
    local position = tbl1.position
    local maxHeight = tbl1.maxHeight
    local dropdownVisible = tbl1.dropdownVisible
    local onCountryCodeSelected = tbl1.onCountryCodeSelected

    local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        return var2(ApiFetchCountryCodes.Fetch(arg1))
    end

    local countryCodeList = if FFlagUseSignalsForCountryCodeList then useSignalState(GetCountryCodeListStore(false).getCountryCodeList) else useSelector(function(arg1)
        return arg1.CountryCodeList
    end)

    React.useEffect(function()
        func1(var1):catch(function() end)
    end, {})

    return React.createElement(CountryCodeDropdownView, {
        dropdownVisible = dropdownVisible,
        countryCodeList = countryCodeList,
        onCountryCodeSelected = onCountryCodeSelected,
        maxHeight = maxHeight,
        position = position
    })
end

return CountryCodeDropdownContainer
