-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local Roact = require(scriptParentParentParent.Roact)
local t = require(scriptParentParentParent.t)

local LocaleRoactContext = require(scriptParent.LocaleRoactContext)

local Localization = require(scriptParentParentParent.RobloxAppLocales).Localization

local var1 = Roact.Component:extend("LocaleProvider")

var1.validateProps = t.interface({ locale = t.string })

function var1.render(arg1)
    local localization = Localization.new(arg1.props.locale)
    return Roact.createElement(LocaleRoactContext.Provider, { value = localization }, arg1.props[Roact.Children])
end

return var1
