-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)

local BackgroundGradient = require(script.Parent.BackgroundGradient)
local BackgroundImage = require(script.Parent.BackgroundImage)

local FFlagAXBackgroundImageOnLoaded = require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXBackgroundImageOnLoaded

local function BackgroundLayers(tbl1)
    local tbl2 = ({})
    for k, backgroundLayer in tbl1.backgroundLayers do
        local zIndex = (tbl1.ZIndex or 0) - (#tbl1.backgroundLayers - k)
        if backgroundLayer.type == "GradientBackground" then
            local str1 = `GradientBackground_{k}`
            tbl2[str1] = React.createElement(BackgroundGradient, {
                colorSequence = backgroundLayer.colorSequence,
                cornerRadius = tbl1.cornerRadius,
                offset = backgroundLayer.offset,
                rotation = backgroundLayer.rotation,
                transparency = backgroundLayer.transparency,
                ZIndex = zIndex,
                tag = backgroundLayer.tag
            })
        elseif backgroundLayer.type == "ImageBackground" then
            local str1 = `ImageBackground_{k}`
            tbl2[str1] = React.createElement(BackgroundImage, {
                anchorPoint = backgroundLayer.anchorPoint,
                color = backgroundLayer.color,
                cornerRadius = tbl1.cornerRadius,
                position = backgroundLayer.position,
                resourceIdentifier = backgroundLayer.resourceIdentifier,
                transparency = backgroundLayer.transparency,
                ZIndex = zIndex,
                tag = backgroundLayer.tag,
                scaleType = tbl1.imageScaleType,
                onLoaded = if FFlagAXBackgroundImageOnLoaded then tbl1.onImageLoaded else nil
            })
        end
    end
    return React.createElement(React.Fragment, nil, tbl2)
end

return BackgroundLayers
