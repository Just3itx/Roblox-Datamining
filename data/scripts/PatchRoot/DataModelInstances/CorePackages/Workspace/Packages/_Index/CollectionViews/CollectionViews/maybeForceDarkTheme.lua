-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent

local React = require(CollectionViewsParent.React)
local Style = require(CollectionViewsParent.Style)
local UiModeStyleProvider = Style.UiModeStyleProvider
local DesignTokenProvider = Style.DesignTokenProvider

local function maybeForceDarkTheme(content, bool1: boolean?)
    if not bool1 then
        return content
    end

    return React.createElement(
        UiModeStyleProvider,
        {
            style = { themeName = "Dark", fontName = nil }
        },
        {
            DesignTokenProvider = React.createElement(DesignTokenProvider, { tokenMappers = {} }, { Content = content })
        }
    )
end
return maybeForceDarkTheme
