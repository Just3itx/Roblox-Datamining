-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local chatReducer = require(script.Parent.Parent.Reducers.chatReducer)

return Rodux.Store.new(chatReducer)
