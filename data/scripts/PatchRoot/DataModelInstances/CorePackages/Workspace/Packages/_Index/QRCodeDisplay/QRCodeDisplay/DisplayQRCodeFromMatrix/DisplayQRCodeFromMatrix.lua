-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AssetService = game:GetService("AssetService")

local QRCodeDisplayParent = script:FindFirstAncestor("QRCodeDisplay").Parent

local React = require(QRCodeDisplayParent.React)
local Dash = require(QRCodeDisplayParent.Dash)

local drawImage = require(script.Parent.drawImage)

local tbl1 = {
    backgroundColor3 = Color3.fromRGB(255, 255, 255),
    backgroundTransparency = 0,
    pixelColor3 = Color3.fromRGB(0, 0, 0),
    pixelTransparency = 0,
    sideLength = 200
}

local function getQrCodeImageSize(sideLength: number, qrCodeRotation: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    if not qrCodeRotation then
        return sideLength
    end

    assert(type(qrCodeRotation) == "number", "rotation must be a number")
    if qrCodeRotation % 90 == 0 then
        return sideLength
    end

    local num1 = math.rad(qrCodeRotation)
    return math.round(sideLength / (math.sin(num1) + math.cos(num1)))
end

return function(tbl2)
    local var1 = Dash.join(tbl1, tbl2)

    local imageContent, var3 = React.useState(nil)
    local ref = React.createRef()
    local qrCodeImageSize = getQrCodeImageSize(var1.sideLength, var1.qrCodeRotation)

    React.useEffect(function()
        if not ref.current or ref.current.Size.X ~= qrCodeImageSize then
            ref.current = AssetService:CreateEditableImage({ Size = Vector2.new(qrCodeImageSize, qrCodeImageSize) })

            var3(Content.fromObject(ref.current))
        end

        drawImage(ref.current, qrCodeImageSize, var1.qrCodeMatrix, var1.pixelColor3, var1.pixelTransparency)
    end, {
        qrCodeImageSize,
        var1.qrCodeMatrix,
        var1.pixelColor3,
        var1.pixelTransparency
    })
    return React.createElement("Frame", {
        BackgroundColor3 = var1.backgroundColor3,
        BackgroundTransparency = var1.backgroundTransparency,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(var1.sideLength, var1.sideLength)
    }, {
        ImageLabel = React.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            ImageContent = imageContent,
            Position = UDim2.fromScale(0.5, 0.5),
            Rotation = var1.qrCodeRotation,
            Size = UDim2.fromOffset(qrCodeImageSize, qrCodeImageSize)
        })
    })
end
