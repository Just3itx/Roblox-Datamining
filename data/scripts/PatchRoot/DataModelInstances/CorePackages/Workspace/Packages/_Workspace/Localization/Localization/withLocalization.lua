-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationParent = script:FindFirstAncestor("Localization").Parent
local React = require(LocalizationParent.React)
local ArgCheck = require(LocalizationParent.ArgCheck)
local LocalizationConsumer = require(script.Parent.LocalizationConsumer)

local function withLocalization(stringsToBeLocalized)
    ArgCheck.isType(stringsToBeLocalized, "table", "stringsToBeLocalized passed to withLocalization()")

    return function(render)
        ArgCheck.isType(render, "function", "render passed to withLocalization()")

        return React.createElement(LocalizationConsumer, { render = render, stringsToBeLocalized = stringsToBeLocalized })
    end
end

return withLocalization
