-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Packages = script:FindFirstAncestor("Packages")
local RoactRodux = require(Packages.Dev.RoactRodux)
local dependencies = require(script.Parent.Parent.Parent.dependencies)
local Roact = dependencies.Roact
local Rodux = dependencies.Rodux

local mockStyle = require(script.Parent.mockStyle)
local mockNavigation = require(script.Parent.mockNavigation)

local store = Rodux.Store.new(function()
    return {}
end, {}, { Rodux.thunkMiddleware })

return function(arg1, arg2)
    arg2 = arg2 or {}
    local var1 = arg2.store or store

    local var2 = arg2.mockNavigation or mockNavigation

    local children = mockStyle(var2(arg1))

    return Roact.createElement(RoactRodux.StoreProvider, { store = var1 }, { children = children })
end
