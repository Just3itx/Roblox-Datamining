-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local FFlagAmpV2WizardCodeInputAspectRatio = require(AmpV2Wizard.FFlagAmpV2WizardCodeInputAspectRatio)

local function noop(_: string) end

local function CodeInput(tbl1)
    local value = tbl1.value
    local onChanged = tbl1.onChanged
    local var1 = tbl1.onComplete or noop
    local isMasked = tbl1.isMasked
    local length = tbl1.length or 6
    local var2 = useTokens()

    local var3, var4 = React.useState(false)
    local ref = React.useRef(nil)
    local var6 = React.useRef("")
    local var7, var8

    if FFlagAmpV2WizardCodeInputAspectRatio then
        local var9
        var7, var9 = React.useBinding(64)
        var8 = React.useCallback(function(arg1)
            var9(math.round(arg1.AbsoluteSize.X * (4 / 3)))
        end, {})
    else
        var8 = nil
        var7 = nil
    end

    local var9 = React.useCallback(function()
        local current = ref.current
        if current == nil or UserInputService.OnScreenKeyboardVisible and UserInputService:GetFocusedTextBox() == current then
            return
        end

        current:ReleaseFocus()
        task.defer(function()
            local current2 = ref.current
            if current2 ~= nil then
                current2:CaptureFocus()
            end
        end)
    end, {})

    local releaseFocus = React.useCallback(function()
        local current = ref.current
        if current ~= nil then
            current:ReleaseFocus()
        end
    end, {})

    React.useImperativeHandle(tbl1.controlRef, function()
        return { focus = var9, releaseFocus = releaseFocus }
    end, { var9, releaseFocus })

    React.useEffect(function()
        var9()
    end, { var9 })

    local var11 = React.useCallback(function(arg1)
        local var11 = arg1.Text:gsub("%D", "")
        if #var11 > length then
            var11 = var11:sub(1, length)
        end

        if arg1.Text ~= var11 then
            arg1.Text = var11
        end

        if var11 == var6.current then
            return
        end
        var6.current = var11

        onChanged(var11)

        if #var11 == length then
            arg1:ReleaseFocus()
            var1(var11)
        end
    end, { onChanged, var1, length })

    local tbl2 = ({})
    for layoutOrder = 1, length do
        local var12 = value:sub(layoutOrder, layoutOrder)
        local bool1 = var12 ~= ""
        local var13 = var3 and layoutOrder == #value + 1

        local str1 = `Box_{layoutOrder}`
        local createElement = React.createElement
        local var14 = View
        local tbl3 = {
            tag = "col align-x-center align-y-center gap-small size-0-full padding-small radius-medium bg-shift-200",
            flexItem = {
                FlexMode = Enum.UIFlexMode.Fill
            },
            onAbsoluteSizeChanged = if FFlagAmpV2WizardCodeInputAspectRatio then if layoutOrder == 1 then var8 else nil else nil,
            LayoutOrder = layoutOrder,
            onActivated = var9,
            stroke = if var13 then {
                Color = var2.Color.System.Emphasis.Color3,
                Transparency = var2.Color.System.Emphasis.Transparency,
                Thickness = var2.Stroke.Thick
            } else nil,
            testId = "code-input-box"
        }

        local tbl5 = {
            Digit = if bool1 and not isMasked then React.createElement(FoundationText, { Text = var12, tag = "auto-xy text-title-large content-emphasis" }) else nil,
            Dot = if bool1 and isMasked then React.createElement(
                View,
                {
                    tag = "radius-circle",
                    Size = UDim2.fromOffset(8, 8),
                    backgroundStyle = var2.Color.Content.Emphasis
                }
            ) else nil
        }
        tbl2[str1] = createElement(var14, tbl3, tbl5)
    end

    local createElement = React.createElement
    local var12 = View

    local tbl3 = {
        tag = "size-full-0",
        Size = if FFlagAmpV2WizardCodeInputAspectRatio and var7 ~= nil then var7:map(function(yOffset: number): UDim2
            return UDim2.new(1, 0, 0, yOffset)
        end) else UDim2.new(1, 0, 0, 64),
        LayoutOrder = tbl1.LayoutOrder
    }

    local tbl4 = {
        Boxes = React.createElement(View, { tag = "row gap-medium size-full" }, tbl2),
        HiddenInput = 0
    }

    local createElement2 = React.createElement
    local tbl5 = {
        Size = UDim2.fromOffset(1, 1),
        BackgroundTransparency = 1,
        TextTransparency = 1,
        TextSize = 1,
        Text = value,
        ClearTextOnFocus = false,
        ManualFocusRelease = true,
        OverlayNativeInput = true,
        TextInputType = Enum.TextInputType.Number,
        ref = ref,
        [React.Change.Text] = var11
    }

    tbl5[React.Event.Focused] = function()
        var4(true)
    end
    tbl5[React.Event.FocusLost] = function()
        var4(false)
    end

    tbl4.HiddenInput = createElement2("TextBox", tbl5)
    return createElement(var12, tbl3, tbl4)
end

return CodeInput
