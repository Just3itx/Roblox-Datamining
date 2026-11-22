-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:10:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local TextService = game:GetService("TextService")

local FFlagMomentsTextOverlayFixedContrast = require(MomentsCommon.Flags.FFlagMomentsTextOverlayFixedContrast)

local FFlagMomentsTextOverlayChipGrowAboveKeyboard = require(MomentsCommon.Flags.FFlagMomentsTextOverlayChipGrowAboveKeyboard)
local FFlagMomentsTextOverlayEdgeClipFix = require(MomentsCommon.Flags.FFlagMomentsTextOverlayEdgeClipFix)
local FFlagMomentsTextOverlayV2Redesign = require(MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign)
local GetFFlagMomentsStickerButton = require(MomentsCommon.Flags.GetFFlagMomentsStickerButton)
local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)
local Responsive = require(MomentsCommonParent.Responsive)
local View = Foundation.View

local useCallback = React.useCallback
local useState = React.useState

local _MomentsTypes = require(MomentsCommonParent.MomentsTypes)
local TextOverlaySelectionControls = require(MomentsCommon.Components.TextOverlaySelectionControls)
local insertNewlineAtCursor = require(MomentsCommon.Utils.insertNewlineAtCursor)

local tbl1 = {
    [Enum.Font.LuckiestGuy] = 0.12
}

local tbl2 = {
    [Enum.Font.Bangers] = 0.08
}

local white = Color3.fromHex("FFFFFF")

local function composeScale(scale: number, additionalScale) -- Luacid: Inlined by compiler; 1 call site recovered
    if additionalScale == nil then
        return scale
    elseif typeof(additionalScale) == "number" then
        return scale * additionalScale
    end
    return additionalScale:map(function(num1: number): number
        return scale * num1
    end)
end

local function TextOverlay(tbl3)
    local var1 = if GetFFlagMomentsStickerButton() then tbl3.overlayEdit or tbl3.textOverlayEdit else tbl3.textOverlayEdit
    local contrast = if FFlagMomentsTextOverlayFixedContrast then Foundation.Hooks.useTokens().DarkMode.System.Contrast else nil
    local var2 = nil
    local var3 = nil
    local var4, var5

    if FFlagMomentsTextOverlayV2Redesign then
        local var6
        var2, var6 = useState(false)
        var3 = var6

        var4 = Responsive.usePreferredInput()

        var5 = React.useBinding(0)
    else
        var4 = nil
        var5 = nil
    end
    local ref = React.useRef(nil)
    local var7 = React.useRef(nil)

    local var8 = useCallback(function(_, vector2: Vector2)
        if tbl3.containerRef and tbl3.containerRef.current then
            var7.current = vector2
        end

        if var3 and tbl3.selected == true then
            var3(true)
        end
        if tbl3.onDragBegin then
            tbl3.onDragBegin()
        end
    end, { tbl3.containerRef, tbl3.onDragBegin, tbl3.selected })

    local var9 = useCallback(function(_, vector2: Vector2)
        if tbl3.onDragContinue then
            tbl3.onDragContinue(vector2)
        end
    end, { tbl3.onDragContinue })

    local var10 = useCallback(function(_, vector2: Vector2)
        if var7.current == vector2 and tbl3.onActivated then
            tbl3.onActivated()
        end

        if tbl3.onDragEnd then
            tbl3.onDragEnd()
        end
        if var3 and tbl3.selected == true then
            var3(false)
        end
    end, { tbl3.onActivated, tbl3.onDragEnd, tbl3.selected })

    local uiDragDetector = React.useMemo(function()
        if not tbl3.draggable then
            return nil
        end

        return React.createElement("UIDragDetector", {
            BoundingBehavior = Enum.UIDragDetectorBoundingBehavior.EntireObject,
            BoundingUI = tbl3.boundingUI,
            DragStyle = Enum.UIDragDetectorDragStyle.TranslatePlane,
            ref = ref,
            ReferenceUIInstance = tbl3.referenceUI or tbl3.boundingUI,
            ResponseStyle = Enum.UIDragDetectorResponseStyle.Scale,
            [React.Event.DragStart] = var8,
            [React.Event.DragContinue] = var9,
            [React.Event.DragEnd] = var10
        })
    end, {
        tbl3.boundingUI,
        tbl3.draggable,
        tbl3.referenceUI,
        var8,
        var9,
        var10
    })

    local size = tbl3.size
    local element = if FFlagMomentsTextOverlayV2Redesign and tbl3.editable == true then React.createElement("UISizeConstraint", { MaxSize = Vector2.new(300, math.huge) }) else nil
    local var12 = if FFlagMomentsTextOverlayV2Redesign then tbl1[var1.textOverlayStyle.font] else nil
    local offset = if var12 then math.ceil(var1.textOverlayStyle.fontSize * var12) else 0
    local bool1 = if tbl3.fitToContent ~= nil then tbl3.fitToContent else tbl3.size == nil
    local offset2 = 0
    local var13

    if FFlagMomentsTextOverlayV2Redesign and bool1 then
        local var14 = tbl2[var1.textOverlayStyle.font] or 0.03

        var13 = math.ceil(var1.textOverlayStyle.fontSize * var14)

        if FFlagMomentsTextOverlayEdgeClipFix then
            offset2 = math.ceil(
                TextService:GetTextSize(" ", var1.textOverlayStyle.fontSize, var1.textOverlayStyle.font, Vector2.new(1000000, 1000000)).X
            )
        end

        local x = 276 - var13 - offset2 * 2
        local vector2 = TextService:GetTextSize(var1.text, var1.textOverlayStyle.fontSize, var1.textOverlayStyle.font, Vector2.new(x, 1000000))

        size = UDim2.fromOffset(math.ceil(vector2.X) + var13 + offset2 * 2, math.ceil(vector2.Y) + offset)
        element = nil
    else
        var13 = 0
    end

    local offset3 = var13 + offset2
    local element2 = if var12 or offset3 > 0 then React.createElement("UIPadding", {
        PaddingLeft = if offset2 > 0 then UDim.new(0, offset2) else nil,
        PaddingTop = if var12 then UDim.new(0, offset) else nil,
        PaddingRight = if offset3 > 0 then UDim.new(0, offset3) else nil
    }) else nil
    local bool2 = FFlagMomentsTextOverlayV2Redesign and FFlagMomentsTextOverlayChipGrowAboveKeyboard

    if bool2 then
        if tbl3.editable == true then
            bool2 = var4 == Responsive.Input.Touch
        else
            bool2 = false
        end
    end

    local var14 = useCallback(function(arg1)
        local text = arg1.Text
        task.defer(function()
            if arg1.Parent == nil or arg1.Text ~= text then
                return
            end
            local var14, cursorPosition = insertNewlineAtCursor(arg1.Text, arg1.CursorPosition)
            arg1.Text = var14
            arg1.CursorPosition = cursorPosition
        end)
    end, {})

    local createElement = React.createElement
    local str1 = "TextBox"
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        ClipsDescendants = true,
        Font = var1.textOverlayStyle.font,
        Interactable = tbl3.editable == true,
        MultiLine = FFlagMomentsTextOverlayV2Redesign and tbl3.editable == true,
        ManualFocusRelease = if bool2 then true else nil,
        ShouldEmitReturnEvents = if bool2 then true else nil
    }
    local returnPressedFromOnScreenKeyboard = React.Event.ReturnPressedFromOnScreenKeyboard

    if not bool2 then
        var14 = nil
    end

    tbl4[returnPressedFromOnScreenKeyboard] = var14

    tbl4.Text = var1.text
    tbl4.TextColor3 = var1.textOverlayStyle.fontColor
    tbl4.TextSize = var1.textOverlayStyle.fontSize
    tbl4.TextXAlignment = var1.textOverlayStyle.textXAlignment
    tbl4.TextYAlignment = Enum.TextYAlignment.Center
    tbl4.TextWrapped = true
    tbl4.Selectable = tbl3.editable == true
    tbl4.Size = size
    tbl4.Visible = not (tbl3.textVisible == false) and nil
    tbl4.ZIndex = var1.zIndex
    tbl4.ref = tbl3.textBoxRef
    tbl4[React.Change.Text] = tbl3.onTextChanged
    local textInput = createElement(str1, tbl4, { WrapWidth = element, FontQuirkPadding = element2 })

    local tbl5 = {
        ref = tbl3.containerRef,
        onActivated = tbl3.onActivated,
        onAbsoluteSizeChanged = tbl3.onAbsoluteSizeChanged,
        Position = var1.position,
        Rotation = var1.rotation,
        scale = composeScale(var1.scale, tbl3.additionalScale),
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        ZIndex = var1.zIndex
    }
    local vector2 = Vector2.new(300, math.huge)

    if not FFlagMomentsTextOverlayV2Redesign or tbl3.selected ~= true then
        if not FFlagMomentsTextOverlayV2Redesign then
            tbl5.tag = "position-center-center anchor-center-center auto-xy padding-medium radius-medium bg-contrast"
            tbl5.sizeConstraint = { MaxSize = vector2 }
            if FFlagMomentsTextOverlayFixedContrast then
                tbl5.backgroundStyle = contrast
                tbl5.tag = "position-center-center anchor-center-center auto-xy padding-medium radius-medium"
            end
            return React.createElement(View, tbl5, { UIDragDetector = uiDragDetector, TextInput = textInput })
        end

        local tbl6 = {
            GroupTransparency = var5,
            scale = tbl5.scale,
            sizeConstraint = { MaxSize = vector2 },
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            tag = "auto-xy padding-medium radius-medium bg-contrast"
        }

        if FFlagMomentsTextOverlayFixedContrast then
            tbl6.backgroundStyle = contrast
            tbl6.tag = "auto-xy padding-medium radius-medium"
        end
        local chip = React.createElement(View, tbl6, { TextInput = textInput })

        tbl5.scale = nil
        tbl5.tag = "position-center-center anchor-center-center auto-xy"
        return React.createElement(View, tbl5, { UIDragDetector = uiDragDetector, Chip = chip })
    end

    local visible = var4 == Responsive.Input.Pointer and not var2
    local tbl6 = {
        GroupTransparency = var5,
        scale = tbl5.scale,
        sizeConstraint = { MaxSize = vector2 },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "auto-xy padding-medium radius-medium bg-contrast"
    }

    if FFlagMomentsTextOverlayFixedContrast then
        tbl6.backgroundStyle = contrast
        tbl6.tag = "auto-xy padding-medium radius-medium"
    end
    local chip = React.createElement(View, tbl6, { TextInput = textInput })

    local Selection = React.createElement(View, {
        padding = {
            bottom = UDim.new(0, 4),
            left = UDim.new(0, 4),
            right = UDim.new(0, 4),
            top = UDim.new(0, 4)
        },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        stroke = {
            Color = white,
            Thickness = 1.5,
            Transparency = if visible then 0.45 else 1
        },
        tag = "auto-xy radius-medium",
        ZIndex = 1
    }, { Chip = chip })

    tbl5.scale = nil
    tbl5.tag = "position-center-center anchor-center-center auto-xy"
    return React.createElement(View, tbl5, {
        UIDragDetector = uiDragDetector,
        Selection = Selection,
        SelectionControls = React.createElement(TextOverlaySelectionControls, {
            borderGap = 4,
            containerRef = tbl3.containerRef,
            onRotationChanged = tbl3.onRotationChanged,
            onScaleChanged = tbl3.onScaleChanged,
            rotation = var1.rotation,
            scale = var1.scale,
            visible = visible
        })
    })
end
return TextOverlay
