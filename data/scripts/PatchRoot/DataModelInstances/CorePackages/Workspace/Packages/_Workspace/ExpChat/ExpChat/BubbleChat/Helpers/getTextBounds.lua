-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local ExpChat = script:FindFirstAncestor("ExpChat")
local TextChatService = game:GetService("TextChatService")
local TextService = game:GetService("TextService")

local getAbsolutePaddingbyDimension = require(ExpChat.BubbleChat.Helpers.getAbsolutePaddingbyDimension)
local getFFlagExpChatAlwaysRunTCS = require(ExpChat.Parent.SharedFlags).getFFlagExpChatAlwaysRunTCS

local function func1(textLabelText: string, arg1)
    local richTextSizingLabel = Instance.new("ScreenGui")
    richTextSizingLabel.Enabled = false
    richTextSizingLabel.Name = "RichTextSizingLabel"
    richTextSizingLabel.Parent = CoreGui

    local textLabel = Instance.new("TextLabel")
    textLabel.TextWrapped = true
    textLabel.RichText = true
    textLabel.Parent = richTextSizingLabel
    textLabel.Text = textLabelText
    textLabel.TextSize = arg1.TextSize

    if arg1.FontFace then
        textLabel.FontFace = arg1.FontFace
    else
        textLabel.Font = arg1.Font
    end
    textLabel.Size = UDim2.fromOffset(arg1.MaxWidth, 10000)

    local textBounds = textLabel.TextBounds

    richTextSizingLabel:Destroy()
    local var1

    if arg1.UIPadding then
        local absolutePaddingbyDimension = getAbsolutePaddingbyDimension(arg1.UIPadding.PaddingLeft, textBounds.X)
        local absolutePaddingbyDimension2 = getAbsolutePaddingbyDimension(arg1.UIPadding.PaddingRight, textBounds.X)
        local absolutePaddingbyDimension3 = getAbsolutePaddingbyDimension(arg1.UIPadding.PaddingTop, textBounds.Y)
        local absolutePaddingbyDimension4 = getAbsolutePaddingbyDimension(arg1.UIPadding.PaddingBottom, textBounds.Y)

        var1 = Vector2.new(
            (absolutePaddingbyDimension + absolutePaddingbyDimension2) * 2,
            absolutePaddingbyDimension3 + absolutePaddingbyDimension4
        )
    else
        local padding = arg1.Padding
        var1 = Vector2.new(padding * 4, padding * 2)
    end

    return var1 + textBounds
end

return function(string: string, arg1, arg2)
    if arg2 == nil then
        arg2 = TextChatService
    end
    if getFFlagExpChatAlwaysRunTCS() or arg2.ChatVersion == Enum.ChatVersion.TextChatService then
        return (func1(string, arg1))
    end

    return TextService:GetTextSize(string, arg1.TextSize, arg1.Font, Vector2.new(arg1.MaxWidth, 10000)) + Vector2.new(arg1.Padding * 4, arg1.Padding * 2)
end
