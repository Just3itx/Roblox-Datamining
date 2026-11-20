-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace

local React = require(scriptParentParentParentParentParent.React)
local LuauPolyfill = require(scriptParentParentParentParentParent.LuauPolyfill)

local _Types = require(scriptParent.Types)
local Constants = require(scriptParent.Constants)
local Utilities = require(scriptParent.Utilities)
local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)
local Images = require(scriptParentParentParent.ImageSet.Images)
local Label = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent).Label

local function KeyLabel(tbl1)
    local var1 = useStyle()

    local var2 = var1.Theme[tbl1.iconThemeKey or Constants.DEFAULT_ICON_THEME]
    local keyCodeContent = Utilities.getKeyCodeContent(tbl1.keyCode)
    local widthFromContent = Utilities.getWidthFromContent(keyCodeContent, var1.Font)

    local tbl2 = {
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        LayoutOrder = tbl1.LayoutOrder,
        ZIndex = tbl1.ZIndex,
        [React.Change.AbsoluteSize] = tbl1[React.Change.AbsoluteSize],
        Size = UDim2.fromOffset(widthFromContent, Constants.HEIGHT)
    }

    if keyCodeContent.inputType ~= "keyboard" then
        if keyCodeContent.inputType ~= "gamepad" then
            assert(false, string.format("Unreachable: Invalid inputType value: \"%s\"", keyCodeContent.inputType))
            return
        end

        return React.createElement(
            Label,
            LuauPolyfill.Object.assign(tbl2, {
                Image = keyCodeContent.content,
                ImageColor3 = var2.Color,
                ImageTransparency = var2.Transparency,
                BackgroundTransparency = 1
            })
        )
    end

    local var3 = var1.Theme[tbl1.textThemeKey or Constants.DEFAULT_TEXT_THEME]
    local font = var1.Font
    local baseSize = font.BaseSize

    local captionHeader = font.CaptionHeader
    local textSize = baseSize * captionHeader.RelativeSize

    local str1 = ""
    local element = nil
    if type(keyCodeContent.content) == "string" then
        str1 = keyCodeContent.content
    else
        local var5 = keyCodeContent.content.ImageRectSize / Images.ImagesResolutionScale
        element = React.createElement(Label, {
            Image = keyCodeContent.content,
            ImageColor3 = var3.Color,
            ImageTransparency = var3.Transparency,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(var5.X, var5.Y),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5)
        })
    end

    return React.createElement(
        Label,
        LuauPolyfill.Object.assign(tbl2, {
            BackgroundTransparency = 1,
            ImageTransparency = var2.Transparency,
            ImageColor3 = var2.Color,
            Image = Images["icons/controls/keys/key_single"],
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(Vector2.new(10, 9), Vector2.new(25, 25))
        }),
        {
            LabelContent = React.createElement("TextLabel", {
                Text = str1,
                BackgroundTransparency = 1,
                TextColor3 = var3.Color,
                TextTransparency = var3.Transparency,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextSize = textSize,
                FontFace = normalizeFontFace(GetFontFromFontStyle(captionHeader)),
                RichText = false,
                Position = UDim2.fromOffset(0, Constants.TEXT_CENTER_OFFSET),
                Size = UDim2.fromScale(1, 1)
            }, { Icon = element })
        }
    )
end

return KeyLabel
