-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)

local Cryo = dependencies.Cryo
local Roact = dependencies.Roact

local TestStyle = require(SocialLibraries.Components.Style.TestStyle)
local CallbackInputBox = require(script.Parent.CallbackInputBox)
local getTextBoundsAsync = dependencies.Foundation.Utility.getTextBoundsAsync
local normalizeFontFace = dependencies.Foundation.Utility.normalizeFontFace

local var1 = Roact.PureComponent:extend("InputBoxWithCharacterCounter")
var1.defaultProps = {
    initialInputText = "",
    validInputTextColor3 = Color3.fromRGB(0, 255, 0),
    validInputTextTransparency = 0,
    invalidInputTextColor3 = Color3.fromRGB(255, 0, 0),
    invalidInputTextTransparency = 0,
    counterTextPadding = 0,
    characterLimit = 150,
    style = TestStyle
}

function var1.init(arg1)
    arg1.state = {
        inputText = arg1.props.initialInputText
    }

    function arg1.textChangedCallback(inputText: string)
        arg1:setState({ inputText = inputText })
    end

    arg1.isMounted = false
    arg1.measurementId = 0

    function arg1.measureText()
        local style = arg1.props.style
        local measuredText = #arg1.state.inputText .. "/" .. arg1.props.characterLimit
        local font = style.Font.CaptionSubHeader.Font
        local measuredFontSize = style.Font.BaseSize * style.Font.CaptionSubHeader.RelativeSize
        if arg1.measuredText == measuredText and arg1.measuredFont == font and arg1.measuredFontSize == measuredFontSize then
            return
        end

        arg1.measuredText = measuredText
        arg1.measuredFont = font
        arg1.measuredFontSize = measuredFontSize
        local var4 = arg1
        var4.measurementId += 1
        local measurementId = arg1.measurementId

        task.spawn(function()
            local textBounds = getTextBoundsAsync(measuredText, font, measuredFontSize)
            if arg1.isMounted and arg1.measurementId == measurementId then
                arg1:setState({ textBounds = textBounds })
            end
        end)
    end
end

function var1.didMount(arg1)
    arg1.isMounted = true
    arg1.measureText()
end

function var1.didUpdate(arg1)
    arg1.measureText()
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
    arg1.measurementId += 1
end

function var1.render(arg1)
    local style = arg1.props.style

    local inputTextLen = #arg1.state.inputText
    local var2 = inputTextLen .. "/" .. arg1.props.characterLimit
    local font = style.Font.CaptionSubHeader.Font
    local y = style.Font.BaseSize * style.Font.CaptionSubHeader.RelativeSize

    local y2 = (arg1.state.textBounds or Vector2.new(0, y)).Y
    local var3, var4

    if inputTextLen <= arg1.props.characterLimit then
        var3 = arg1.props.validInputTextColor3
        var4 = arg1.props.validInputTextTransparency
    else
        var3 = arg1.props.invalidInputTextColor3
        var4 = arg1.props.invalidInputTextTransparency
    end

    local var5 = Cryo.Dictionary.join(arg1.props, { inputText = arg1.state.inputText, textChangedCallback = arg1.textChangedCallback })

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0)
    }, {
        layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        inputBoxContainer = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, -y2),
                LayoutOrder = 1
            },
            {
                border = Roact.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(3, 3, 4, 4),
                    Image = "rbxasset://textures/ui/LuaChat/9-slice/input-default.png"
                }),
                inputBox = Roact.createElement(CallbackInputBox, var5)
            }
        ),
        characterCounter = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, y2),
                LayoutOrder = 2
            },
            {
                layout = Roact.createElement(
                    "UIListLayout",
                    {
                        VerticalAlignment = Enum.VerticalAlignment.Bottom,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right
                    }
                ),
                padding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, arg1.props.counterTextPadding) }),
                characterCountLabel = Roact.createElement("TextLabel", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = var2,
                    TextColor3 = var3,
                    TextTransparency = var4,
                    TextSize = y,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    FontFace = normalizeFontFace(font)
                })
            }
        )
    })
end
return var1
