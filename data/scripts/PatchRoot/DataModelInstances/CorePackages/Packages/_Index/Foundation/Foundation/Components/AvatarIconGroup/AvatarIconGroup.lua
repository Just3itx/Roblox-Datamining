-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local AvatarIcon = require(Foundation.Components.AvatarIcon)
local InternalAvatarGroup = require(Foundation.Components.InternalAvatarGroup)
local _Types = require(Foundation.Components.Types)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local AvatarIconSize = require(Foundation.Enums.AvatarIconSize)

local AvatarGroupType = require(Foundation.Enums.AvatarGroupType)

local useAvatarIconVariants = require(Foundation.Components.AvatarIcon.useAvatarIconVariants)

local function renderAvatarIcon(userId, arg1, size)
    return React.createElement(AvatarIcon, {
        userId = userId,
        key = arg1.key,
        backgroundStyle = arg1.backgroundStyle,
        backplateStyle = arg1.backplateStyle,
        size = size,
        LayoutOrder = arg1.LayoutOrder,
        Position = arg1.Position,
        ZIndex = arg1.ZIndex,
        testId = arg1.testId
    })
end

local tbl1 = {
    type = AvatarGroupType.Spread,
    max = math.huge,
    size = AvatarIconSize.Medium,
    testId = "--foundation-avatar-icon-group"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: AvatarIconGroup
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    local size = useAvatarIconVariants(var2, var1.size).container.size

    local size2 = var1.size
    local gap = if var1.type == AvatarGroupType.Spread then var2.Size.Size_200 elseif size2 == AvatarIconSize.Large or size2 == AvatarIconSize.Medium then -var2.Size.Size_50 else -var2.Size.Size_0

    return React.createElement(
        InternalAvatarGroup,
        withCommonProps(var1, {
            ref = ref,
            type = var1.type,
            max = var1.max,
            resolvedSize = size,
            gap = gap,
            isEllipsedOverflow = true,
            backplateStyle = var1.backplateStyle,
            avatars = var1.avatars,
            renderAvatar = function(userId, arg2)
                return renderAvatarIcon(userId, arg2, var1.size)
            end
        })
    )
end))
