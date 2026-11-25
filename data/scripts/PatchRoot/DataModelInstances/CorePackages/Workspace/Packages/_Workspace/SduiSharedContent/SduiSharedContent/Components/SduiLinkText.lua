-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local React = require(SduiSharedContentParent.React)
local Cryo = require(SduiSharedContentParent.Cryo)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)
local checkAndFormatPossibleLink = require(SduiSharedContentParent.CollectionViews).checkAndFormatPossibleLink
local SduiText = require(script.Parent.SduiText)

local useTokens = Foundation.Hooks.useTokens

local FFlagSduiLinkTextStyleOverride = require(SduiSharedContent.Flags.FFlagSduiLinkTextStyleOverride)

local function SduiLinkText(arg1)
    local var1 = useTokens()
    local text = arg1.text
    local richText = arg1.richText

    if text then
        local color3 = if arg1.linkStyle and arg1.linkStyle.Color3 then arg1.linkStyle.Color3 else var1.Color.Content.Link.Color3
        local var2 = string.format("rgb(%d, %d, %d)", math.round(color3.R * 255), math.round(color3.G * 255), math.round(color3.B * 255))

        local bool1 = not FFlagSduiLinkTextStyleOverride or arg1.isLinkBold ~= false
        local bool2 = if FFlagSduiLinkTextStyleOverride then arg1.isLinkUnderlined == true else false
        local str1 = `<font color="{var2}">`
        local str2 = "</font>"

        if bool2 then
            str1 ..= "<u>"
            str2 = "</u>" .. str2
        end

        if bool1 then
            str1 ..= "<b>"
            str2 = "</b>" .. str2
        end

        local var3, var4 = checkAndFormatPossibleLink(text, nil, nil, str1, str2)
        if var3 then
            text = var4
            richText = true
        end
    end

    return React.createElement(
        SduiText,
        Cryo.Dictionary.join(arg1, {
            text = text,
            richText = richText,
            linkStyle = Cryo.None,
            isLinkBold = if FFlagSduiLinkTextStyleOverride then Cryo.None else nil,
            isLinkUnderlined = if FFlagSduiLinkTextStyleOverride then Cryo.None else nil
        })
    )
end

return SduiLinkText
