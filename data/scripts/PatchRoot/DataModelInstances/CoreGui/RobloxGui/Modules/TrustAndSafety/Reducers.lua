-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local common = require(script.common)
local displayOptions = require(script.displayOptions)
local placeInfo = require(script.placeInfo)
local report = require(script.report)

return (Rodux.combineReducers({ common = common, displayOptions = displayOptions, placeInfo = placeInfo, report = report }))
