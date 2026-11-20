-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParent.Parent.Parent

local React = require(scriptParentParentParentParentParent.React)

local StatGroup = require(scriptParentParentParent.Indicator.StatGroup)
local FooterFrame = require(scriptParent.FooterFrame)

local function SocialProofFooter(arg1)
    return React.createElement(
        FooterFrame,
        arg1,
        {
            Stats = React.createElement(StatGroup, { ratingText = arg1.ratingText, playingText = arg1.playingText })
        }
    )
end

return SocialProofFooter
