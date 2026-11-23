-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)

local BackgroundHighlight = require(script.Parent.BackgroundHighlight)
local useBackgroundHighlightProps = require(script.Parent.useBackgroundHighlightProps)

local function BackgroundHighlightContainer(arg1)
    local var1 = useBackgroundHighlightProps(arg1)
    return React.createElement(BackgroundHighlight, var1)
end

return BackgroundHighlightContainer
