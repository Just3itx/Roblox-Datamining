-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local ButtonType = dependencies.UIBlox.App.Button.Enum.ButtonType
local Components = SocialLibraries.Components

local UserInputService = dependencies.UserInputService

local AlertViewBuilder = require(Components.AlertViewBuilder.AlertViewBuilder)

local var1 = Roact.Component:extend("InputAlertView")
var1.defaultProps = {
    titleText = "TestTitle",
    cancelText = "TestCancel",
    confirmText = "TestConfirm",
    warningText = nil,
    inputText = "TestInput",
    maxCharacters = 150,
    onActivated = function() end,
    onModalClose = function() end,
    screenSize = Vector2.new(0, 0),
    soakAreaColor3 = Color3.fromRGB(0, 0, 255),
    soakAreaTransparency = 0.9,
    shouldAdjustForKeyboard = true
}

function var1.init(arg1)
    arg1.ref = Roact.createRef()
    function arg1.onTextChanged(inputText)
        arg1:setState({ inputText = inputText, inputLengthExceeded = #inputText > arg1.props.maxCharacters })
    end

    function arg1.onButtonActivated()
        arg1.closing = true
    end

    function arg1.updateModalPosition()
        arg1:setState({
            keyboardOffset = UserInputService.OnScreenKeyboardVisible
                and arg1.state.yPosition + arg1.ref:getValue().AbsoluteSize.Y - UserInputService.OnScreenKeyboardPosition.Y
                or 0
        })
    end

    function arg1.onModalStayOpen()
        arg1.closing = false

        if arg1.props.shouldAdjustForKeyboard then
            arg1.updateModalPosition()
        end
    end

    if arg1.props.shouldAdjustForKeyboard then
        arg1.keyboardConnection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):connect(function()
            spawn(function()
                if not arg1.isMounted or arg1.closing then
                    return
                end

                arg1.updateModalPosition()
            end)
        end)
    end

    function arg1.onPositionChanged(arg2)
        if not arg1.isMounted then
            return
        end

        if arg2.AbsolutePosition.Y ~= arg1.state.yPosition then
            arg1:setState({ yPosition = arg2.AbsolutePosition.Y })
        end
    end

    arg1.closing = false

    arg1.state = {
        inputText = arg1.props.inputText,
        inputLengthExceeded = false,
        keyboardOffset = 0,
        yPosition = 0
    }
end

function var1.render(arg1)
    local props = arg1.props

    local maxCharacters = props.maxCharacters

    local buttons = props.displayFailed
        and {{
            buttonType = ButtonType.Alert,
            props = {
                text = props.failedText,
                onActivated = props.onActivated
            }
        }}
        or {
            {
                buttonType = ButtonType.Secondary,
                props = {
                    text = props.cancelText,
                    onActivated = function() end
                }
            },
            {
                buttonType = ButtonType.PrimarySystem,
                props = {
                    text = props.confirmText,
                    isDisabled = arg1.state.inputLengthExceeded,
                    onActivated = props.onActivated
                }
            }
        }

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, -arg1.state.keyboardOffset),
        Transparency = 1,
        [Roact.Change.AbsolutePosition] = arg1.onPositionChanged,
        [Roact.Ref] = arg1.ref
    }, {
        AlertView = Roact.createElement(AlertViewBuilder, {
            buttons = buttons,
            inputLengthExceeded = arg1.state.inputLengthExceeded,
            onActivated = arg1.onButtonActivated,
            onModalClose = props.onModalClose,
            onModalStayOpen = arg1.onModalStayOpen,
            soakAreaColor3 = arg1.props.soakAreaColor3,
            soakAreaTransparency = arg1.props.soakAreaTransparency,
            textboxes = {
                InputBox = {
                    belowText = maxCharacters and #arg1.state.inputText .. "/" .. maxCharacters,
                    belowTextAlignment = Enum.TextXAlignment.Right,
                    LayoutOrder = 1,
                    onTextChanged = arg1.onTextChanged,
                    PlaceholderText = props.placeholderText,
                    Text = props.inputText,
                    warningText = arg1.props.warningText
                }
            },
            title = props.titleText,
            screenSize = props.screenSize
        })
    })
end

function var1.didMount(arg1)
    arg1.isMounted = true
end

function var1.willUnmount(arg1)
    arg1.isMounted = false

    if arg1.keyboardConnection then
        arg1.keyboardConnection:Disconnect()
        arg1.keyboardConnection = nil
    end
end

return var1
