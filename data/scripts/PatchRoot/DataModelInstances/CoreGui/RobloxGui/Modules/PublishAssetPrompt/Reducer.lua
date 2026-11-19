-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local PromptRequestReducer = require(script.PromptRequestReducer)

return (Rodux.combineReducers({ promptRequest = PromptRequestReducer }))
