-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Avatar = require(Foundation.Components.Avatar)
local InputSize = require(Foundation.Enums.InputSize)

local InternalAvatarGroup = require(Foundation.Components.InternalAvatarGroup)
local _Types = require(Foundation.Components.Types)
local _UserPresence = require(Foundation.Enums.UserPresence)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local AvatarGroupType = require(Foundation.Enums.AvatarGroupType)

local usePresentationContext = require(Foundation.Providers.Style.PresentationContext).usePresentationContext

local getAvatarSize = require(Foundation.Components.Avatar.getAvatarSize)

local tbl1 = {
    type = AvatarGroupType.Spread,
    max = math.huge,
    size = InputSize.Medium,
    testId = "--foundation-avatar-group"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: AvatarGroup
    local var1 = withDefaults(arg1, tbl1)
    local var2 = usePresentationContext()
    local var3 = useTokens()
    local size = var1.size
    local size200

    if var1.type == AvatarGroupType.Spread then
        size200 = var3.Size.Size_200
    elseif var2.isIconSize then
        if size == InputSize.Large or size == InputSize.Medium then
            size200 = -var3.Size.Size_50
        else
            size200 = -var3.Size.Size_0
        end
    elseif size == InputSize.XSmall then
        size200 = -var3.Size.Size_50
    else
        size200 = -var3.Size.Size_100
    end

    local resolvedSize = getAvatarSize(var3, size, var2.isIconSize)
    local backplateStyle = var1.backplateStyle or var3.Color.Surface.Surface_0
    local renderAvatar = React.useCallback(function(userId, arg3)
        local userPresence

        if typeof(userId) == "table" then
            userPresence = userId.userPresence
            userId = userId.userId
        else
            userPresence = nil
        end

        return React.createElement(Avatar, {
            userId = userId,
            key = arg3.key,
            backgroundStyle = arg3.backgroundStyle,
            backplateStyle = arg3.backplateStyle,
            size = var1.size,
            userPresence = userPresence,
            LayoutOrder = arg3.LayoutOrder,
            Position = arg3.Position,
            ZIndex = arg3.ZIndex,
            testId = arg3.testId
        })
    end, { var1.size })

    return (React.createElement(
        InternalAvatarGroup,
        withCommonProps(var1, {
            ref = ref,
            type = var1.type,
            max = var1.max,
            resolvedSize = resolvedSize,
            isEllipsedOverflow = size == InputSize.XSmall or var2.isIconSize and size == InputSize.Small,
            gap = size200,
            backplateStyle = backplateStyle,
            avatars = var1.avatars,
            renderAvatar = renderAvatar
        })
    ))
end))
