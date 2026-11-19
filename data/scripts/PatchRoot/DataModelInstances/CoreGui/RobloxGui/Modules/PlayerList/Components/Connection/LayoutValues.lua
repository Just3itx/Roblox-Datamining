-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local LayoutValuesContext = require(script.Parent.LayoutValuesContext)

return {
    Provider = function(arg1) -- name: layoutValuesProvider
        return Roact.createElement(LayoutValuesContext.Provider, { value = arg1.layoutValues }, Roact.oneChild(arg1[Roact.Children]))
    end,
    Consumer = LayoutValuesContext.Consumer,
    WithLayoutValues = function(render) -- name: withLayoutValues
        assert(type(render) == "function", "Expect withLayoutValues callback to be a function.")
        return Roact.createElement(LayoutValuesContext.Consumer, { render = render })
    end
}
