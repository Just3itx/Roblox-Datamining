-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local useKeybinds = require(scriptParentParentParent.Hooks.useKeybinds)
local KeyboardGroup = require(script.Parent.KeyboardGroup)
local _ConfigTypes = require(scriptParentParentParent.Configs.ConfigTypes)
local FFlagHelpPageCCL = require(scriptParentParentParent.Flags.FFlagHelpPageCCL)
local View = Foundation.View

return React.memo(function() -- name: KeyboardHelpPage
    local var1 = useKeybinds()
    local controls = var1.controls
    local groups = var1.groups

    local var2 = React.useMemo(function()
        if controls == nil or groups == nil then
            return nil
        end

        local tbl1 = {}

        for _, group in groups do
            tbl1[group.id] = {
                controls = {},
                group = group
            }
        end

        for k, control in controls do
            if control.keyboardInput == nil then
                continue
            end

            local group = control.keyboardInput.group

            if tbl1[group.id] ~= nil then
                tbl1[group.id].controls[k] = control
            end
        end

        local result = {}

        for _, value in tbl1 do
            if next(value.controls) == nil then
                continue
            end

            table.insert(
                result,
                React.createElement(View, {
                    tag = "auto-y padding-xxsmall",
                    LayoutOrder = value.group.layoutOrder,
                    Size = UDim2.new(1 / 3, -1, 0, 0),
                    key = value.group.id
                }, React.createElement(KeyboardGroup, value))
            )
        end

        return result
    end, { controls, groups })

    if var2 == nil then
        return nil
    end

    return React.createElement(View, {
        tag = {
            ["col wrap align-x-left align-y-top size-full-0 auto-y"] = FFlagHelpPageCCL,
            ["row wrap align-x-left align-y-top size-full-0 auto-y"] = not FFlagHelpPageCCL
        }
    }, var2)
end)
