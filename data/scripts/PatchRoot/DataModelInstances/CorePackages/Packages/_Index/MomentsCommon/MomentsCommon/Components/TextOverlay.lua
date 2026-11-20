-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)
local View = Foundation.View

local useCallback = React.useCallback

local _Types = require(MomentsCommon.Types)

local function TextOverlay(tbl1)
    local ref = React.useRef(nil)
    local var2 = React.useRef(nil)

    local var3 = useCallback(function(_, vector2: Vector2)
        if tbl1.containerRef and tbl1.containerRef.current then
            var2.current = vector2
        end
    end, { tbl1.containerRef })

    local var4 = useCallback(function(_, vector2: Vector2)
        if var2.current == vector2 and tbl1.onActivated then
            tbl1.onActivated()
        end

        if tbl1.onDragEnd then
            tbl1.onDragEnd()
        end
    end, { tbl1.onActivated, tbl1.onDragEnd })

    local uiDragDetector = React.useMemo(function()
        if not tbl1.draggable then
            return nil
        end

        return React.createElement("UIDragDetector", {
            BoundingBehavior = Enum.UIDragDetectorBoundingBehavior.EntireObject,
            BoundingUI = tbl1.boundingUI,
            DragStyle = Enum.UIDragDetectorDragStyle.TranslatePlane,
            ref = ref,
            ReferenceUIInstance = tbl1.boundingUI,
            ResponseStyle = Enum.UIDragDetectorResponseStyle.Scale,
            [React.Event.DragStart] = var3,
            [React.Event.DragEnd] = var4
        })
    end, {
        tbl1.boundingUI,
        tbl1.draggable,
        var3,
        var4
    })
    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        ref = tbl1.containerRef,
        onActivated = tbl1.onActivated,
        Position = tbl1.textOverlayEdit.position,
        Rotation = tbl1.textOverlayEdit.rotation,
        scale = tbl1.textOverlayEdit.scale * (tbl1.additionalScale or 1),
        sizeConstraint = {
            MaxSize = Vector2.new(300, math.huge)
        },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "auto-xy anchor-center-center bg-contrast padding-medium position-center-center radius-medium",
        ZIndex = tbl1.textOverlayEdit.zIndex
    }
    local tbl3 = {
        UIDragDetector = uiDragDetector,
        TextInput = React.createElement("TextBox", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            ClearTextOnFocus = false,
            ClipsDescendants = true,
            Font = tbl1.textOverlayEdit.textOverlayStyle.font,
            Interactable = tbl1.editable == true,
            Text = tbl1.textOverlayEdit.text,
            TextColor3 = tbl1.textOverlayEdit.textOverlayStyle.fontColor,
            TextSize = tbl1.textOverlayEdit.textOverlayStyle.fontSize,
            TextXAlignment = tbl1.textOverlayEdit.textOverlayStyle.textXAlignment,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextWrapped = true,
            Size = tbl1.size,
            ZIndex = tbl1.textOverlayEdit.zIndex,
            ref = tbl1.textBoxRef,
            [React.Change.Text] = tbl1.onTextChanged
        })
    }
    return createElement(var6, tbl2, tbl3)
end

return TextOverlay
