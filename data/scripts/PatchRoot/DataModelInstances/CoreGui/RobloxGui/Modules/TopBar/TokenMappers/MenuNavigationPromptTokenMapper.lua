-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _Style = require(CorePackages.Workspace.Packages.Style)

return function(_, arg1)
    return {
        Color = {
            backgroundUiColor = arg1.Color.Surface.Surface_300,
            separatorColor = arg1.Color.Stroke.Emphasis,
            textColor = arg1.Color.Content.Emphasis,
            buttonColor = arg1.Color.Content.Emphasis,
            buttonTextColor = arg1.Color.Surface.Surface_300
        },
        Size = {
            displayWidth = 1920,
            promptWidth = 1080,
            imageWidth = 566,
            imageHeight = 324,
            buttonHeight = arg1.Size.Size_1200,
            iconSize = arg1.Size.Size_400
        },
        Space = {
            titlePadding = arg1.Size.Size_300,
            bodyPadding = arg1.Size.Size_600,
            iconPadding = arg1.Size.Size_100
        },
        Radius = {
            cornerRadius = arg1.Radius.Medium,
            buttonRadius = arg1.Radius.Small
        },
        Typography = {
            label = arg1.Typography.TitleLarge,
            header = arg1.Typography.HeadingSmall,
            caption = arg1.Typography.BodyLarge
        }
    }
end
