-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local _ConfigTypes = require(scriptParentParentParent.Configs.ConfigTypes)
local Localization = require(scriptParentParentParentParent.Localization)
local KeyboardAction = require(script.Parent.KeyboardAction)
local FFlagHelpPageCCL = require(scriptParentParentParent.Flags.FFlagHelpPageCCL)

local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local useLocalization = Localization.Hooks.useLocalization

local var1 = React.memo(function(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization({ title = tbl1.title })

    return React.createElement(View, {
        tag = "col align-y-center align-x-left size-full-0 auto-y padding-x-small padding-y-small",
        LayoutOrder = tbl1.LayoutOrder
    }, { React.createElement(FoundationText, {
            tag = {
                ["auto-xy text-title-small text-wrap text-align-x-left"] = FFlagHelpPageCCL,
                ["auto-xy text-title-medium text-wrap text-align-x-left"] = not FFlagHelpPageCCL
            },
            textStyle = var1.Color.Extended.White.White_100,
            Text = var2.title,
            key = "title-text"
        }) })
end)

return React.memo(function(tbl1)
    local var2 = React.useMemo(function()
        local result = {}

        table.insert(
            result,
            React.createElement(var1, { title = tbl1.group.label, LayoutOrder = 0, key = "groupTitle-" .. tbl1.group.id })
        )

        for _, control in tbl1.controls do
            if control.keyboardInput == nil then
                continue
            end

            table.insert(
                result,
                (React.createElement(KeyboardAction, {
                    control = control,
                    LayoutOrder = control.keyboardInput.layoutOrder,
                    key = control.label .. control.keyboardInput.layoutOrder
                }))
            )
        end
        return result
    end, { tbl1.controls, tbl1.group })

    return React.createElement(View, {
        tag = "col align-y-top align-x-center size-full gap-xxsmall",
        LayoutOrder = tbl1.group.layoutOrder,
        testId = "KeyboardGroup"
    }, var2)
end)
