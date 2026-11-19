-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:51:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Icon = BuilderIcons.Icon

local Button = require(Foundation.Components.Button)
local Icon2 = require(Foundation.Components.Icon)
local IconSize = require(Foundation.Enums.IconSize)
local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)

local Translator = require(Foundation.Utility.Localization.Translator)
local _Types = require(Foundation.Components.Types)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    icon = {
        name = "icons/status/oof_xlarge",
        size = IconSize.Large
    },
    text = Translator:FormatByKey("CommonUI.Controls.NoResultsFound"),
    button = {
        icon = Icon.TwoArrowsSpinClockwise,
        text = Translator:FormatByKey("CommonUI.Controls.Action.Refresh"),
        onActivated = nil
    },
    testId = "--foundation-empty"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Empty
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    return React.createElement(
        View,
        withCommonProps(var1, { tag = "col align-x-center align-y-center gap-small size-full auto-xy", ref = ref }),
        {
            Icon = React.createElement(
                Icon2,
                {
                    name = var1.icon.name,
                    size = var1.icon.size,
                    style = var2.Color.Content.Default,
                    LayoutOrder = 1
                }
            ),
            Text = React.createElement(Text, {
                Text = var1.text,
                LayoutOrder = 2,
                tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-center content-default",
                testId = `{var1.testId}--text`
            }),
            Button = if var1.button and var1.button.onActivated then React.createElement(
                Button,
                {
                    text = var1.button.text,
                    icon = var1.button.icon,
                    onActivated = var1.button.onActivated,
                    LayoutOrder = 3
                }
            ) else nil
        }
    )
end))
