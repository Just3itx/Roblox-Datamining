-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")
local scriptParentParent = script.Parent.Parent

local ShowHelpModalThunk = require(scriptParentParent.Thunks.ShowHelpModalThunk)

local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization

local FeedbackBarHint = require(script.Parent.FeedbackBarHint)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)
local Cryo = require(CorePackages.Packages.Cryo)

local withStyle = UIBlox.Core.Style.withStyle
local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local var1 = Roact.PureComponent:extend("RefinedFeedbackBar")

local function GetTextSize(...)
    return TextService:GetTextSize(...) + Vector2.new(2, 2)
end

local leftHint = t.strictInterface({ text = t.string })

var1.validateProps = t.strictInterface({ leftHint = leftHint })

function var1.init(arg1)
    arg1.state = { barWidth = 0, hintStringsConcat = nil, requiredSpace = nil, hintRatios = nil }

    function arg1.onExitFeedbackMode()
        ExperienceStateCaptureService:ToggleCaptureMode()
    end

    function arg1.openHelpModal()
        arg1.props.showHelpModal(true)
    end
end

function var1.calculateHintRatios(arg1)
    local num1 = 84
    local str1 = ""

    local tbl1 = ({})
    local num2 = 0
    local var3 = Cryo.List.join({ arg1 }, {})
    for _, value in ipairs(var3) do
        tbl1[value.text] = GetTextSize(value.text, 17, 2, Vector2.new(10000, 10000)).X

        num2 += tbl1[value.text]

        num1 = num1 + 36 + 8

        str1 ..= value.text
    end

    for k, value in pairs(tbl1) do
        tbl1[k] = value / num2
    end

    return tbl1, num1 + math.max(#var3 - 2, 0) * 40, str1
end

function var1.getDerivedStateFromProps(arg1)
    local hintRatios, requiredSpace, hintStringsConcat = var1.calculateHintRatios(arg1.leftHint)

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

    local textSizeX = GetTextSize(arg1.state.hintStringsConcat, var5, arg3.Header2.Font, Vector2.new(10000, 10000)).X

    if textSizeX <= var3 then
        local textSizeX2 = GetTextSize(arg1.state.hintStringsConcat, var4, arg3.Header2.Font, Vector2.new(10000, 10000)).X
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
        local function makeHint(leftHint)
            return Roact.createElement(FeedbackBarHint, leftHint)
        end

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
            arg1:setState({ barWidth = arg3.AbsoluteSize.X })
        end

        tbl1[Roact.Event.AncestryChanged] = function(arg3)
            arg1:setState({ barWidth = arg3.AbsoluteSize.X })
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
                }), makeHint(arg1.props.leftHint) }),
            RightFrame = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(0.35, 1),
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
                Buttons = withLocalization({
                    helpButtonText = "CoreScripts.Feedback.FeedbackBar.HelpButton",
                    exitFeedbackButtonText = "CoreScripts.Feedback.FeedbackBar.ExitFeedbackButton"
                })(
                    function(arg3)
                        return Roact.createElement(ButtonStack, {
                            buttonHeight = 50,
                            buttons = {
                                {
                                    buttonType = ButtonType.Secondary,
                                    props = {
                                        onActivated = arg1.openHelpModal,
                                        text = arg3.helpButtonText
                                    }
                                },
                                {
                                    buttonType = ButtonType.PrimarySystem,
                                    props = {
                                        isDisabled = false,
                                        onActivated = arg1.onExitFeedbackMode,
                                        text = arg3.exitFeedbackButtonText
                                    }
                                }
                            },
                            forcedFillDirection = Enum.FillDirection.Horizontal
                        })
                    end
                )
            })
        })
    end)
end
return RoactRodux.connect(function()
    return {}
end, function(callback)
    return {
        showHelpModal = function(arg1)
            callback(ShowHelpModalThunk(arg1))
        end
    }
end)(var1)
