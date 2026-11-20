-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local ReactRoblox = require(FoundationParent.ReactRoblox)

local InternalDrawerOpenPhase = require(Foundation.Enums.InternalDrawerOpenPhase)
local InternalDrawerSide = require(Foundation.Enums.InternalDrawerSide)
local _Types = require(script.Parent.Types)
local edgeSwipeHandlers = require(script.Parent.edgeSwipeHandlers)
local getTestIdTag = require(Foundation.Utility.getTestIdTag)
local swipeMath = require(script.Parent.swipeMath)
local useHardwareInsets = require(Foundation.Components.Sheet.useHardwareInsets)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local useSwipeSession = require(script.Parent.useSwipeSession)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function InternalDrawerEdgeSwipe(tbl1)
    local var1 = useOverlay()
    local var2 = useHardwareInsets(var1)
    local var3 = useTokens()
    local var4 = React.useRef(nil)
    local edgeWidth = tbl1.config.edgeWidth
    local distanceFraction, velocityThreshold = swipeMath.resolveThresholds(tbl1.config)
    local setPhase = tbl1.setPhase

    local tbl2 = {
        side = tbl1.side,
        travel = tbl1.travel,
        isOpen = tbl1.isOpen,
        distanceFraction = distanceFraction,
        velocityThreshold = velocityThreshold,
        onPress = function()
            setPhase(InternalDrawerOpenPhase.Pressed)
        end,
        onPressEnd = function()
            setPhase(InternalDrawerOpenPhase.Idle)
        end,
        onClaim = function()
            setPhase(InternalDrawerOpenPhase.Dragging)
        end,
        onDragCancel = function()
            setPhase(InternalDrawerOpenPhase.Settling)
        end,
        onCommit = function()
            setPhase(InternalDrawerOpenPhase.Requested)
        end,
        setDrag = tbl1.setDrag
    }
    useSwipeSession(tbl2, function(latest)
        return { gesture = nil, latest = latest, edgeRef = var4 }
    end, edgeSwipeHandlers, not tbl1.isOpen)

    local bool1 = tbl1.side == InternalDrawerSide.End
    local var7 = if var1 then var1:FindFirstAncestorWhichIsA("ScreenGui") else nil
    local xOffset = math.max(
        tbl1.outerBleed,
        if not (var7 == nil) and var7.ScreenInsets == Enum.ScreenInsets.DeviceSafeInsets then if bool1 then var2.right else var2.left else 0
    )

    if edgeWidth == nil then
        edgeWidth = var3.Size.Size_600
    end

    local xOffset2 = edgeWidth + xOffset
    local uDim2 = if bool1 then UDim2.new(1, xOffset, 0, 0) else UDim2.fromOffset(-xOffset, 0)
    local tbl3 = {
        Active = false,
        AnchorPoint = Vector2.new(if bool1 then 1 else 0, 0),
        Size = UDim2.new(0, xOffset2, 1, 0),
        Position = uDim2,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Selectable = false,
        ZIndex = tbl1.zIndex,
        Visible = not tbl1.isOpen,
        ref = var4,
        [React.Tag] = getTestIdTag(tbl1.testId, "edge")
    }

    return var1 and ReactRoblox.createPortal(React.createElement("Frame", tbl3), var1)
end

return InternalDrawerEdgeSwipe
