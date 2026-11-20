-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local scriptParent = script.Parent

local SettingsReducer = require(scriptParent.Reducers.SettingsReducer)
local Rodux = require(CorePackages.Packages.Rodux)
local Store = Rodux.Store

local module = {}

function module.Destruct(arg1)
    arg1.store:destruct()
end

module.store = Store.new(SettingsReducer, nil, { Rodux.thunkMiddleware })

return module
