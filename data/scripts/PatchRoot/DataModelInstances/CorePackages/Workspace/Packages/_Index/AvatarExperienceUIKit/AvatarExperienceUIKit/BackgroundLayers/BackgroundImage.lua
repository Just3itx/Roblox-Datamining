-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent

local React = require(AvatarExperienceUIKitParent.React)
local Dash = require(AvatarExperienceUIKitParent.Dash)
local connectImageLoaded = require(script.Parent.connectImageLoaded)

local FFlagAXBackgroundImageOnLoaded = require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXBackgroundImageOnLoaded

local tbl1 = {
    anchorPoint = Vector2.new(0.5, 0.5),
    color = Color3.fromRGB(255, 255, 255),
    position = UDim2.fromScale(0.5, 0.5),
    resourceIdentifier = "",
    scaleType = Enum.ScaleType.Fit
}

local function BackgroundImage(tbl2)
    tbl2 = Dash.join(tbl1, tbl2)
    local var1

    if FFlagAXBackgroundImageOnLoaded then
        local onLoaded = tbl2.onLoaded
        local resourceIdentifier = tbl2.resourceIdentifier

        local var2 = React.useRef(nil)
        var1 = React.useCallback(function(arg1)
            if var2.current then
                var2.current:Disconnect()
                var2.current = nil
            end
            if not arg1 or not onLoaded or resourceIdentifier == "" then
                return
            end
            var2.current = connectImageLoaded(arg1, onLoaded)
        end, { onLoaded, resourceIdentifier })
    else
        var1 = nil
    end

    local createElement = React.createElement
    local str1 = "ImageLabel"
    local tbl3 = {
        AnchorPoint = tbl2.anchorPoint,
        Position = tbl2.position,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = tbl2.resourceIdentifier,
        ImageColor3 = tbl2.color,
        ImageTransparency = tbl2.transparency,
        ScaleType = tbl2.scaleType,
        Size = UDim2.fromScale(1, 1),
        ZIndex = tbl2.ZIndex,
        [React.Tag] = tbl2.tag
    }

    if not (FFlagAXBackgroundImageOnLoaded and tbl2.onLoaded) then
        var1 = nil
    end

    tbl3.ref = var1
    return createElement(str1, tbl3, { CornerRadius = React.createElement("UICorner", { CornerRadius = tbl2.cornerRadius }) })
end

return BackgroundImage
