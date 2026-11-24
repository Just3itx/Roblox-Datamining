-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local KeybindContext = require(script.Parent.KeybindContext)
local BindingConfigs = require(scriptParentParent.Configs.BindingConfigs)

return React.memo(function(tbl1)
    local groups, _ = React.useState(BindingConfigs.ControlGroups)
    local controls, _ = React.useState(BindingConfigs.Controls)

    return React.createElement(KeybindContext.Provider, { value = { groups = groups, controls = controls } }, tbl1.children)
end)
