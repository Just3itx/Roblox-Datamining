-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local Cryo = require(AppBloxParent.Cryo)
local Display = require(AppBloxParent.Display)
local useSignalState = require(AppBloxParent.SignalsReact).useSignalState
local useTokens = require(AppBloxParent.Foundation).Hooks.useTokens

local function InsetBackground(tbl1)
    local var1 = useSignalState(Display.GetDisplayStore().getGuiInset)
    local var2 = tbl1.excludeGlobalGuiInset and { left = 0, top = 0, right = 0, bottom = 0 } or var1

    local var3 = useSignalState(Display.GetDisplayStore().getDeviceSafePadding)
    local var4 = useTokens()

    local var5 = Cryo.Dictionary.join({
        BackgroundTransparency = var4.Color.Surface.Surface_0.Transparency,
        BackgroundColor3 = var4.Color.Surface.Surface_0.Color3,
        BorderSizePixel = 0
    }, tbl1.frameProps or {})

    local xOffset = var2.left + var3.left
    local xOffset2 = var2.right + var3.right
    local yOffset = var2.top + var3.top
    local yOffset2 = var2.bottom + var3.bottom

    local var6 = Cryo.Dictionary.join({
        Position = UDim2.new(0, if tbl1.directions.left then -xOffset else 0, 0, -yOffset),
        Size = UDim2.new(
            1,
            (if tbl1.directions.left then xOffset else 0) + (if tbl1.directions.right then xOffset2 else 0),
            0,
            yOffset
        )
    }, Cryo.Dictionary.join(var5, tbl1.topFrameProps or {}))
    local var7 = Cryo.Dictionary.join({
        Position = UDim2.new(0, if tbl1.directions.left then -xOffset else 0, 1, 0),
        Size = UDim2.new(
            1,
            (if tbl1.directions.left then xOffset else 0) + (if tbl1.directions.right then xOffset2 else 0),
            0,
            yOffset2
        )
    }, Cryo.Dictionary.join(var5, tbl1.bottomFrameProps or {}))
    local var8 = Cryo.Dictionary.join({
        Position = UDim2.new(0, -xOffset, 0, if tbl1.directions.top then -yOffset else 0),
        Size = UDim2.new(
            0,
            xOffset,
            1,
            (if tbl1.directions.top then yOffset else 0) + (if tbl1.directions.bottom then yOffset2 else 0)
        )
    }, Cryo.Dictionary.join(var5, tbl1.leftFrameProps or {}))
    local var9 = Cryo.Dictionary.join({
        Position = UDim2.new(1, 0, 0, if tbl1.directions.top then -yOffset else 0),
        Size = UDim2.new(
            0,
            xOffset2,
            1,
            (if tbl1.directions.top then yOffset else 0) + (if tbl1.directions.bottom then yOffset2 else 0)
        )
    }, Cryo.Dictionary.join(var5, tbl1.rightFrameProps or {}))

    return React.createElement(React.Fragment, nil, {
        InsetBackgroundTop = if tbl1.directions.top and yOffset > 0 then React.createElement("Frame", var6) else nil,
        InsetBackgroundBottom = if tbl1.directions.bottom and yOffset2 > 0 then React.createElement("Frame", var7) else nil,
        InsetBackgroundLeft = if tbl1.directions.left and xOffset > 0 then React.createElement("Frame", var8) else nil,
        InsetBackgroundRight = if tbl1.directions.right and xOffset2 > 0 then React.createElement("Frame", var9) else nil
    })
end

return InsetBackground
