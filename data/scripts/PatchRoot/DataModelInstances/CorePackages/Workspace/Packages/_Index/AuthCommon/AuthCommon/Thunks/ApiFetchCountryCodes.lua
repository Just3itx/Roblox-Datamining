-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local Promise = require(AuthCommonParent.Promise)
local PerformFetch = require(AuthCommonParent.Http).PerformFetch

local GetCountryCodes = require(AuthCommon.Http.Requests.GetCountryCodes)
local CountryCode = require(AuthCommon.Models.CountryCode)
local SetCountryCodeList = require(AuthCommon.Actions.SetCountryCodeList)
local FFlagUseSignalsForCountryCodeList = require(AuthCommonParent.SharedFlags).FFlagUseSignalsForCountryCodeList
local GetCountryCodeListStore = require(AuthCommon.Stores.GetCountryCodeListStore)

local module = {}

function module._updateStoreWithCountryCodes(arg1, arg2)
    local tbl1 = ({})
    for k, value in pairs(arg2.responseBody) do
        tbl1[k] = CountryCode.fromJSON(value)
    end
    if FFlagUseSignalsForCountryCodeList then
        GetCountryCodeListStore(false).setCountryCodeList(tbl1)
    else
        arg1:dispatch(SetCountryCodeList(tbl1))
    end
    return Promise.resolve()
end

function module.Fetch(arg1)
    return PerformFetch.Single("luaapp.countriesapi.countrycodes", function(arg2)
        return GetCountryCodes(arg1):andThen(function(arg3)
            if arg3 and arg3.responseBody then
                return module._updateStoreWithCountryCodes(arg2, arg3)
            end
            return Promise.reject()
        end)
    end)
end

function module.GetFetchingStatus(arg1)
    return PerformFetch.GetStatus(arg1, "luaapp.countriesapi.countrycodes")
end

return module
