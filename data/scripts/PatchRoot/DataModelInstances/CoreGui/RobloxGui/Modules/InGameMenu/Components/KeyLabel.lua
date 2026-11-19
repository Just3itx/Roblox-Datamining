-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local withStyle = UIBlox.Core.Style.withStyle

local scriptParentParent = script.Parent.Parent

local Assets = require(scriptParentParent.Resources.Assets)

local GlobalConfig = require(scriptParentParent.GlobalConfig)

local ThemedTextLabel = require(scriptParentParent.Components.ThemedTextLabel)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local tbl1 = {
    [Enum.KeyCode.Escape] = { text = "ESC", fontKey = "Footer", width = 36 },
    [Enum.KeyCode.Space] = { text = "Space", width = 92 },
    [Enum.KeyCode.LeftShift] = {
        text = "Shift",
        width = 66,
        alignment = Enum.TextXAlignment.Left
    },
    [Enum.KeyCode.LeftControl] = {
        text = "Ctrl",
        width = 66,
        alignment = Enum.TextXAlignment.Left
    },
    [Enum.KeyCode.LeftSuper] = { text = "Command" },
    [Enum.KeyCode.LeftMeta] = { text = "fn" },
    [Enum.KeyCode.LeftAlt] = { text = "Opt" },
    [Enum.KeyCode.Tilde] = { text = "~", fontKey = "CaptionHeader" },
    [Enum.KeyCode.F10] = { fontKey = "CaptionHeader", width = 36 },
    [Enum.KeyCode.F11] = { fontKey = "CaptionHeader", width = 36 },
    [Enum.KeyCode.Up] = {
        image = Assets.Images.UpArrow
    },
    [Enum.KeyCode.Down] = {
        image = Assets.Images.DownArrow
    },
    [Enum.KeyCode.Left] = {
        image = Assets.Images.LeftArrow
    },
    [Enum.KeyCode.Right] = {
        image = Assets.Images.RightArrow
    }
}
local var1 = t.strictInterface({
    input = t.enum(Enum.KeyCode),
    borderThemeKey = t.optional(t.string),
    textThemeKey = t.optional(t.string),
    AnchorPoint = t.optional(t.Vector2),
    Position = t.optional(t.UDim2),
    LayoutOrder = t.optional(t.integer),
    ZIndex = t.optional(t.integer)
})

local function getLabelWidthAndContent(keyCode: Enum.KeyCode, arg1, themeKey)
    local var2 = tbl1[keyCode]

    if var2 and var2.image then
        return 36, (Roact.createElement(ImageSetLabel, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = var2.image,
            ImageColor3 = arg1.Theme.IconEmphasis.Color,
            ImageTransparency = arg1.Theme.IconEmphasis.Transparency,
            Position = UDim2.new(0.5, 0, 0.5, -1),
            Size = UDim2.new(0, 16, 0, 16)
        }))
    end

    local alignment = nil

    local stringForKeyCode = UserInputService:GetStringForKeyCode(keyCode)
    local string2 = if var2 and var2.text then var2.text else stringForKeyCode and stringForKeyCode ~= "" and stringForKeyCode or keyCode.Name
    local bool1 = string2:len() < 3

    local fontKey = not (var2 and var2.fontKey) and (if bool1 then "CaptionHeader" else "Footer") or var2.fontKey
    local width

    if var2 and var2.width then
        width = var2.width
    elseif bool1 then
        width = 36
    else
        local var4 = arg1.Font[fontKey]

        local fontSize = var4.RelativeSize * arg1.Font.BaseSize
        local font = var4.Font

        width = TextService:GetTextSize(string2, fontSize, font, Vector2.new(math.huge, 36)).X + 28
    end

    if var2 and var2.alignment then
        alignment = var2.alignment
    end

    return width, Roact.createElement(ThemedTextLabel, {
        fontKey = fontKey,
        themeKey = themeKey or "TextEmphasis",
        Text = string2,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, -1),
        TextXAlignment = alignment
    }), alignment
end

local function KeyLabel(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    return withStyle(function(arg2)
        local var2 = arg2.Theme[arg1.borderThemeKey or "UIEmphasis"]

        local xOffset, labelContent, var4 = getLabelWidthAndContent(arg1.input, arg2, arg1.textThemeKey)

        local var5 = if var4 then 9 else nil

        return Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            ImageTransparency = var2.Transparency,
            ImageColor3 = var2.Color,
            Image = Assets.Images.KeyBorder,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(Vector2.new(9, 7), Vector2.new(26, 26)),
            Size = UDim2.new(0, xOffset, 0, 36),
            Position = arg1.Position,
            AnchorPoint = arg1.AnchorPoint,
            LayoutOrder = arg1.LayoutOrder,
            ZIndex = arg1.ZIndex
        }, {
            Padding = var5 and Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, var5), PaddingRight = UDim.new(0, var5) }),
            LabelContent = labelContent
        })
    end)
end

return KeyLabel
