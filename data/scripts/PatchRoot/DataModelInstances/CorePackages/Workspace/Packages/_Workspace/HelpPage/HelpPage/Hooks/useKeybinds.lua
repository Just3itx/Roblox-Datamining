-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local _ConfigTypes = require(scriptParentParent.Configs.ConfigTypes)
local KeybindContext = require(scriptParentParent.Context.KeybindContext)
local useAbilities = require(script.Parent.useAbilities)
local FFlagHelpPageCCL = require(scriptParentParent.Flags.FFlagHelpPageCCL)

return function()
    local var1 = React.useContext(KeybindContext)
    local var2 = if FFlagHelpPageCCL then useAbilities() else nil

    if var2 == nil or var1.controls == nil then
        return var1
    end

    local controls = ({})
    for k, control in var1.controls do
        if k ~= "Jump" then
            controls[k] = control
        end
    end
    for value, value2 in var2 do
        controls[value] = value2
    end

    return {
        groups = var1.groups,
        controls = controls,
        abilitiesAvailable = true
    }
end
