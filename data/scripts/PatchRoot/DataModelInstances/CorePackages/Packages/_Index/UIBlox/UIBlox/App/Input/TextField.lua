-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local InputLabel = require(scriptParent.InputLabel)
local HelperText = require(scriptParent.HelperText)
local ImageSetComponent = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent)
local _ImagesTypes = require(scriptParentParent.ImageSet.ImagesTypes)

local useStyle = require(scriptParentParentParent.Core.Style.useStyle)
local useCursor = require(scriptParentParentParent.App.SelectionCursor.useCursor)
local UIBloxConfig = require(scriptParentParentParent.UIBloxConfig)

local tbl1 = {
    width = UDim.new(0, 400)
}

local function TextField(tbl2)
    local tokens = useStyle().Tokens

    local ref = React.useRef(nil)
    local var2, var3 = React.useState(false)
    local var4, var5 = React.useState(false)

    local thick = tokens.Stroke.Thick
    local size400 = tokens.Size.Size_400

    local standard = tokens.Stroke.Standard
    local num1 = math.ceil(standard) * 2
    local thick2 = tokens.Stroke.Thick
    local num2 = math.ceil(thick2) * 2

    local selectionImageObject = useCursor(UDim.new(0, tokens.Radius.Medium), thick, thick)
    local var1 = useCursor(UDim.new(0.5), size400 / 2, thick)
    local width = if tbl2.width ~= nil then tbl2.width else tbl1.width

    local function canUseTextInputType(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        local success, result = pcall(function(): CoreGui
            local CoreGui = game:GetService("CoreGui")
            local _coreGuiName = CoreGui.Name
            return CoreGui
        end)
        return success and result ~= nil
    end

    local function getTextBoxWidthOffset() -- Luacid: Inlined by compiler; 1 call site recovered
        local num3 = 0
        if tbl2.iconLeading then
            num3 = num3 - size400 - tokens.Gap.Small * 2
        end
        if tbl2.iconButton then
            num3 = num3 - size400 - tokens.Gap.Small * 2
        end
        return num3
    end

    local function onTextChange(arg1)
        if arg1 == nil then
            tbl2.onChange("")
            return
        end
        tbl2.onChange(arg1.Text)
    end

    local function onFocusGained()
        if tbl2.disabled and ref.current then
            ref.current:ReleaseFocus()
            return
        end
        var5(true)
        if tbl2.onFocusGained then
            tbl2.onFocusGained()
        end
    end

    local function onFocusLost()
        var5(false)
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(width, UDim.new(0, 0)),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl2.LayoutOrder
    }
    local tbl4 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, tokens.Size.Size_100)
        }),
        InputLabel = if tbl2.label then React.createElement(InputLabel, { text = tbl2.label, required = tbl2.required, LayoutOrder = 1 }) else nil,
        InputCanvas = 0,
        HelperText = 0
    }

    local createElement2 = React.createElement
    local str2 = "CanvasGroup"
    local tbl5 = {
        Size = UDim2.new(1, 0, 0, tokens.Size.Size_1200),
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        GroupTransparency = if tbl2.disabled then 0.68 else 0
    }
    local tbl6 = { Input = 0 }
    local createElement3 = React.createElement
    local str3 = "ImageButton"
    local tbl7 = {
        Size = UDim2.new(1, -num1, 1, -num1),
        Position = UDim2.new(0, num1 / 2, 0, num1 / 2),
        BackgroundTransparency = 1,
        Selectable = not tbl2.disabled,
        Image = "",
        SelectionImageObject = selectionImageObject
    }
    tbl7[React.Event.Activated] = function()
        if ref.current then
            ref.current:CaptureFocus()
        end
    end
    tbl7[React.Event.MouseEnter] = function()
        var3(true)
    end
    tbl7[React.Event.MouseLeave] = function()
        var3(false)
    end
    local tbl8 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tokens.Radius.Medium) }),
        Border = React.createElement("UIStroke", {
            Color = if tbl2.error then tokens.Color.ActionAlert.Border.Color3 else tokens.Color.Stroke.Emphasis.Color3,
            Transparency = if tbl2.error then tokens.Color.ActionAlert.Border.Transparency elseif var4 then 0 else tokens.Color.Stroke.Emphasis.Transparency,
            Thickness = standard
        }),
        BorderFrame = 0
    }

    local createElement4 = React.createElement
    local str4 = "Frame"
    local tbl9 = {
        Size = UDim2.new(1, -num2, 1, -num2),
        Position = UDim2.new(0, num2 / 2, 0, num2 / 2),
        BackgroundTransparency = 1
    }
    local tbl10 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tokens.Radius.Medium - num2 / 2) }),
        Focus = if tbl2.disabled or not (var2 or var4) then nil else React.createElement(
            "UIStroke",
            {
                Color = tokens.Color.Stroke.Emphasis.Color3,
                Transparency = 0.88,
                Thickness = thick2
            }
        ),
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, tokens.Size.Size_300),
                PaddingRight = UDim.new(0, tokens.Size.Size_300)
            }
        ),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, tokens.Gap.Small * 2)
        }),
        IconLeading = 0,
        TextBox = 0,
        IconButton = 0
    }
    local element

    if tbl2.iconLeading then
        element = React.createElement(ImageSetComponent.Label, {
            BackgroundTransparency = 1,
            Image = tbl2.iconLeading,
            Size = UDim2.new(0, size400, 0, size400),
            ImageColor3 = tokens.Color.Content.Muted.Color3,
            ImageTransparency = tokens.Color.Content.Muted.Transparency,
            LayoutOrder = 1
        })
    else
        element = nil
    end

    tbl10.IconLeading = element

    tbl10.TextBox = React.createElement("TextBox", {
        ref = ref,
        Text = tbl2.text,
        TextInputType = if canUseTextInputType() then tbl2.textInputType or nil else nil,
        ClearTextOnFocus = false,
        Size = UDim2.new(1, getTextBoxWidthOffset(), 1, 0),
        TextEditable = not tbl2.disabled,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font),
        OpenTypeFeatures = if UIBloxConfig.enableOpenTypeSupport and tbl2.openTypeFeatures then tbl2.openTypeFeatures else nil,
        TextSize = tokens.Typography.BodyLarge.FontSize,
        LineHeight = 1,
        TextColor3 = tokens.Color.Content.Emphasis.Color3,
        TextTransparency = tokens.Color.Content.Emphasis.Transparency,
        PlaceholderText = tbl2.placeholder,
        PlaceholderColor3 = tokens.Color.Content.Default.Color3,
        ClipsDescendants = true,
        Selectable = false,
        LayoutOrder = 2,
        [React.Event.Focused] = onFocusGained,
        [React.Event.FocusLost] = onFocusLost,
        [React.Change.Text] = onTextChange
    })
    local element2

    if tbl2.iconButton then
        element2 = React.createElement(ImageSetComponent.Button, {
            BackgroundTransparency = 1,
            Image = tbl2.iconButton,
            Size = UDim2.new(0, size400, 0, size400),
            ImageColor3 = tokens.Color.Content.Muted.Color3,
            Selectable = not tbl2.disabled,
            SelectionImageObject = var1,
            LayoutOrder = 3,
            [React.Event.Activated] = if tbl2.disabled then nil else tbl2.onButtonPress
        })
    else
        element2 = nil
    end

    tbl10.IconButton = element2
    tbl8.BorderFrame = createElement4(str4, tbl9, tbl10)
    tbl6.Input = createElement3(str3, tbl7, tbl8)
    tbl4.InputCanvas = createElement2(str2, tbl5, tbl6)

    tbl4.HelperText = if tbl2.hint then React.createElement(HelperText, { text = tbl2.hint, error = tbl2.error, LayoutOrder = 3 }) else nil
    return createElement(str1, tbl3, tbl4)
end

return TextField
