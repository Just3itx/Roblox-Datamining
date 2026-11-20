-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local useMotion = require(FoundationParent.Motion).useMotion

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local Components = Foundation.Components
local InputLabel = require(Components.InputLabel)
local _Types = require(Components.Types)
local View = require(Components.View)

local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local InputHint = require(script.Parent.InputHint)
local useInputMotionStates = require(script.Parent.useInputMotionStates)
local useInputVariants = require(script.Parent.useInputVariants)

local getInputTextSize = require(Foundation.Utility.getInputTextSize)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local Constants = require(Foundation.Constants)

local InputSize = require(Foundation.Enums.InputSize)

local _CursorType = require(Foundation.Enums.CursorType)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local tbl1 = {
    size = InputSize.Medium,
    Selectable = true,
    testId = "--foundation-internal-input"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: InternalInput
    local var1 = withDefaults(arg1, tbl1)

    local text = var1.label.text
    local var2 = var1.label.position or Enum.HorizontalAlignment.Right
    local bool1 = if typeof(text) == "string" then #text > 0 else text ~= nil
    local var3 = useTokens()

    local var4 = var1.isChecked or var1.isIndeterminate

    local var5 = useInputVariants(var3, var1.size, var2)

    local var6 = React.useMemo(function()
        return {
            radius = var1.customVariantProps.cursorRadius or UDim.new(0, 0),
            offset = var3.Size.Size_200,
            borderWidth = var3.Stroke.Thicker
        }
    end, { var3, bool1, var1.customVariantProps.cursorRadius })

    local var7 = useInputMotionStates(var3, var1.customVariantProps.colors)

    local var8, var9 = useMotion(var7.Default)

    React.useEffect(function()
        if var4 then
            var9(var7.Checked)
            return
        end
        var9(var7.Default)
    end, { var4, var7 })

    local onActivated = React.useCallback(function()
        if var1.isDisabled then
            return
        end
        var1.onActivated(not var1.isChecked)
    end, { var1.isDisabled, var1.isChecked, var1.onActivated })

    local selection = {
        Selectable = not var1.isDisabled and var1.Selectable,
        NextSelectionUp = var1.NextSelectionUp,
        NextSelectionDown = var1.NextSelectionDown,
        NextSelectionLeft = var1.NextSelectionLeft,
        NextSelectionRight = var1.NextSelectionRight
    }

    local tbl3 = {
        Active = not var1.isDisabled,
        GroupTransparency = if var1.isDisabled then Constants.DISABLED_TRANSPARENCY else 0,
        onActivated = onActivated,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        selection = bool1 and { Selectable = false } or selection,
        cursor = if bool1 then nil else var6,
        isDisabled = var1.isDisabled,
        ref = ref
    }
    local thickness = if var1.customVariantProps.stroke and var1.customVariantProps.stroke.thickness ~= nil then var1.customVariantProps.stroke.thickness else var5.input.stroke.thickness

    local stateLayer = React.useMemo(function()
        return {
            affordance = StateLayerAffordance.None,
            inset = nil,
            mode = nil
        }
    end, {})

    local tbl4 = {
        tag = var1.customVariantProps.tag,
        Size = var1.customVariantProps.size - UDim2.fromOffset(thickness, thickness),
        backgroundStyle = var8.backgroundStyle,
        onActivated = onActivated,
        stateLayer = stateLayer,
        stroke = {
            Color = var8.strokeStyle:map(function(arg2)
                return arg2.Color3
            end),
            Transparency = var8.strokeStyle:map(function(arg2)
                return if var1.isDisabled and not bool1 then Constants.DISABLED_TRANSPARENCY else arg2.Transparency
            end),
            Thickness = thickness,
            BorderStrokePosition = Enum.BorderStrokePosition.Inner
        },
        selection = selection,
        cursor = 0,
        LayoutOrder = 0,
        testId = 0
    }

    if not bool1 then
        var6 = nil
    end

    tbl4.cursor = var6

    tbl4.LayoutOrder = if bool1 then if var2 == Enum.HorizontalAlignment.Left then 1 else -1 else nil
    tbl4.testId = `{var1.testId}--container`

    if not bool1 then
        return React.createElement(View, withCommonProps(var1, Dash.union(tbl3, tbl4)), var1.children)
    end

    local tbl5 = {
        tag = var5.container.tag,
        padding = {
            top = var5.container.padding,
            bottom = var5.container.padding,
            left = if var2 == Enum.HorizontalAlignment.Right then var5.container.padding else nil,
            right = if var2 == Enum.HorizontalAlignment.Left then var5.container.padding else nil
        }
    }

    if typeof(text) == "string" then
        text = React.createElement(InputLabel, {
            Text = text,
            textStyle = var8.labelStyle,
            size = getInputTextSize(var1.size),
            testId = `{var1.testId}--label`
        })
    end

    local createElement = React.createElement
    local var12 = View
    local var13 = withCommonProps(var1, Dash.union(tbl5, tbl3))
    local tbl6 = {
        Input = React.createElement(View, tbl4, var1.children),
        InputLabel = 0
    }

    if var1.label.hint ~= nil and var1.label.hint ~= "" then
        text = React.createElement(View, { tag = "col gap-xxsmall auto-xy" }, {
            InputLabel = text,
            Hint = React.createElement(InputHint, {
                text = var1.label.hint,
                size = getInputTextSize(var1.size),
                testId = `{var1.testId}--hint`,
                LayoutOrder = 2
            })
        })
    end

    tbl6.InputLabel = text
    return createElement(var12, var13, tbl6)
end))
