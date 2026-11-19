-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local RoactGamepad = require(CorePackages.Packages.RoactGamepad)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local Focusable = RoactGamepad.Focusable

local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local withStyle = UIBlox.Style.withStyle
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind

local var1 = Roact.PureComponent:extend("NameTextBox")
local bool1 = game:DefineFastFlag("RemoveNameRegex", false)

var1.validateProps = t.strictInterface({
    Size = t.optional(t.UDim2),
    Position = t.optional(t.UDim2),
    centerText = t.optional(t.boolean),
    maxLength = t.optional(t.number),
    onNameUpdated = t.callback,
    LayoutOrder = t.optional(t.number),
    nameTextBoxRef = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    defaultName = t.optional(t.string),
    invalidInputText = t.optional(t.string)
})

var1.defaultProps = {
    maxLength = 50,
    centerText = true,
    invalidInputText = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.InvalidName")
}

local function isNameTooLong(str1: string, maxLength: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = utf8.len(utf8.nfcnormalize(str1))
    return var2 == nil or maxLength < var2
end

function var1.init(arg1)
    arg1:setState({ name = arg1.props.defaultName or "", lastValidName = "", isNameValid = true })

    arg1.wasInitiallyFocused = false

    function arg1.tryFocusTextBox()
        if arg1.wasInitiallyFocused then
            return
        end

        local value = arg1.props.nameTextBoxRef and arg1.props.nameTextBoxRef:getValue()
        if value and value:IsDescendantOf(game) then
            value:CaptureFocus()
            arg1.wasInitiallyFocused = true
        end
    end

    function arg1.onTextChanged(arg2)
        local text = arg2.Text

        local maxLength = arg1.props.maxLength

        if isNameTooLong(text, maxLength) then
            text = string.sub(text, 1, utf8.offset(text, maxLength + 1) - 1)
            arg2.Text = text
        end

        local isNameValid = arg1:checkIsNameValid(text)

        local lastValidName = arg1.state.lastValidName
        if isNameValid then
            lastValidName = arg2.Text
        end

        arg1:setState({ lastValidName = lastValidName, isNameValid = isNameValid, name = text })

        arg1.props.onNameUpdated(text, isNameValid)
    end
end

function var1.checkIsNameValid(_, arg1)
    if not bool1 then
        if not string.match(arg1, "[0-9a-zA-Z_'%s]+$") then
            return false
        end

        if string.sub(arg1, 1, 1) == " " then
            return false
        end
    end

    return not string.match(arg1, "^%s*$")
end

function var1.renderWithProviders(arg1, arg2, arg3)
    local font = arg2.Font
    local theme = arg2.Theme

    local body = font.Body

    local bool2 = not arg1.state.isNameValid

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        BackgroundTransparency = 1,
        Size = arg1.props.Size,
        Position = arg1.props.Position,
        LayoutOrder = arg1.props.LayoutOrder
    }
    local tbl2 = { TextBoxContainer = 0, WarningText = 0 }
    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl3 = {
        BackgroundColor3 = theme.BackgroundMuted.Color,
        LayoutOrder = 1,
        Size = arg1.props.Size
    }
    local tbl4 = { Textbox = 0, UICorner = 0, UIStroke = 0 }
    local createElement3 = Roact.createElement
    local textBox = Focusable.TextBox
    local tbl5 = {
        Text = arg1.state.name,
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
        TextSize = font.BaseSize * body.RelativeSize,
        PlaceholderColor3 = theme.PlaceHolder.Color,
        PlaceholderText = arg1.props.defaultName,
        Position = UDim2.fromOffset(6, 0),
        Size = UDim2.new(1, -12, 1, 0),
        TextColor3 = theme.TextDefault.Color,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = if arg1.props.centerText then nil else Enum.TextYAlignment.Top,
        OverlayNativeInput = true,
        [Roact.Change.Text] = arg1.onTextChanged,
        SelectionImageObject = arg3(CursorKind.InputFields),
        NextSelectionDown = arg1.props.NextSelectionDown,
        [Roact.Ref] = arg1.props.nameTextBoxRef,
        [Roact.Event.AncestryChanged] = arg1.tryFocusTextBox
    }
    local tbl6 = {
        UIPadding = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 6),
            PaddingRight = UDim.new(0, 6),
            PaddingTop = if arg1.props.centerText then nil else UDim.new(0, 6)
        })
    }
    tbl4.Textbox = createElement3(textBox, tbl5, tbl6)

    tbl4.UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })

    tbl4.UIStroke = Roact.createElement("UIStroke", {
        Thickness = 0.5,
        Transparency = theme.Divider.Transparency,
        Color = theme.Divider.Color,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    tbl2.TextBoxContainer = createElement2(str2, tbl3, tbl4)

    tbl2.WarningText = bool2
        and Roact.createElement("TextLabel", {
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = arg1.props.invalidInputText,
            LayoutOrder = 2,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Size = UDim2.new(1, 0, 0, 20),
            TextColor3 = theme.Alert.Color,
            TextWrapped = true,
            FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
            TextSize = 12
        })
    return createElement(str1, tbl1, tbl2)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return withSelectionCursorProvider(function(arg3)
            return arg1:renderWithProviders(arg2, arg3)
        end)
    end)
end

function var1.didMount(arg1)
    arg1.tryFocusTextBox()
end

return var1
