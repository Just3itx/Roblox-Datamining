-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local usePulseAnimationBinding = require(AvatarExperienceControlBarParent.AvatarExperienceCommon).Hooks.usePulseAnimationBinding

local useSemanticTokens = require(AvatarExperienceControlBar.Hooks.useSemanticTokens)
local useHoverBinding = require(AvatarExperienceControlBar.Hooks.useHoverBinding)

return React.forwardRef(function(tbl1, ref) -- name: ImageItem
    local var1 = useSemanticTokens()
    local var2, onStateChanged = useHoverBinding()
    local var3 = React.useRef(nil)
    local var5 = if tbl1.size then tbl1.size else var1.defaultIconContainerSize
    local var6 = usePulseAnimationBinding(tbl1.enableFocusAnimation)

    return React.createElement(Foundation.View, {
        tag = "auto-xy radius-circle",
        ref = ref,
        LayoutOrder = tbl1.LayoutOrder,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        onStateChanged = onStateChanged,
        onActivated = tbl1.onActivated,
        disabled = tbl1.disabled,
        Visible = tbl1.Visible
    }, {
        Thumbnail = React.createElement(Foundation.Image, {
            Image = tbl1.thumbnailUrl,
            Size = UDim2.fromOffset(var5, var5),
            tag = "radius-circle",
            backgroundStyle = var2:map(function(arg1)
                return if arg1 then var1.hoverThumbnailBackgroundStyle else var1.thumbnailBackgroundStyle
            end)
        }),
        Indicator = if tbl1.hideIndicator then nil else React.createElement(
            Foundation.View,
            {
                tag = "auto-xy position-bottom-right anchor-bottom-right bg-surface-300 radius-circle size-400-400",
                ZIndex = 2
            },
            {
                IndicatorImage = React.createElement(Foundation.Image, {
                    Image = "icons/actions/truncationExpand_small",
                    imageStyle = var1.contentForegroundStyle,
                    tag = "radius-circle position-center-center anchor-center-center size-250-250"
                })
            }
        ),
        UIStroke = if tbl1.enableFocusAnimation then React.createElement("UIStroke", {
            Color = var1.imageBorderFocusStyle,
            Thickness = var6:map(function(arg1)
                return arg1.thickness
            end),
            Transparency = var6:map(function(arg1)
                return arg1.transparency
            end),
            ref = var3
        }) else nil
    })
end)
