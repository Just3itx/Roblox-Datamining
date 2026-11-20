-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Image = require(Foundation.Components.Image)
local StatusIndicator = require(Foundation.Components.StatusIndicator)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local mapBindable = require(Foundation.Utility.mapBindable)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local ThumbnailSize = require(Foundation.Enums.ThumbnailSize)
local ThumbnailType = require(Foundation.Enums.ThumbnailType)
local getRbxThumb = require(Foundation.Utility.getRbxThumb)

local useAvatarVariants = require(script.Parent.useAvatarVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local usePresentationContext = require(Foundation.Providers.Style.PresentationContext).usePresentationContext

local AvatarSize = require(Foundation.Enums.AvatarSize)

local UserPresence = require(Foundation.Enums.UserPresence)

local getAvatarSize = require(script.Parent.getAvatarSize)

local tbl1 = {
    size = AvatarSize.Medium,
    userPresence = UserPresence.None,
    testId = "--foundation-avatar"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Avatar
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = usePresentationContext()

    local var4 = useAvatarVariants(var2, var1.size, var1.userPresence, var1.backplateStyle, var3.isIconSize)
    local avatarSize = getAvatarSize(var2, var1.size, var3.isIconSize)

    local createElement = React.createElement
    local var5 = View
    local var6 = withCommonProps(var1, {
        tag = var4.container.tag,
        ref = ref,
        backgroundStyle = var4.container.backgroundStyle,
        stroke = var4.container.stroke,
        Size = UDim2.fromOffset(avatarSize, avatarSize)
    })
    local tbl2 = {
        Image = React.createElement(Image, {
            Image = mapBindable(var1.userId, function(arg2)
                return getRbxThumb(
                    ThumbnailType.AvatarHeadShot,
                    arg2,
                    ThumbnailSize.Medium,
                    {
                        includeProfileFrame = var1.includeProfileFrame
                    }
                )
            end),
            tag = var4.avatar.tag,
            backgroundStyle = var1.backgroundStyle,
            testId = `{var1.testId}--image`
        }),
        Indicator = 0
    }

    local element

    if var4.statusIndicator.isVisible then
        element = React.createElement(StatusIndicator, {
            testId = `{var1.testId}--status-indicator`,
            variant = var4.statusIndicator.variant,
            shape = var4.statusIndicator.shape,
            size = var4.statusIndicator.size,
            mask = var4.statusIndicatorMask.mask,
            ZIndex = var4.statusIndicatorMask.ZIndex,
            AnchorPoint = var4.statusIndicatorMask.AnchorPoint,
            Position = var4.statusIndicatorMask.Position
        })
    else
        element = nil
    end

    tbl2.Indicator = element
    return createElement(var5, var6, tbl2)
end))
