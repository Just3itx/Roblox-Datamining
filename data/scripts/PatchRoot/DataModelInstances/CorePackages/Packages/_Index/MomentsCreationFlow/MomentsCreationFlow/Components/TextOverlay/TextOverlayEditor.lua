-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local TextService = game:GetService("TextService")

local Dash = require(MomentsCreationFlowParent.Dash)
local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local useBinding = React.useBinding
local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useEffectOnce = require(MomentsCreationFlow.Hooks.useEffectOnce)
local useOnScreenKeyboardHeight = require(MomentsCreationFlow.Hooks.useOnScreenKeyboardHeight)
local useRef = React.useRef
local useState = React.useState
local useTokens = Foundation.Hooks.useTokens

local Knob = Foundation.Knob
local Slider = Foundation.Slider
local View = Foundation.View

local TextOverlay = MomentsCommon.TextOverlay

local function TextOverlayEditor(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local textBoxRef = useRef(nil)
    local size, var5 = useBinding(UDim2.fromOffset(0, 0))
    local var6, var7 = useState(Vector2.new(0, 0))
    local var8 = useOnScreenKeyboardHeight()

    local textOverlayEdit = tbl1.textOverlayEdits and tbl1.textOverlayEdits[1]

    local onActivated = useCallback(function()
        if textBoxRef.current then
            textBoxRef.current:CaptureFocus()
        end
    end, {})

    local onTextChanged = useCallback(function(arg1)
        local var10 = utf8.len(arg1.Text)
        if var10 ~= nil and var10 >= 100 then
            local num1 = utf8.offset(arg1.Text, 101)
            arg1.Text = string.sub(arg1.Text, 1, num1 - 1)
        end
        tbl1.onTextOverlayUpdated({ Dash.joinDeep(textOverlayEdit, { text = arg1.Text }) })
    end, { textOverlayEdit, tbl1.onTextOverlayUpdated })

    local onValueChanged = useCallback(function(fontSize: number)
        if not tbl1.textOverlayEdits then
            return
        end

        local var11 = Dash.joinDeep(textOverlayEdit, { textOverlayStyle = { fontSize = fontSize } })

        tbl1.onTextOverlayUpdated({ var11 })
    end, { tbl1.onTextOverlayUpdated, textOverlayEdit })

    local onAbsoluteSizeChanged = useCallback(function(arg1)
        var7(arg1.AbsoluteSize)
    end, {})

    useEffectOnce(function()
        onActivated()
    end, not (textBoxRef.current == nil) and tbl1.textOverlayEdits ~= nil)

    React.useEffect(function()
        if not textOverlayEdit then
            return
        end

        if var8 == 0 then
            var5(UDim2.fromOffset(0, 0))
        else
            local vector2 = TextService:GetTextSize(
                "W",
                textOverlayEdit.textOverlayStyle.fontSize,
                textOverlayEdit.textOverlayStyle.font,
                Vector2.new(var6.X, var6.Y)
            )

            var5(UDim2.fromOffset(math.min(vector2.X * 30, var6.X / 2), math.min(vector2.Y * 5, var6.Y / 2)))
        end
    end, { var6, textOverlayEdit, var8 })

    if not tbl1.textOverlayEdits then
        return nil
    end

    local createElement = React.createElement
    local var13 = View
    local tbl2 = {
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "bg-over-media-0 size-full",
        ZIndex = tbl1.zIndex or 1
    }
    local tbl3 = { Controls = 0, TextOverlay = 0 }
    local var14

    if var8 == 0 then
        local createElement2 = React.createElement
        local var15 = View

        local tbl4 = {
            Padding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, var2.Padding.XLarge),
                PaddingBottom = UDim.new(0, var2.Padding.XLarge),
                PaddingLeft = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
                PaddingRight = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
            }),
            FontSizeSlider = React.createElement(Slider, {
                knob = React.createElement(Knob, { size = Foundation.Enums.InputSize.Large }),
                knobVisibility = Foundation.Enums.Visibility.Always,
                LayoutOrder = 2,
                onValueChanged = onValueChanged,
                size = Foundation.Enums.InputSize.XSmall,
                range = NumberRange.new(10, 32),
                value = tbl1.textOverlayEdits[1].textOverlayStyle.fontSize,
                variant = Foundation.Enums.SliderVariant.Standard
            })
        }
        var14 = createElement2(var15, { tag = "auto-y anchor-bottom-center col gap-large position-bottom-center size-full-0" }, tbl4)
    else
        var14 = nil
    end

    tbl3.Controls = var14

    tbl3.TextOverlay = React.createElement(TextOverlay, {
        editable = true,
        onActivated = onActivated,
        size = size,
        textOverlayEdit = Dash.joinDeep(textOverlayEdit, { position = UDim2.fromScale(0.5, 0.5), rotation = 0, scale = 1 }),
        onTextChanged = onTextChanged,
        textBoxRef = textBoxRef
    })
    return createElement(var13, tbl2, tbl3)
end

return TextOverlayEditor
