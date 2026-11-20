-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _CoreGui = game:GetService("CoreGui")

local AppShellReducer = require(script.Parent.Reducers.AppShellReducer)
local Rodux = require(CorePackages.Packages.Rodux)

local module = {}

function module.Destruct(arg1)
    arg1.store:destruct()
end

local tbl1 = { Rodux.thunkMiddleware }

module.store = Rodux.Store.new(AppShellReducer, {}, tbl1, nil)
return module
