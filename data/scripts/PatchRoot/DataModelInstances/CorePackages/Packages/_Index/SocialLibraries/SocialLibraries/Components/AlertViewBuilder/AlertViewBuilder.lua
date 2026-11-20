-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local Cryo = dependencies.Cryo
local UIBlox = dependencies.UIBlox
local getTextBoundsAsync = dependencies.Foundation.Utility.getTextBoundsAsync
local Components = SocialLibraries.Components
local AlertViewLabel = require(Components.AlertView.AlertViewLabel)
local AlertViewTextbox = require(Components.AlertView.AlertViewTextbox)
local AlertViewSoakArea = require(Components.AlertView.AlertViewSoakArea)
local FitFrameVertical = require(script.Parent.Parent.FitFrameVertical)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local var1 = Roact.Component:extend("AlertViewBuilder")

var1.defaultProps = {
    bodyText = "",
    buttons = {},
    textboxes = {},
    displayTextbox = false,
    onActivated = function() end,
    onModalClose = function() end,
    onModalStayOpen = function() end,
    onModalOpen = function() end,
    title = "",
    childComponentWidth = 220,
    screenSize = Vector2.new(0, 0),
    soakAreaColor3 = Color3.fromRGB(255, 0, 255),
    soakAreaTransparency = 0.5,
    inputLengthExceeded = nil
}

function var1.init(arg1)
    local num1 = 0
    arg1.refs = {}
    for k, _ in pairs(arg1.props.textboxes) do
        arg1.refs[k] = Roact.createRef()
        num1 += 1
    end
    arg1.state = { numTextboxes = num1 }

    arg1.isMounted = false
    arg1.textMeasurements = {}

    function arg1.flushTextMeasurements()
        for k, textMeasurement in arg1.textMeasurements do
            if not arg1.props.textboxes[k] then
                arg1.textMeasurements[k] = nil
            else
                for value, value2 in textMeasurement do
                    if value2.height ~= nil or value2.inFlight then
                        continue
                    end

                    value2.inFlight = true
                    task.spawn(function()
                        local textBoundsAsync = getTextBoundsAsync(value2.text, value2.font, value2.fontSize, value2.width)

                        value2.inFlight = false

                        local textMeasurement2 = arg1.textMeasurements[k]
                        if not textBoundsAsync or not arg1.isMounted or not textMeasurement2 or textMeasurement2[value] ~= value2 then
                            return
                        end

                        value2.height = textBoundsAsync.Y
                        arg1:setState(function(tbl1)
                            return {
                                textMeasurementVersion = (tbl1.textMeasurementVersion or 0) + 1
                            }
                        end)
                    end)
                end
            end
        end
    end

    function arg1.scheduleTextMeasurementFlush()
        if arg1.textMeasurementFlushScheduled then
            return
        end

        arg1.textMeasurementFlushScheduled = true
        task.defer(function()
            arg1.textMeasurementFlushScheduled = false
            if arg1.isMounted then
                arg1.flushTextMeasurements()
            end
        end)
    end

    function arg1.calcTextboxTextHeight(tbl1, text: string?, str1: string, str2: string)
        if not text or text == "" then
            local textMeasurement = arg1.textMeasurements[str1]
            if textMeasurement then
                textMeasurement[str2] = nil
            end
            return 0
        end

        local fontSize = tbl1.Font.Body.RelativeSize * tbl1.Font.BaseSize
        local font = tbl1.Font.Body.Font
        local childComponentWidth = arg1.props.childComponentWidth
        local textMeasurement = arg1.textMeasurements[str1]
        if not textMeasurement then
            textMeasurement = {}
            arg1.textMeasurements[str1] = textMeasurement
        end

        local var3 = textMeasurement[str2]
        if var3 and var3.text == text and var3.font == font and var3.fontSize == fontSize and var3.width == childComponentWidth then
            return if var3.height == nil then fontSize else var3.height
        end

        textMeasurement[str2] = {
            text = text,
            font = font,
            fontSize = fontSize,
            width = childComponentWidth,
            inFlight = false
        }

        arg1.scheduleTextMeasurementFlush()
        return fontSize
    end
end

function var1.didMount(arg1)
    arg1.isMounted = true
    arg1.flushTextMeasurements()

    if type(arg1.props.onModalOpen) == "function" then
        arg1.props.onModalOpen()
    end
end

function var1.didUpdate(arg1)
    arg1.flushTextMeasurements()
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

function var1.reset(arg1)
    for _, ref in pairs(arg1.refs) do
        if ref.current then
            ref.current.Text = ""
        end
    end
end

function var1.makeButtonTable(arg1)
    local tbl1 = {
        buttons = {}
    }
    for layoutOrder, button in ipairs(arg1.props.buttons) do
        table.insert(tbl1.buttons, {})
        local join = Cryo.Dictionary.join

        local tbl2 = {
            props = Cryo.Dictionary.join(button.props, {
                layoutOrder = layoutOrder,
                onActivated = function()
                    arg1.props.onActivated()
                    local tbl2 = ({})
                    for k, ref in pairs(arg1.refs) do
                        tbl2[k] = ref.current and ref.current.Text or ""
                    end
                    if button.props.onActivated(tbl2) then
                        arg1.props.onModalStayOpen()

                        return
                    end

                    arg1:reset()
                    arg1:setState({ displayingModal = false })

                    arg1.props.onModalClose()
                end
            })
        }

        local var2 = join(button, tbl2)

        tbl1.buttons[layoutOrder] = var2
    end

    return tbl1
end

function var1.makeTextboxList(arg1, arg2)
    local textboxList = ({})

    local textDefaultColor = arg2.Theme.TextDefault.Color
    if arg1.props.inputLengthExceeded then
        textDefaultColor = arg2.Theme.Alert.Color
    end

    for k, value in pairs(arg1.props.textboxes) do
        local yOffset = arg1.calcTextboxTextHeight(arg2, value.belowText, k, "belowText")
        local yOffset2 = arg1.calcTextboxTextHeight(arg2, value.warningText, k, "warningText")

        local createElement = Roact.createElement
        local var2 = FitFrameVertical
        local tbl1 = {
            width = UDim.new(1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            LayoutOrder = value.LayoutOrder
        }
        local tbl2 = {}
        local createElement2 = Roact.createElement
        local var3 = AlertViewTextbox
        local tbl3 = {
            onTextChanged = value.onTextChanged,
            PlaceholderText = value.PlaceholderText,
            Text = value.Text,
            LayoutOrder = 1,
            [Roact.Ref] = arg1.refs[k]
        }
        tbl2[k] = createElement2(var3, tbl3)

        local var4 = k .. " Below Text"
        local element

        if value.belowText and value.belowText ~= "" then
            element = Roact.createElement(AlertViewLabel, {
                BackgroundTransparency = 1,
                Text = value.belowText,
                LayoutOrder = 2,
                TextXAlignment = value.belowTextAlignment or Enum.TextXAlignment.Left,
                Size = UDim2.new(1, 0, 0, yOffset),
                TextColor3 = textDefaultColor
            })
                or nil
        else
            element = nil
        end

        tbl2[var4] = element

        local var5 = k .. " Warning Text"
        local element2

        if value.warningText and value.warningText ~= "" then
            element2 = Roact.createElement(AlertViewLabel, {
                BackgroundTransparency = 1,
                Text = value.warningText,
                LayoutOrder = 3,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2.new(1, 0, 0, yOffset2),
                TextColor3 = arg2.Theme.Alert.Color
            })
                or nil
        else
            element2 = nil
        end

        tbl2[var5] = element2
        textboxList[k] = createElement(var2, tbl1, tbl2)
    end

    return textboxList
end

function var1.makeMiddleContent(arg1, arg2): (() -> any)?
    local var2 = arg1:makeTextboxList(arg2)

    return if arg1.state.numTextboxes == 0 then nil else function()
        return Roact.createElement(
            FitFrameVertical,
            {
                width = UDim.new(1, 0),
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            },
            {
                Textboxes = Roact.createElement(
                    FitFrameVertical,
                    {
                        width = UDim.new(1, 0),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        LayoutOrder = 1
                    },
                    var2
                )
            }
        )
    end
end

function var1.render(arg1)
    assert(arg1.props.displayTextbox or not arg1.props.mandatoryInput)

    return UIBlox.Style.withStyle(function(arg2)
        local buttonStackInfo = arg1:makeButtonTable()
        local middleContent = arg1:makeMiddleContent(arg2)
        local bodyText = if arg1.props.bodyText == "" then nil else arg1.props.bodyText or nil
        return Roact.createElement(AlertViewSoakArea, {
            BackgroundColor3 = arg1.props.soakAreaColor3,
            BackgroundTransparency = arg1.props.soakAreaTransparency,
            Visible = arg1.state.displayingModal
        }, {
            alertView = Roact.createElement(InteractiveAlert, {
                title = arg1.props.title,
                bodyText = bodyText,
                middleContent = middleContent,
                buttonStackInfo = buttonStackInfo,
                screenSize = arg1.props.screenSize
            })
        })
    end)
end

return var1
