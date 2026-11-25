-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local useScreenSize = require(ProfilePlatformParent.RobloxAppHooks).useScreenSize

local View = Foundation.View

local LoadableImage = require(ProfilePlatformParent.UIBlox).App.Loading.LoadableImage

local Enums = require(ProfilePlatform.Common.Enums)

local function interpolateHeight(num1: number, num2: number, num3: number): number -- Luacid: unused: defined but never referenced
    return num1 + (num2 - num1) * num3
end

local function CoverPhoto(tbl1)
    local bool1 = tbl1.profileFormFactorInfo.formFactor == Enums.ProfileFormFactor.Wide
    local bool2 = tbl1.profileFormFactorInfo.formFactor == Enums.ProfileFormFactor.PeekView
    local isFullView = tbl1.profileFormFactorInfo.isFullView

    local var1 = useScreenSize()
    local yOffset = React.useMemo(function(): number
        return if bool2 then 393 else 456
    end, { bool2, isFullView, tbl1.peekViewOpenPercent })

    local var2 = React.useMemo(function()
        if bool2 and not isFullView then
            return tbl1.peekViewOpenPercent * 98 + 295
        end

        return yOffset
    end, {
        bool2,
        isFullView,
        tbl1.peekViewOpenPercent,
        yOffset
    })
    local offset = var2 - 100
    local yOffset2 = var2 - tbl1.parallaxOffset
    local yOffset3 = offset - tbl1.parallaxOffset
    local uDim = if isFullView then UDim.new(0, var1.X) else UDim.new(1, 0)
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            Size = UDim2.new(uDim, UDim.new(0, offset)),
            ZIndex = -1
        },
        {
            ParallaxWrapper = React.createElement(
                View,
                {
                    Size = UDim2.new(1, 0, 0, yOffset3),
                    Position = UDim2.new(0, 0, 0, tbl1.parallaxOffset)
                },
                {
                    CoverPhotoWrapper = React.createElement(View, {
                        Size = UDim2.new(1, 0, 0, yOffset2),
                        ClipsDescendants = true
                    }, {
                        CoverPhoto = React.createElement(LoadableImage, {
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundTransparency = 1,
                            Image = tbl1.coverPhotoThumbnail,
                            Position = UDim2.fromScale(0.5, 0.5),
                            ScaleType = Enum.ScaleType.Crop,
                            Size = UDim2.new(1, 0, 0, yOffset),
                            useShimmerAnimationWhileLoading = true
                        })
                    }),
                    GradientWrapper = React.createElement(View, {
                        Size = UDim2.new(1, 0, 0, 100),
                        Position = UDim2.new(0, 0, 0, yOffset3),
                        tag = if bool1 then "bg-surface-0" elseif isFullView then "bg-surface-0" else "bg-surface-100"
                    }, {
                        Gradient = React.createElement("UIGradient", {
                            Rotation = 270,
                            Transparency = NumberSequence.new({
                                NumberSequenceKeypoint.new(0, 0),
                                NumberSequenceKeypoint.new(0.25, 0),
                                NumberSequenceKeypoint.new(0.5, 0.1),
                                NumberSequenceKeypoint.new(0.75, 0.5),
                                NumberSequenceKeypoint.new(1, 1)
                            })
                        })
                    })
                }
            )
        }
    )
end

return CoverPhoto
