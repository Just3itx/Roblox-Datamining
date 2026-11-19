-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:35Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local InputSize = require(Foundation.Enums.InputSize)
local Knob = require(Foundation.Components.Knob)
local View = require(Foundation.Components.View)
local colorUtils = require(Foundation.Components.ColorPicker.colorUtils)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local _Types = require(Foundation.Components.Types)

local tbl1 = { showSelectionKnob = true }

local function SVPicker(arg1)
    local var1 = withDefaults(arg1, tbl1)
    local hue = var1.hue
    local saturation = var1.saturation
    local value = var1.value
    local onChanged = var1.onChanged
    local onDragStarted = var1.onDragStarted
    local onDragEnded = var1.onDragEnded
    local var2 = useTokens()

    local backgroundColor3 = hue:map(function(hue2: number): Color3
        return Color3.fromHSV(hue2, 1, 1)
    end)

    local ref = React.useRef(nil)
    local var5 = React.useCallback(function(vector2: Vector2)
        local current = ref.current
        if not current then
            return
        end

        local var5, var6 = colorUtils.calculateSVFromPosition(vector2, current.AbsolutePosition, current.AbsoluteSize)

        onChanged(var5, var6)
    end, { onChanged })

    local var6 = React.useCallback(function(_, vector2: Vector2)
        if onDragStarted then
            onDragStarted()
        end
        var5(vector2)
    end, { var5, onDragStarted })

    local var7 = React.useCallback(function(_, vector2: Vector2)
        var5(vector2)
    end, { var5 })

    local createElement = React.createElement
    local var8 = View
    local var9 = withCommonProps(var1, { tag = "size-full radius-small", ref = ref, ClipsDescendants = true })

    local tbl2 = {
        DragDetector = React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
            [React.Event.DragStart] = var6,
            [React.Event.DragContinue] = var7,
            [React.Event.DragEnd] = onDragEnded
        }),
        Base = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = var2.Color.Extended.White.White_100.Color3,
            ZIndex = 1,
            BorderSizePixel = 0
        }),
        Saturation = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = backgroundColor3,
                ZIndex = 2,
                BorderSizePixel = 0
            },
            {
                Gradient = React.createElement(
                    "UIGradient",
                    {
                        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
                    }
                )
            }
        ),
        Value = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = var2.Color.Extended.Black.Black_100.Color3,
            ZIndex = 3,
            BorderSizePixel = 0
        }, {
            Gradient = React.createElement("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
            })
        }),
        Knob = 0
    }
    local element

    if var1.showSelectionKnob then
        element = React.createElement(Knob, {
            size = InputSize.Medium,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = React.joinBindings({ saturation, value }):map(function(tbl3: {number}): UDim2
                local xScale = tbl3[1]
                local var10 = tbl3[2]
                return UDim2.fromScale(xScale, 1 - var10)
            end),
            style = React.joinBindings({ hue, saturation, value }):map(function(tbl3: {number})
                local hue2 = tbl3[1]
                local saturation2 = tbl3[2]
                local var10 = tbl3[3]
                return {
                    Color3 = Color3.fromHSV(hue2, saturation2, var10),
                    Transparency = 0
                }
            end),
            stroke = {
                Color = var2.Color.System.Contrast.Color3,
                Thickness = var2.Stroke.Thicker,
                Transparency = var2.Color.System.Contrast.Transparency
            },
            hasShadow = true,
            ZIndex = 4
        })
    else
        element = nil
    end

    tbl2.Knob = element
    return createElement(var8, var9, tbl2)
end

return SVPicker
