-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local InGameAssetReportingParent = InGameAssetReporting.Parent

local React = require(InGameAssetReportingParent.React)
local UIBlox = require(InGameAssetReportingParent.UIBlox)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local Images = UIBlox.App.ImageSet.Images

local function ScreenshotHighlighter(tbl1)
    local absoluteSize = RobloxGui.AbsoluteSize
    local var1 = (absoluteSize.Y > absoluteSize.X and absoluteSize.X or absoluteSize.Y) / 5

    local var2, var3 = React.useState(false)

    local function func1(arg1, position: vector)
        local var4 = (Vector2.new(position.X, position.Y) - arg1.AbsolutePosition) / arg1.AbsoluteSize
        local var5 = if arg1.AbsoluteSize.X > arg1.AbsoluteSize.Y then arg1.AbsoluteSize.X else arg1.AbsoluteSize.Y
        local var6 = var1 * 0.5 / var5
        tbl1.handleNewAnnotationPoint(var4, var6)
    end

    local function func2(arg1, arg2)
        local bool1 = arg2.UserInputState == Enum.UserInputState.Begin
        local bool2 = arg2.UserInputType == Enum.UserInputType.Touch
        local bool3 = arg2.UserInputType == Enum.UserInputType.MouseButton1
        if not bool1 or not bool2 and not bool3 then
            return
        end

        if #tbl1.annotationPoints < 5 then
            var3(true)
            func1(arg1, arg2.Position)
            return
        end
        tbl1.onExceedMaxAnnotationLimit()
    end

    local function func3(_, _) end

    local function func4(_, _)
        if var2 then
            var3(false)
        end
    end

    local tbl2 = ({})

    for i, annotationPoint in ipairs(tbl1.annotationPoints) do
        local var4 = "point" .. i
        local createElement = React.createElement
        local tbl3 = {
            Position = UDim2.fromScale(annotationPoint.X, annotationPoint.Y),
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(var1, var1)
        }
        local tbl4 = {
            Border = React.createElement(ImageSetButton, {
                Size = UDim2.fromOffset(var1, var1),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Image = Images["component_assets/circle_49_stroke_1"],
                ImageColor3 = Color3.fromHex("#3CF3E9"),
                ImageTransparency = 0,
                BackgroundTransparency = 1
            }),
            Background = React.createElement(ImageSetButton, {
                Size = UDim2.fromOffset(var1, var1),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Image = Images["component_assets/circle_49"],
                ImageColor3 = Color3.fromHex("#3CF3E9"),
                ImageTransparency = 0.6,
                BackgroundTransparency = 1
            })
        }
        tbl2[var4] = createElement("Frame", tbl3, tbl4)
    end

    return React.createElement("Frame", {
        Active = false,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        [React.Event.InputBegan] = func2,
        [React.Event.InputChanged] = func3,
        [React.Event.InputEnded] = func4,
        ZIndex = 3
    }, tbl2)
end

return ScreenshotHighlighter
