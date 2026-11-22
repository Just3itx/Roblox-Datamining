-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local FFlagMomentsTextOverlayV2Redesign = require(MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign)
local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)
local Responsive = require(MomentsCommonParent.Responsive)
local View = Foundation.View
local Icon = Foundation.Icon
local BuilderIcons = if FFlagMomentsTextOverlayV2Redesign then require(MomentsCommonParent.BuilderIcons) else nil
local useTextOverlayPreviewGestures = require(MomentsCommon.Hooks.useTextOverlayPreviewGestures)

local white = Color3.fromHex("FFFFFF")

local reallyBlack = Color3.fromHex("121215")
local style = {
    Color3 = Color3.fromHex("FFFFFF"),
    Transparency = 0
}

local uDim = UDim.new(1, 0)

local function createBorderCornerHandle(str1: string, onResizeHandleInputBegan: (...any) -> (...any), bool1: boolean)
    local horizontal = React.createElement(
        "Frame",
        {
            AnchorPoint = Vector2.new(if str1 == "TL" or str1 == "BL" then 0 else 1, 0.5),
            BackgroundColor3 = white,
            BorderSizePixel = 0,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(14, 3),
            ZIndex = 10
        },
        {
            Corner = React.createElement("UICorner", { CornerRadius = uDim })
        }
    )
    local vertical = React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, if str1 == "TL" or str1 == "TR" then 0 else 1),
        BackgroundColor3 = white,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(3, 14),
        ZIndex = 10
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = uDim })
    })

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.fromOffset(24, 24),
        ZIndex = 10
    }
    local tbl3 = {
        Horizontal = horizontal,
        Vertical = vertical,
        HitArea = if bool1 then React.createElement("ImageButton", {
            Active = true,
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 11,
            [React.Event.MouseButton1Down] = onResizeHandleInputBegan
        }) else nil
    }
    return createElement(str2, tbl2, tbl3)
end

local function createZeroSizeCornerChrome(str1: string, handle, visible: boolean)
    local var1, scale

    if str1 == "TL" then
        var1 = Vector2.new(0, 0)
        scale = UDim2.fromScale(0, 0)
    elseif str1 == "TR" then
        var1 = Vector2.new(1, 0)
        scale = UDim2.fromScale(1, 0)
    elseif str1 == "BL" then
        var1 = Vector2.new(0, 1)
        scale = UDim2.fromScale(0, 1)
    else
        var1 = Vector2.new(1, 1)
        scale = UDim2.fromScale(1, 1)
    end

    return React.createElement("Frame", {
        AnchorPoint = var1,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = scale,
        Size = UDim2.fromOffset(0, 0),
        Visible = visible,
        ZIndex = 10
    }, { Handle = handle })
end

local function TextOverlaySelectionControls(tbl2)
    local preferredInput = Responsive.usePreferredInput()
    local var2 = useTextOverlayPreviewGestures({
        enabled = true,
        selected = true,
        preferredInput = preferredInput,
        containerRef = tbl2.containerRef,
        scale = tbl2.scale,
        rotation = tbl2.rotation,
        onScaleChanged = tbl2.onScaleChanged,
        onRotationChanged = tbl2.onRotationChanged
    })

    local bool1 = preferredInput == Responsive.Input.Pointer
    local tbl3 = {
        HandleTL = createZeroSizeCornerChrome("TL", createBorderCornerHandle("TL", var2.onResizeHandleInputBegan, bool1), tbl2.visible),
        HandleTR = createZeroSizeCornerChrome("TR", createBorderCornerHandle("TR", var2.onResizeHandleInputBegan, bool1), tbl2.visible),
        HandleBL = createZeroSizeCornerChrome("BL", createBorderCornerHandle("BL", var2.onResizeHandleInputBegan, bool1), tbl2.visible),
        HandleBR = createZeroSizeCornerChrome("BR", createBorderCornerHandle("BR", var2.onResizeHandleInputBegan, bool1), tbl2.visible)
    }

    if bool1 and tbl2.onRotationChanged ~= nil then
        local createElement = React.createElement
        local tbl4 = {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -tbl2.borderGap, 0, tbl2.borderGap),
            Size = UDim2.fromOffset(0, 0),
            Visible = tbl2.visible,
            ZIndex = 10
        }
        local tbl5 = { RotateHandle = 0 }
        local createElement2 = React.createElement
        local var3 = View
        local tbl6 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            backgroundStyle = { Color3 = reallyBlack, Transparency = 0 },
            Position = UDim2.fromOffset(0, -28),
            Size = UDim2.fromOffset(32, 32),
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            tag = "radius-circle",
            ZIndex = 10
        }

        local tbl7 = {
            Glyph = React.createElement(Icon, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                name = BuilderIcons.Icon.ArrowSpinClockwise,
                size = Foundation.Enums.IconSize.Small,
                style = style
            }),
            HitArea = React.createElement("ImageButton", {
                Active = true,
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 11,
                [React.Event.MouseButton1Down] = var2.onRotateHandleInputBegan
            })
        }
        tbl5.RotateHandle = createElement2(var3, tbl6, tbl7)
        tbl3.RotateChrome = createElement("Frame", tbl4, tbl5)
    end

    return React.createElement(React.Fragment, nil, tbl3)
end

return TextOverlaySelectionControls
