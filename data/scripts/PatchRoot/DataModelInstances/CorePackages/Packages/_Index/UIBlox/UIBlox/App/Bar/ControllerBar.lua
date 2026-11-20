-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)

local withStyle = require(scriptParentParentParent.Core.Style.withStyle)

local ControllerBarHint = require(script.Parent.ControllerBarHint)

local GetTextSize = require(scriptParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParent.Core.Text.GetFontFromFontStyle)

local ControllerBarHintInternalPadding = require(script.Parent.BarConstants).ControllerBarHintInternalPadding
local DefaultKeyLabelSize = require(scriptParentParent.Menu.MenuConstants).DefaultKeyLabelSize

local var1 = Roact.PureComponent:extend("ControllerBar")

local leftHint = t.strictInterface({ keyCode = t.enum(Enum.KeyCode), text = t.string })

var1.validateProps = t.strictInterface({ leftHint = leftHint, rightHints = t.optional(t.map(t.number, leftHint)) })

function var1.init(arg1)
    arg1.state = {
        controllerBarWidth = 0,
        hintStringsConcat = nil,
        requiredSpace = nil,
        hintRatios = nil
    }
end

function var1.calculateHintRatios(arg1, arg2)
    local num1 = 84
    local str1 = ""

    local tbl1 = ({})
    local num2 = 0
    local var3 = Cryo.List.join({ arg1 }, arg2 or {})
    for _, value in ipairs(var3) do
        tbl1[value.text] = GetTextSize(value.text, 17, Enum.Font.ArialBold, Vector2.new(10000, 10000)).X

        num2 += tbl1[value.text]

        num1 = num1 + DefaultKeyLabelSize + ControllerBarHintInternalPadding

        str1 ..= value.text
    end

    for k, value in pairs(tbl1) do
        tbl1[k] = value / num2
    end

    return tbl1, num1 + math.max(#var3 - 2, 0) * 40, str1
end

function var1.getDerivedStateFromProps(arg1)
    local hintRatios, requiredSpace, hintStringsConcat = var1.calculateHintRatios(arg1.leftHint, arg1.rightHints)

    return {
        hintRatios = hintRatios,
        requiredSpace = requiredSpace,
        hintStringsConcat = hintStringsConcat
    }
end

function var1.calculateHintSize(arg1, arg2, arg3)
    local var3 = arg2 - arg1.state.requiredSpace

    local var4 = arg3.Header2.RelativeSize * arg3.BaseSize
    local var5 = arg3.Header2.RelativeMinSize * arg3.BaseSize

    local textSizeX = GetTextSize(arg1.state.hintStringsConcat, var5, GetFontFromFontStyle(arg3.Header2), Vector2.new(10000, 10000)).X

    if textSizeX <= var3 then
        local textSizeX2 = GetTextSize(arg1.state.hintStringsConcat, var4, GetFontFromFontStyle(arg3.Header2), Vector2.new(10000, 10000)).X
        local var6 = (var4 - var5) / (textSizeX2 - textSizeX)
        local var7 = var4 - var6 * textSizeX2

        return nil, math.clamp(var3 * var6 + var7, var5, var4)
    end

    local hintSize = ({})
    for k, hintRatio in pairs(arg1.state.hintRatios) do
        hintSize[k] = hintRatio * var3
    end

    return hintSize
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme

        local var3, hintTextSize = arg1:calculateHintSize(arg1.state.controllerBarWidth, arg2.Font)

        local function makeHint(arg3, arg4)
            local var5 = Cryo.Dictionary.join(
                arg3,
                {
                    key = "Hint" .. tostring(arg4),
                    hintTextSize = hintTextSize,
                    maxWidth = var3 and var3[arg3.text] or nil
                }
            )
            return Roact.createElement(ControllerBarHint, var5)
        end

        local rightHints = if arg1.props.rightHints then Roact.createFragment(Cryo.List.map(arg1.props.rightHints, makeHint)) else nil
        local createElement = Roact.createElement
        local tbl1 = {
            BorderSizePixel = 0,
            BackgroundTransparency = theme.BackgroundUIContrast.Transparency,
            BackgroundColor3 = theme.BackgroundUIContrast.Color,
            Size = UDim2.new(1, 0, 0, 72),
            Position = UDim2.fromScale(0, 1),
            AnchorPoint = Vector2.new(0, 1)
        }

        tbl1[Roact.Change.AbsoluteSize] = function(arg3)
            arg1:setState({ controllerBarWidth = arg3.AbsoluteSize.X })
        end

        tbl1[Roact.Event.AncestryChanged] = function(arg3)
            arg1:setState({ controllerBarWidth = arg3.AbsoluteSize.X })
        end

        return createElement("Frame", tbl1, {
            Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }),
            LeftFrame = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(0.5, 1)
            }, { Roact.createElement("UIListLayout", {
                    key = "Layout",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 40)
                }), makeHint(arg1.props.leftHint, "Left") }),
            RightFrame = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(0.5, 1),
                Position = UDim2.fromScale(1, 0),
                AnchorPoint = Vector2.new(1, 0)
            }, {
                Layout = Roact.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 40)
                }),
                RightHints = rightHints
            })
        })
    end)
end

return var1
