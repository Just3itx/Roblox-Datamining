-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local AppComposition = require(MomentsParent.AppComposition)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local Skeleton = Foundation.Skeleton
local View = Foundation.View

local Radius = Foundation.Enums.Radius

local useCompositionLayout = AppComposition.useCompositionLayout
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useFormFactor = MomentsCommon.Hooks.useFormFactor
local useTokens = Foundation.Hooks.useTokens

local FormFactor = MomentsCommon.Enums.FormFactor
local GradientBackdrop = MomentsCommon.Components.GradientBackdrop

local momentLayout = require(script.Parent.momentLayout)
local MomentOverlayInsetContext = require(script.Parent.MomentOverlayInsetContext)
local MomentPushedFeedSafeAreaContext = require(script.Parent.MomentPushedFeedSafeAreaContext)
local FFlagMomentsFeedAboveNavBar = require(Moments.Flags.FFlagMomentsFeedAboveNavBar)

local function MomentItemSkeleton(tbl1)
    local var1 = useTokens()
    local var2 = useFormFactor()
    local var3 = useCompositionLayout()
    local var4 = useDeviceInsets()
    local bool1 = var2 == FormFactor.Wide
    local margin = var3.margin
    local size, var6 = React.useBinding(UDim2.fromScale(1, 0))

    local var7 = 2 * var1.Padding.XLarge
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var6(UDim2.new(1, 0, 0, arg1.AbsoluteSize.Y + var7))
    end, { var7 })

    local var9 = MomentPushedFeedSafeAreaContext.useMomentPushedFeedSafeArea()
    if var9 == nil then
        var9 = var4
    end

    local var10 = MomentOverlayInsetContext.useMomentOverlayInset()

    local bool2 = var10 > 0
    local num1

    if FFlagMomentsFeedAboveNavBar then
        num1 = 0
        if var10 > 0 then
            bool2 = true
        else
            bool2 = false
        end
    else
        num1 = var10
    end
    local num2 = math.max(var1.Padding.XLarge, if var9 == nil then 0 else var9.bottom)
    local offset = if bool2 then var1.Padding.Medium + num1 else num2 + num1
    local tbl2 = {
        CreatorRow = React.createElement(
            View,
            { LayoutOrder = 1, tag = "row align-x-left align-y-center gap-small auto-xy" },
            {
                Avatar = React.createElement(
                    Skeleton,
                    {
                        LayoutOrder = 1,
                        radius = Radius.Circle,
                        Size = UDim2.fromOffset(momentLayout.AVATAR_SIZE, momentLayout.AVATAR_SIZE)
                    }
                ),
                Username = React.createElement(Skeleton, {
                    LayoutOrder = 2,
                    radius = Radius.Medium,
                    Size = UDim2.fromOffset(momentLayout.USERNAME_SHIMMER.X, momentLayout.USERNAME_SHIMMER.Y)
                })
            }
        ),
        Description = React.createElement(
            Skeleton,
            {
                LayoutOrder = 2,
                radius = Radius.Medium,
                Size = UDim2.fromOffset(if bool1 then 280 else 200, 14)
            }
        ),
        Experience = React.createElement(
            Skeleton,
            {
                LayoutOrder = 3,
                radius = Radius.Medium,
                Size = UDim2.fromOffset(var1.Size.Size_1000, var1.Size.Size_1000)
            }
        )
    }
    local bottomUiMaxSize = momentLayout.BOTTOM_UI_MAX_SIZE
    local element

    if var9 ~= nil then
        local padding = {
            top = UDim.new(0, var1.Padding.XLarge),
            left = UDim.new(0, math.max(margin, var9.left)),
            right = UDim.new(0, math.max(margin, var9.right)),
            bottom = UDim.new(0, offset)
        }
        element = React.createElement(View, {
            tag = "col align-x-left align-y-bottom gap-medium position-bottom-center anchor-bottom-center size-full-0 auto-y",
            padding = padding,
            testId = "--moments-moment-item-skeleton-info-frame",
            sizeConstraint = { MaxSize = bottomUiMaxSize },
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            ZIndex = 2
        }, tbl2)
    else
        element = React.createElement(View, {
            tag = "col align-x-left align-y-bottom gap-medium position-bottom-center anchor-bottom-center size-full-0 auto-y",
            padding = {
                top = UDim.new(0, var1.Padding.XLarge),
                left = UDim.new(0, margin),
                right = UDim.new(0, margin),
                bottom = UDim.new(0, offset)
            },
            testId = "--moments-moment-item-skeleton-info-frame",
            sizeConstraint = { MaxSize = bottomUiMaxSize },
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            ZIndex = 2
        }, tbl2)
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "size-full clip bg-surface-0"
    }, {
        Media = React.createElement(
            View,
            { tag = "size-full", ZIndex = 1 },
            {
                Shimmer = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1) })
            }
        ),
        Overlay = React.createElement(
            View,
            { tag = "position-bottom-center anchor-bottom-center size-full-0 auto-y", ZIndex = 2 },
            {
                Backdrop = React.createElement(GradientBackdrop, { color3 = var1.Color.Common.Scrim.Color3, rotation = 270, size = size }),
                InfoFrame = element
            }
        )
    })
end
return MomentItemSkeleton
