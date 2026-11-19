-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.InGameMenuDependencies).Rodux

local scriptParent = script.Parent

local GlobalConfig = require(scriptParent.GlobalConfig)
local reducer = require(scriptParent.reducer)

local function createStore()
    local tbl1 = { Rodux.thunkMiddleware }

    if GlobalConfig.logStore then
        table.insert(tbl1, Rodux.loggerMiddleware)
    end

    return Rodux.Store.new(reducer, nil, tbl1)
end

return createStore
