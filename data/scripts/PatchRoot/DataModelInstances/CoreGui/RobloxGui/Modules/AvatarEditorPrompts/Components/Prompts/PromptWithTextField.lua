-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local RoactGamepad = require(CorePackages.Packages.RoactGamepad)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local _ButtonType = UIBlox.App.Button.Enum.ButtonType
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Style.withStyle

local Images = UIBlox.App.ImageSet.Images

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection

local component_assetsCircle_17_stroke_1 = Images["component_assets/circle_17_stroke_1"]
local rect = Rect.new(8, 8, 8, 8)

local var1 = Roact.PureComponent:extend("PromptWithTextField")

var1.validateProps = t.strictInterface({
    fieldText = t.string,
    onFieldTextUpdated = t.callback,
    title = t.string,
    bodyText = t.optional(t.string),
    buttonStackInfo = t.table,
    screenSize = t.Vector2
})

function var1.init(arg1)
    arg1:setState({ alertPosition = UDim2.fromScale(0.5, 0.5) })

    arg1.textBoxRef = Roact.createRef()

    function arg1.textUpdated(arg2)
        arg1.props.onFieldTextUpdated(arg2.Text)
    end

    arg1.lastAlertHeight = 100

    function arg1.calculateAlertPosition()
        local uDim2 = UDim2.fromScale(0.5, 0.5)

        if UserInputService.OnScreenKeyboardVisible then
            local yOffset = (arg1.props.screenSize.Y - UserInputService.OnScreenKeyboardSize.Y) / 2
            local var2 = yOffset - arg1.lastAlertHeight / 2

            if var2 < 20 then
                yOffset += 20 - var2
            end

            uDim2 = UDim2.new(0.5, 0, 0, yOffset)
        end

        if arg1.state.alertPosition ~= uDim2 then
            arg1:setState({ alertPosition = uDim2 })
        end
    end

    function arg1.alertSizeChanged(arg2)
        arg1.lastAlertHeight = arg2.AbsoluteSize.Y

        arg1.calculateAlertPosition()
    end

    function arg1.alertMounted()
        local value = arg1.textBoxRef:getValue()
        if value then
            value:CaptureFocus()
        end
    end
end

function var1.renderAlertMiddleContent(arg1)
    return withStyle(function(arg2)
        local font = arg2.Font
        local theme = arg2.Theme

        local createElement = Roact.createElement
        local tbl1 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 35),
            Position = UDim2.fromScale(0, 1),
            AnchorPoint = Vector2.new(0, 1)
        }
        local tbl2 = { TextboxBorder = 0 }
        local createElement2 = Roact.createElement
        local var2 = ImageSetLabel
        local tbl3 = {
            BackgroundTransparency = 1,
            Image = component_assetsCircle_17_stroke_1,
            ImageColor3 = theme.UIDefault.Color,
            ImageTransparency = theme.UIDefault.Transparency,
            LayoutOrder = 3,
            ScaleType = Enum.ScaleType.Slice,
            Size = UDim2.new(1, 0, 1, -5),
            Position = UDim2.fromScale(0, 1),
            AnchorPoint = Vector2.new(0, 1),
            SliceCenter = rect
        }
        local tbl4 = {
            Textbox = Roact.createElement(RoactGamepad.Focusable.TextBox, {
                BackgroundTransparency = 1,
                ClearTextOnFocus = false,
                Font = font.Header2.Font,
                TextSize = font.BaseSize * font.CaptionBody.RelativeSize,
                PlaceholderColor3 = theme.TextDefault.Color,
                PlaceholderText = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.OutfitNamePlaceholder"),
                Position = UDim2.new(0, 6, 0, 0),
                Size = UDim2.new(1, -12, 1, 0),
                TextColor3 = theme.TextEmphasis.Color,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = arg1.props.fieldText,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                OverlayNativeInput = true,
                [Roact.Change.Text] = arg1.textUpdated,
                [Roact.Ref] = arg1.textBoxRef
            })
        }
        tbl2.TextboxBorder = createElement2(var2, tbl3, tbl4)
        return createElement("Frame", tbl1, tbl2)
    end)
end

function var1.render(arg1)
    return Roact.createFragment({
        InteractiveAlert = Roact.createElement(InteractiveAlert, {
            title = arg1.props.title,
            bodyText = arg1.props.bodyText,
            buttonStackInfo = arg1.props.buttonStackInfo,
            position = arg1.state.alertPosition,
            screenSize = arg1.props.screenSize,
            middleContent = function()
                return arg1:renderAlertMiddleContent()
            end,
            isMiddleContentFocusable = true,
            onAbsoluteSizeChanged = arg1.alertSizeChanged,
            onMounted = arg1.alertMounted
        }),
        OnScreenKeyboardVisibleConnection = Roact.createElement(
            ExternalEventConnection,
            {
                event = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"),
                callback = arg1.calculateAlertPosition
            }
        ),
        OnScreenKeyboardSizeConnection = Roact.createElement(
            ExternalEventConnection,
            {
                event = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardSize"),
                callback = arg1.calculateAlertPosition
            }
        )
    })
end

function var1.didMount(arg1)
    arg1.calculateAlertPosition()
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        screenSize = arg1.screenSize
    }
end, nil)(var1)
