-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local _UIBlox = require(AppBloxParent.UIBlox)

return {
    getDefaultStyleProps = function(arg1)
        return {
            borderRadius = UDim.new(0, arg1.Tokens.Radius.Medium),
            contentGap = arg1.Tokens.Size.Size_300,
            gutter = arg1.Tokens.Size.Size_600,
            titleFont = arg1.Font.Header1,
            titleTextColor = {
                Color = arg1.Tokens.Color.Content.Emphasis.Color3,
                Transparency = arg1.Tokens.Color.Content.Emphasis.Transparency
            }
        }
    end
}
