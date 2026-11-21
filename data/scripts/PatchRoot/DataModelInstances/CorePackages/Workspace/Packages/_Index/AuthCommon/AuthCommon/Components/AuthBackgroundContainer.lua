-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local React = require(AuthCommonParent.React)
local Foundation = require(AuthCommonParent.Foundation)
local Background2026 = require(AuthCommon.Common.AuthBackgroundConstants).Background2026

local function renderScrim(backgroundTransparency: number)
    return React.createElement("ImageLabel", {
        ZIndex = 2,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = backgroundTransparency,
        BorderSizePixel = 0,
        Image = ""
    })
end

local function renderImage(image: string)
    return React.createElement(Foundation.Image, {
        Image = image,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        ScaleType = Enum.ScaleType.Crop
    })
end

local function renderGradientFrame(color3: Color3, yScale: number, zIndex: number, numberSequence: NumberSequence)
    return React.createElement(
        "Frame",
        {
            ZIndex = zIndex,
            Size = UDim2.fromScale(1, yScale),
            BackgroundColor3 = color3,
            BorderSizePixel = 0
        },
        {
            Gradient = React.createElement("UIGradient", { Rotation = 90, Transparency = numberSequence })
        }
    )
end

local function renderMobileFade(image: string, color3: Color3)
    return {
        Media = React.createElement(Foundation.Image, {
            Image = image,
            Size = UDim2.fromScale(1, 0.8870657276995305),
            BorderSizePixel = 0,
            ScaleType = Enum.ScaleType.Crop,
            imageStyle = {
                Color3 = Color3.new(1, 1, 1),
                Transparency = 0.2
            },
            backgroundStyle = {
                Color3 = Color3.new(0, 0, 0),
                Transparency = 0
            }
        }),
        BottomShadow = renderGradientFrame(
            color3,
            397 / 426,
            2,
            NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.2418, 1),
                NumberSequenceKeypoint.new(0.8588, 0),
                NumberSequenceKeypoint.new(1, 0)
            })
        ),
        NavCover = renderGradientFrame(
            Color3.new(0, 0, 0),
            271 / 852,
            3,
            NumberSequence.new(
                { NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(0.2447, 0.3), NumberSequenceKeypoint.new(1, 0.817) }
            )
        )
    }
end

local function AuthBackgroundContainer(tbl1)
    local bool1 = Background2026.SCRIM_TRANSPARENCY < 1
    local var1 = tbl1.showImage == nil or tbl1.showImage
    local mobileFadeColor = if var1 then tbl1.mobileFadeColor else nil
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = if var1 and not mobileFadeColor then 1 else 0,
        BackgroundColor3 = mobileFadeColor or tbl1.fallbackBackgroundColor
    }
    local tbl3 = if mobileFadeColor then renderMobileFade(Background2026.IMAGE, mobileFadeColor) else {
        Background = if var1 then renderImage(Background2026.IMAGE) else nil,
        Scrim = if var1 and bool1 then renderScrim(Background2026.SCRIM_TRANSPARENCY) else nil
    }
    return createElement(str1, tbl2, tbl3)
end

return AuthBackgroundContainer
