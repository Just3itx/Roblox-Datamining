-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local LogService = game:GetService("LogService")
local Roact = require(CorePackages.Packages.Roact)

local DataConsumer = require(script.Parent.Parent.DataConsumer)

local ScrollingTextBox = require(script.Parent.Parent.ScrollingTextBox)

local Constants = require(script.Parent.Parent.Parent.Constants)
local CommandLineIndent = Constants.LogFormatting.CommandLineIndent
local CommandLine = Constants.DefaultFontSize.CommandLine
local Log = Constants.Font.Log

local var1 = Roact.PureComponent:extend("DevConsoleCommandLine")

function var1.init(arg1)
    function arg1.onFocusLost(arg2, arg3, _)
        if arg3 then
            LogService:ExecuteScript(arg2.Text)
            arg2:CaptureFocus()
        end
    end

    arg1.textbox = Roact.createRef()
end

function var1.didMount(arg1)
    if not arg1.onFocusConnection then
        arg1.onFocusConnection = UserInputService.InputBegan:Connect(function(input: InputObject)
            if not arg1.textbox.current or not arg1.textbox.current:IsFocused() then
                return
            end

            local current = arg1.textbox.current
            local serverLogData = arg1.props.ServerLogData
            local commandLineHistory = serverLogData:getCommandLineHistory()
            local commandLineIndex = serverLogData:getCommandLineIndex()
            local var2

            if input.KeyCode == Enum.KeyCode.Up then
                var2 = math.min(commandLineHistory:getSize(), commandLineIndex + 1)

                current.Text = commandLineHistory:reverseAt(var2) or ""
            elseif input.KeyCode == Enum.KeyCode.Down then
                var2 = math.max(0, commandLineIndex - 1)

                current.Text = commandLineHistory:reverseAt(var2) or ""
            elseif input.KeyCode ~= Enum.KeyCode.Return then
                var2 = if commandLineIndex ~= 0 then 0 else commandLineIndex
            elseif #current.Text:gsub("%s+", "") > 0 and commandLineHistory:reverseAt(1) ~= current.Text then
                commandLineHistory:push_back(current.Text)
                var2 = 0
            else
                var2 = 0
            end

            serverLogData:setCommandLineIndex(var2)
        end)
    end

    if arg1.fixUnwantedReturnCapture then
        return
    end

    arg1.fixUnwantedReturnCapture = UserInputService.InputEnded:Connect(function(input: InputObject)
        if arg1.textbox.current and arg1.textbox.current:IsFocused() and input.KeyCode == Enum.KeyCode.Return then
            arg1.textbox.current.Text = ""
        end
    end)
end

function var1.willUnmount(arg1)
    if arg1.onFocusConnection then
        arg1.onFocusConnection:Disconnect()
        arg1.onFocusConnection = nil
    end
    if arg1.fixUnwantedReturnCapture then
        arg1.fixUnwantedReturnCapture:Disconnect()
        arg1.fixUnwantedReturnCapture = nil
    end
end

function var1.render(arg1)
    local height = arg1.props.height
    local pos = arg1.props.pos

    local commandLineIndex = arg1.props.ServerLogData:getCommandLineIndex()
    local var2 = if commandLineIndex == 0 then "" else arg1.props.ServerLogData:getCommandLineHistory():reverseAt(commandLineIndex) or ""

    local createElement = Roact.createElement
    local tbl1 = {
        Position = pos,
        Size = UDim2.new(1, 0, 0, height),
        BackgroundTransparency = 0,
        BackgroundColor3 = Constants.Color.TextBoxGray,
        BorderColor3 = Constants.Color.BorderGray,
        BorderSizePixel = 1
    }
    local tbl2 = {
        Arrow = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, CommandLineIndent, 1, 0),
            BackgroundTransparency = 1,
            TextSize = CommandLine,
            Font = Log,
            Text = "> ",
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Right
        }),
        InputField = Roact.createElement(ScrollingTextBox, {
            Position = UDim2.new(0, CommandLineIndent, 0, 0),
            Size = UDim2.new(1, -CommandLineIndent, 0, height),
            ShowNativeInput = true,
            ClearTextOnFocus = false,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = 0,
            TextSize = CommandLine,
            Text = var2,
            Font = Log,
            PlaceholderText = "command line",
            [Roact.Ref] = arg1.textbox,
            TextBoxFocusLost = arg1.onFocusLost
        })
    }
    return createElement("Frame", tbl1, tbl2)
end

return DataConsumer(var1, "ServerLogData")
