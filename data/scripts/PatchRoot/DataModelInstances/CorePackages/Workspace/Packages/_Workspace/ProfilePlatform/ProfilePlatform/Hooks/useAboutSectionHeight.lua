-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local GetTextSize = require(ProfilePlatformParent.Style).GetTextSize
local Responsive = require(ProfilePlatformParent.Responsive)
local useTokens = Foundation.Hooks.useTokens
local useIsSpatial = Responsive.useIsSpatial
local usePreferredInput = Responsive.usePreferredInput
local FFlagProfilePlatformFixBioTruncation = require(ProfilePlatform.Flags.FFlagProfilePlatformFixBioTruncation)

return function(str1: string?, x: number, num1: number)
    local var1 = useTokens()
    local bodyMedium = var1.Typography.BodyMedium
    local var2 = useIsSpatial()
    local bool1 = usePreferredInput() == Responsive.Input.Directional
    local var3 = var2 or bool1

    local useMemo = React.useMemo
    local function func1()
        local var4 = string.gsub(str1 or "", "[\r\n]+", " ")
        local textSizeY = GetTextSize(
            var4,
            bodyMedium.FontSize,
            bodyMedium.Font,
            Vector2.new(math.huge, math.huge),
            { addTemporaryPadding = false }
        ).Y

        local var5 = (if var3 then 1.3 else 1) * bodyMedium.LineHeight
        local var6 = if FFlagProfilePlatformFixBioTruncation then bodyMedium.FontSize * var5 * 2 else textSizeY * var5 + textSizeY

        if not str1 or str1 == "" then
            return 0, var6
        end

        local textSize = GetTextSize(str1, bodyMedium.FontSize, bodyMedium.Font, Vector2.new(x, math.huge), { addTemporaryPadding = false })

        return if var6 < textSize.Y then var6 + textSizeY + var1.Gap.XSmall else textSize.Y, var6
    end

    local fontSize = bodyMedium.FontSize
    local font = bodyMedium.Font
    local lineHeight = if FFlagProfilePlatformFixBioTruncation then bodyMedium.LineHeight else nil
    local tbl1 = {
        str1,
        fontSize,
        font,
        lineHeight,
        x,
        num1,
        var3,
        var1.Gap.XSmall
    }
    local var4, var5 = useMemo(func1, tbl1)

    return var4, var5
end
