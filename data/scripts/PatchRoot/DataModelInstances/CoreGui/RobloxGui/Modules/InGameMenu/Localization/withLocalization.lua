-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local LocalizationConsumer = require(script.Parent.LocalizationConsumer)

local function withLocalization(stringsToBeLocalized)
    assert(t.table(stringsToBeLocalized))

    return function(render)
        assert(t.callback(render))

        return Roact.createElement(LocalizationConsumer, { render = render, stringsToBeLocalized = stringsToBeLocalized })
    end
end

return withLocalization
