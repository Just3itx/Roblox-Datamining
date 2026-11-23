-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)

local useTokens = Foundation.Hooks.useTokens
local Icon = Foundation.Icon
local View = Foundation.View
local FoundationText = Foundation.Text
local withDefaults = Foundation.Utility.withDefaults
local withCommonProps = Foundation.Utility.withCommonProps

local IconSize = Foundation.Enums.IconSize

local IconPosition = Foundation.Enums.IconPosition

local tbl1 = { testId = "--badge" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: BannerBadge
    local var1 = withDefaults(arg1, tbl1)

    local var2 = useTokens()

    local xSmall = IconSize.XSmall

    local var3 = React.useMemo(function()
        return if typeof(var1.icon) == "string" then {
            name = var1.icon,
            position = IconPosition.Left
        } else var1.icon
    end, { var1.icon })

    local bool1 = not (var1.text == nil) and #var1.text > 0
    local tbl2 = {
        container = {
            tag = "radius-circle row align-y-center align-x-center gap-xsmall",
            backgroundStyle = var2.Color.Shift.Shift_300,
            stroke = nil
        },
        text = { tag = "auto-xy text-label-small" },
        content = {
            style = var2.Color.Content.Emphasis
        }
    }

    if not bool1 then
        tbl2.container.tag = tbl2.container.tag .. " size-600"
    else
        tbl2.container.tag = tbl2.container.tag .. " size-0-600 auto-x padding-x-small"
    end

    local icon = if var3 == nil then nil else React.createElement(Icon, {
        name = var3.name,
        variant = var3.variant,
        size = xSmall,
        style = tbl2.content.style,
        LayoutOrder = if var3.position == IconPosition.Left then 1 else 3,
        testId = `{var1.testId}--icon`
    })
    return React.createElement(
        View,
        withCommonProps(var1, { backgroundStyle = tbl2.container.backgroundStyle, tag = tbl2.container.tag, ref = ref }),
        {
            Icon = icon,
            Text = if bool1 then React.createElement(FoundationText, {
                Text = var1.text,
                textStyle = tbl2.content.style,
                RichText = true,
                LayoutOrder = 2,
                tag = tbl2.text.tag,
                testId = `{var1.testId}--text`
            }) else nil
        }
    )
end))
