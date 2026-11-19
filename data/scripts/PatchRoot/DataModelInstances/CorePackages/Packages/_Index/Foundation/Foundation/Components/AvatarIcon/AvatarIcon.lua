-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:11:21Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local mapBindable = require(Foundation.Utility.mapBindable)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local ThumbnailSize = require(Foundation.Enums.ThumbnailSize)
local ThumbnailType = require(Foundation.Enums.ThumbnailType)
local getRbxThumb = require(Foundation.Utility.getRbxThumb)

local AvatarIconSize = require(Foundation.Enums.AvatarIconSize)

local useAvatarIconVariants = require(script.Parent.useAvatarIconVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)

local tbl1 = {
    size = AvatarIconSize.Medium,
    testId = "--foundation-avatar-icon"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: AvatarIcon
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    local var3 = useAvatarIconVariants(var2, var1.size, var1.backplateStyle)

    return React.createElement(
        View,
        withCommonProps(var1, {
            tag = var3.container.tag,
            ref = ref,
            stroke = var3.container.stroke,
            backgroundStyle = var1.backplateStyle,
            Size = UDim2.fromOffset(var3.container.size, var3.container.size)
        }),
        {
            Image = React.createElement(Image, {
                Image = mapBindable(var1.userId, function(arg2)
                    return getRbxThumb(ThumbnailType.AvatarHeadShot, arg2, ThumbnailSize.Medium)
                end),
                tag = var3.avatar.tag,
                backgroundStyle = var1.backgroundStyle
            })
        }
    )
end))
