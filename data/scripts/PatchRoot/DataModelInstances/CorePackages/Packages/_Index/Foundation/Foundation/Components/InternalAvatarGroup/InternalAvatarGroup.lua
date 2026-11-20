-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local Icon = BuilderIcons.Icon

local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local Icon2 = require(Foundation.Components.Icon)
local IconSize = require(Foundation.Enums.IconSize)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local AvatarGroupType = require(Foundation.Enums.AvatarGroupType)

local _UserPresence = require(Foundation.Enums.UserPresence)

local usePresentationContext = require(Foundation.Providers.Style.PresentationContext).usePresentationContext
local getBindableValue = require(Foundation.Utility.getBindableValue)
local useCumulativeBackground = require(Foundation.Utility.useCumulativeBackground)

local tbl1 = {
    type = AvatarGroupType.Spread,
    isEllipsedOverflow = false,
    max = math.huge,
    testId = "--foundation-avatar-group"
}

local function AvatarOverflow(arg1)
    local var1 = useTokens()
    local var2 = usePresentationContext()
    local backgroundStyle = useCumulativeBackground(arg1.backplateStyle, arg1.backgroundStyle)
    local str1 = if arg1.isEllipsed then "text-caption-small" else "text-caption-medium"
    local emphasis = var1[var2.colorNamespace or ColorNamespace.Color].Content.Emphasis
    local createElement = React.createElement
    local var4 = View
    local var5 = withCommonProps(
        arg1,
        {
            Size = arg1.Size,
            backgroundStyle = backgroundStyle,
            tag = "row align-x-center align-y-center radius-circle"
        }
    )
    local element

    if arg1.isEllipsed then
        element = React.createElement(Icon2, {
            name = Icon.ThreeDotsHorizontal,
            size = IconSize.XSmall,
            style = emphasis,
            testId = `{arg1.testId}--ellipses`
        })
    else
        element = React.createElement(Text, {
            Text = `+{arg1.count}`,
            tag = `auto-xy text-align-x-center {str1}`,
            textStyle = emphasis,
            testId = `{arg1.testId}--text`
        })
    end

    return createElement(var4, var5, element)
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: InternalAvatarGroup
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local shift300 = var2[usePresentationContext().colorNamespace or ColorNamespace.Color].Shift.Shift_300
    local backplateStyle = var1.backplateStyle or var2.Color.Surface.Surface_0

    local resolvedSize = var1.resolvedSize
    local var4 = resolvedSize + var1.gap

    local tbl2 = ({})
    for layoutOrder, avatar in var1.avatars do
        local var5 = if ReactIs.isBinding(avatar) or typeof(avatar) == "number" or typeof(avatar) ~= "table" then avatar else avatar.userId
        local key = tostring(getBindableValue(var5))

        local uDim2 = UDim2.fromOffset(var4 * (layoutOrder - 1), 0)
        local zIndex = #var1.avatars - (layoutOrder - 1)

        if var1.max < layoutOrder then
            tbl2[layoutOrder] = React.createElement(AvatarOverflow, {
                key = "overflow",
                count = #var1.avatars - var1.max,
                isEllipsed = var1.isEllipsedOverflow,
                Size = UDim2.fromOffset(resolvedSize, resolvedSize),
                LayoutOrder = layoutOrder,
                Position = uDim2,
                ZIndex = zIndex,
                backgroundStyle = shift300,
                backplateStyle = backplateStyle,
                testId = `{var1.testId}--avatar-overflow`
            })
            break
        end

        local renderAvatar = var1.renderAvatar
        local tbl3 = {
            key = key,
            LayoutOrder = layoutOrder,
            Position = uDim2,
            ZIndex = zIndex,
            testId = `{var1.testId}--avatar-{key}`,
            backgroundStyle = shift300,
            backplateStyle = backplateStyle
        }
        tbl2[layoutOrder] = renderAvatar(avatar, tbl3)
    end

    return React.createElement(View, withCommonProps(var1, { ref = ref, tag = "auto-xy" }), tbl2)
end))
