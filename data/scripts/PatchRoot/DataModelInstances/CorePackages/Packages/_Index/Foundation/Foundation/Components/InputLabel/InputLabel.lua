-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Text = require(Foundation.Components.Text)

local React = require(FoundationParent.React)
local Translator = require(Foundation.Utility.Localization.Translator)

local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local _Types = require(Foundation.Components.Types)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local ControlState = require(Foundation.Enums.ControlState)

local InputLabelSize = require(Foundation.Enums.InputLabelSize)

local function labelText(inputLabel: string, none: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    if none == nil or none == React.None then
        return inputLabel
    elseif none then
        return inputLabel .. " *"
    end

    return (Translator:FormatByKey("CommonUI.Controls.Input.Optional", { inputLabel = inputLabel }))
end

local tbl1 = {
    size = InputLabelSize.Medium,
    testId = "--foundation-input-label"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: InputLabel
    local var1 = withDefaults(arg1, tbl1)
    local var2 = React.useMemo(function(): ((any) -> ())?
        return if var1.onHover == nil then nil else function(hover)
            var1.onHover(hover == ControlState.Hover)
        end
    end, { var1.onHover })

    local createElement = React.createElement
    local var3 = Text
    local var4 = withCommonProps
    local tbl2 = {
        Text = labelText(var1.Text, var1.isRequired),
        RichText = var1.RichText,
        selection = { Selectable = false },
        onActivated = if var1.isDisabled then nil else var1.onActivated,
        onStateChanged = 0,
        stateLayer = 0,
        textStyle = 0,
        tag = 0,
        ref = 0
    }

    if var1.isDisabled then
        var2 = nil
    end

    tbl2.onStateChanged = var2
    tbl2.stateLayer = {
        affordance = StateLayerAffordance.None
    }
    tbl2.textStyle = var1.textStyle
    tbl2.tag = {
        ["size-0 auto-xy text-wrap text-align-x-left text-align-y-top"] = true,
        ["padding-top-xxsmall"] = var1.size ~= InputLabelSize.XSmall,
        ["content-muted"] = var1.isDisabled,
        ["content-emphasis"] = not var1.isDisabled,
        ["text-body-small"] = var1.size == InputLabelSize.Small or var1.size == InputLabelSize.XSmall,
        ["text-body-medium"] = var1.size == InputLabelSize.Medium,
        ["text-body-large"] = var1.size == InputLabelSize.Large
    }
    tbl2.ref = ref
    return createElement(var3, var4(var1, tbl2))
end))
