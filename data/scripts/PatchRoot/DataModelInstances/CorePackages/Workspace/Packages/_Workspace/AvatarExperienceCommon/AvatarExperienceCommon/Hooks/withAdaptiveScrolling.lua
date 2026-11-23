-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local Dash = require(AvatarExperienceCommonParent.Dash)
local React = require(AvatarExperienceCommonParent.React)
local AdaptiveScrollingContext = require(script.Parent.AdaptiveScrollingContext)
local _AppCommonLib = require(AvatarExperienceCommonParent.AppCommonLib)

local function withAdaptiveScrolling(arg1)
    return function(arg2)
        return React.createElement(AdaptiveScrollingContext.Consumer, {
            render = function(adaptiveScrolling)
                return React.createElement(arg1, Dash.join(arg2, { adaptiveScrolling = adaptiveScrolling }))
            end
        })
    end
end

return withAdaptiveScrolling
