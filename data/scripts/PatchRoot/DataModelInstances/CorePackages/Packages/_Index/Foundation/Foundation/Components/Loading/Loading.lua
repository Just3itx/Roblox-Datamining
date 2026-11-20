-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Icon = require(Foundation.Components.Icon)
local View = require(Foundation.Components.View)

local IconSize = require(Foundation.Enums.IconSize)

local _Types = require(Foundation.Components.Types)
local useRotation = require(Foundation.Utility.useRotation)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    size = IconSize.Large,
    testId = "--foundation-loading"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Loading
    local var1 = withDefaults(arg1, tbl1)
    local rotation = useRotation()
    local var3 = useTokens()

    local tbl2 = {
        name = "icons/graphic/loadingspinner",
        size = var1.size,
        style = var3.DarkMode.Content.Emphasis,
        Rotation = rotation,
        ref = ref,
        testId = `{var1.testId}--icon`
    }

    return React.createElement(View, withCommonProps(var1, { tag = "auto-xy" }), { Icon = React.createElement(Icon, tbl2) })
end))
