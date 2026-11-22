-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local useDeviceInsets = require(SplitPaneParent.Responsive).useDeviceInsets

local function dimPanel(str1: string, uDim2: UDim2, uDim2_2: UDim2, backgroundTransparency: number?)
    return React.createElement("TextButton", {
        Name = str1,
        Position = uDim2,
        Size = uDim2_2,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = backgroundTransparency or 0.5,
        BorderSizePixel = 0,
        Active = true,
        AutoButtonColor = false,
        Selectable = false,
        Text = ""
    })
end

local function spotlightRing(xOffset: number, yOffset: number, num1: number, num2: number, offset: number)
    return React.createElement("Frame", {
        Name = "SpotlightRing",
        Position = UDim2.fromOffset(xOffset, yOffset),
        Size = UDim2.fromOffset(num1 - xOffset, num2 - yOffset),
        BackgroundTransparency = 1,
        ZIndex = 2
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, offset) }),
        Stroke = React.createElement("UIStroke", { Color = Color3.new(1, 1, 1), Transparency = 0.7, Thickness = 1 })
    })
end

local function cornerDim(str1: string, uDim2: UDim2, uDim2_2: UDim2, offset: number)
    return React.createElement("TextButton", {
        Name = str1,
        Position = uDim2,
        Size = UDim2.fromOffset(offset, offset),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Active = true,
        AutoButtonColor = false,
        Selectable = false,
        Text = ""
    }, {
        Mask = React.createElement("ImageLabel", {
            Image = "rbxasset://textures/ui/AvatarExperience/CircleCutoutLargeNoBorder.png",
            ImageColor3 = Color3.new(0, 0, 0),
            ImageTransparency = 0.5,
            Position = uDim2_2,
            Size = UDim2.fromOffset(offset * 2, offset * 2),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        })
    })
end

local function SplitPaneEducationalTourScrim(tbl1)
    local var1 = useDeviceInsets()
    local var2

    if tbl1.targetRect == nil then
        var2 = nil
    else
        var2 = Rect.new(
            tbl1.targetRect.Min.X + var1.left,
            tbl1.targetRect.Min.Y + var1.top,
            tbl1.targetRect.Max.X + var1.left,
            tbl1.targetRect.Max.Y + var1.top
        )
    end

    local tbl2

    if var2 == nil and tbl1.dimEndX ~= nil then
        tbl2 = {
            HomeDim = dimPanel("HomeDim", UDim2.fromScale(0, 0), UDim2.new(0, tbl1.dimEndX + var1.left, 1, 0))
        }
    elseif var2 == nil then
        tbl2 = {
            Dim = dimPanel("Dim", UDim2.fromScale(0, 0), UDim2.fromScale(1, 1), if tbl1.isTransparent then 1 else nil)
        }
    else
        local minX = var2.Min.X
        local minY = var2.Min.Y
        local maxX = var2.Max.X
        local maxY = var2.Max.Y
        local offset = math.min(maxX - minX, maxY - minY) / 2

        tbl2 = {
            Top = dimPanel("Top", UDim2.fromOffset(0, 0), UDim2.new(1, 0, 0, minY)),
            Bottom = dimPanel("Bottom", UDim2.new(0, 0, 0, maxY), UDim2.new(1, 0, 1, -maxY)),
            Left = dimPanel("Left", UDim2.new(0, 0, 0, minY), UDim2.new(0, minX, 0, maxY - minY)),
            Right = dimPanel("Right", UDim2.new(0, maxX, 0, minY), UDim2.new(1, -maxX, 0, maxY - minY)),
            TopLeftCorner = cornerDim("TopLeftCorner", UDim2.fromOffset(minX, minY), UDim2.fromOffset(0, 0), offset),
            TopRightCorner = cornerDim("TopRightCorner", UDim2.fromOffset(maxX - offset, minY), UDim2.fromOffset(-offset, 0), offset),
            BottomLeftCorner = cornerDim("BottomLeftCorner", UDim2.fromOffset(minX, maxY - offset), UDim2.fromOffset(0, -offset), offset),
            BottomRightCorner = cornerDim(
                "BottomRightCorner",
                UDim2.fromOffset(maxX - offset, maxY - offset),
                UDim2.fromOffset(-offset, -offset),
                offset
            ),
            SpotlightRing = spotlightRing(minX, minY, maxX, maxY, offset)
        }
    end

    return React.createElement("Frame", {
        Name = "SplitPaneEducationalTourScrim",
        Position = UDim2.fromOffset(-var1.left, -var1.top),
        Size = UDim2.new(1, var1.left + var1.right, 1, var1.top + var1.bottom),
        BackgroundTransparency = 1
    }, tbl2)
end

return SplitPaneEducationalTourScrim
