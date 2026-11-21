-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Rodux = require(AuthCommonParent.Rodux)

local CountryCodeList = require(AuthCommon.Reducers.CountryCodeList)

local FFlagUseSignalsForCountryCodeList = require(AuthCommonParent.SharedFlags).FFlagUseSignalsForCountryCodeList

return function()
    return Rodux.combineReducers({ CountryCodeList = if FFlagUseSignalsForCountryCodeList then nil else CountryCodeList })
end
