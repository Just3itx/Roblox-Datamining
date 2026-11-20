-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local Roact = require(CorePackages.Packages.Roact)
local _RoactRodux = require(CorePackages.Packages.RoactRodux)
local _Images = require(CorePackages.Packages.UIBlox).App.ImageSet.Images

local var1 = Roact.PureComponent:extend("WatermarkComponent")
local PolicyService = game:GetService("PolicyService")

function var1.init(arg1)
    local function UpdateWatermarkVisibility()
        local var2 = arg1
        local tbl1 = { watermarkVisible = 0 }
        local bool1 = not RunService:IsStudio()

        if bool1 then
            if PolicyService.IsLuobuServer == Enum.TriStateBoolean.True then
                bool1 = PolicyService.LuobuWhitelisted == Enum.TriStateBoolean.False
            else
                bool1 = false
            end
        end

        tbl1.watermarkVisible = bool1
        var2:setState(tbl1)
    end

    PolicyService:GetPropertyChangedSignal("IsLuobuServer"):connect(function()
        UpdateWatermarkVisibility()
    end)

    PolicyService:GetPropertyChangedSignal("LuobuWhitelisted"):connect(function()
        UpdateWatermarkVisibility()
    end)

    arg1:setState({ absoluteSize = Vector2.new(0, 0), watermarkVisible = false })

    function arg1.onAbsoluteSizeChange(arg2)
        arg1:setState({ absoluteSize = arg2.AbsoluteSize })
    end

    UpdateWatermarkVisibility()
end

function var1.render(arg1)
    local function CalculateRotatedFrameWidth() -- Luacid: Inlined by compiler; 3 call sites recovered
        return arg1.state.absoluteSize.X * 0.9681476403781077 + arg1.state.absoluteSize.Y * 0.25038000405444144
    end

    local function CalculateRotatedFrameHeight() -- Luacid: Inlined by compiler; 3 call sites recovered
        return arg1.state.absoluteSize.Y * 0.9681476403781077 + arg1.state.absoluteSize.X * 0.25038000405444144
    end

    local function CreateGridItems()
        local num1 = math.ceil(CalculateRotatedFrameWidth() / 450)
        local num2 = math.ceil(CalculateRotatedFrameHeight() / 450)
        local gridItems = {}
        for i = 0, num2 - 1 do
            for j = 0, num1 - 1 do
                table.insert(
                    gridItems,
                    Roact.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        TextTransparency = 0.75,
                        Text = "仅用于测试，\n非正式发表。",
                        TextSize = 30,
                        TextColor3 = Color3.new(1, 1, 1),
                        Size = UDim2.new(0, 225, 0, 225),
                        Position = UDim2.new(0, j * 450, 0, i * 450)
                    })
                )
                table.insert(
                    gridItems,
                    Roact.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        TextTransparency = 0.91,
                        Text = "仅用于测试，\n非正式发表。",
                        TextSize = 30,
                        TextColor3 = Color3.new(0, 0, 0),
                        Size = UDim2.new(0, 225, 0, 225),
                        Position = UDim2.new(0, j * 450 + 1, 0, i * 450 + 1)
                    })
                )
                table.insert(
                    gridItems,
                    Roact.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        TextTransparency = 0.75,
                        Text = "仅用于测试，\n非正式发表。",
                        TextSize = 30,
                        TextColor3 = Color3.new(1, 1, 1),
                        Size = UDim2.new(0, 225, 0, 225),
                        Position = UDim2.new(0, j * 450 + 225, 0, i * 450 + 225)
                    })
                )
                table.insert(
                    gridItems,
                    Roact.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        TextTransparency = 0.91,
                        Text = "仅用于测试，\n非正式发表。",
                        TextSize = 30,
                        TextColor3 = Color3.new(0, 0, 0),
                        Size = UDim2.new(0, 225, 0, 225),
                        Position = UDim2.new(0, j * 450 + 226, 0, i * 450 + 226)
                    })
                )
            end
        end
        return gridItems
    end

    if not arg1.state.watermarkVisible then
        return nil
    end

    return Roact.createElement("ScreenGui", {
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        AutoLocalize = false,
        DisplayOrder = 10,
        [Roact.Change.AbsoluteSize] = arg1.onAbsoluteSizeChange
    }, {
        FullScreenFrame = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, CalculateRotatedFrameWidth(), 0, (CalculateRotatedFrameHeight())),
            Position = UDim2.new(
                0,
                (arg1.state.absoluteSize.X - CalculateRotatedFrameWidth()) * 0.5,
                0,
                (arg1.state.absoluteSize.Y - CalculateRotatedFrameHeight()) * 0.5
            ),
            Rotation = 14.5
        }, (CreateGridItems()))
    })
        or nil
end

return var1
