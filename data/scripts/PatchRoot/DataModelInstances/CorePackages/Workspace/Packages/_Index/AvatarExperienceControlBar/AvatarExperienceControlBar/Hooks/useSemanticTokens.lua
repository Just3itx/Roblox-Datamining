-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBarParent = script:FindFirstAncestor("AvatarExperienceControlBar").Parent
local Foundation = require(AvatarExperienceControlBarParent.Foundation)

local function useSemanticTokens()
    local var1 = Foundation.Hooks.useTokens()

    return {
        defaultIconContainerSize = var1.Size.Size_900,
        defaultIconSize = var1.Size.Size_900,
        defaultLegacyIconSize = var1.Size.Size_600,
        closeIconSize = var1.Size.Size_600,
        activeIconBackgroundStyle = var1.Color.Shift.Shift_400,
        hoverIconBackgroundStyle = var1.Color.Shift.Shift_200,
        thumbnailBackgroundStyle = var1.Color.Surface.Surface_200,
        tooltipBackgroundStyle = var1.Color.Surface.Surface_300,
        hoverThumbnailBackgroundStyle = var1.Color.Shift.Shift_400,
        imageBorderFocusStyle = var1.Color.ActionEmphasis.Background.Color3,
        borderStrokeThickness = var1.Stroke.Standard,
        borderStrokeTransparency = 0.5,
        defaultIconTextButtonRadius = var1.Size.Size_200,
        iconTextButtonIconContainerSize = var1.Size.Size_900,
        textButtonPaddingLeft = var1.Size.Size_200,
        textButtonPaddingRight = var1.Size.Size_400,
        textButtonPaddingY = var1.Size.Size_150,
        contentForegroundStyle = var1.Color.Content.Emphasis,
        contentDisabledTransparency = 0.68,
        menuBackgroundStyle = var1.Color.OverMedia.OverMedia_0,
        defaultIconTextMenuRadius = var1.Size.Size_200,
        iconOnlyMenuItemGap = var1.Size.Size_150
    }
end

return useSemanticTokens
