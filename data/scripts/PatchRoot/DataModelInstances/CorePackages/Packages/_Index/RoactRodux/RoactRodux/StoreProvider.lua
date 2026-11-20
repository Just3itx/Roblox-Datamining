-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Roact = require(script.Parent.Parent.Roact)

local StoreContext = require(script.Parent.StoreContext)

local var1 = Roact.Component:extend("StoreProvider")

function var1.validateProps(arg1)
    if arg1.store == nil then
        return false, "Error initializing StoreProvider. Expected a `store` prop to be a Rodux store."
    end
    return true
end

function var1.init(arg1, arg2)
    arg1.store = arg2.store
end

function var1.render(arg1)
    return Roact.createElement(StoreContext.Provider, { value = arg1.store }, Roact.oneChild(arg1.props[Roact.Children]))
end

return var1
