-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Text = require(Foundation.Components.Text)

local _Types = require(Foundation.Components.Types)
local withCommonProps = require(Foundation.Utility.withCommonProps)

return React.memo(React.forwardRef(function(arg1, ref) -- name: HintText
    return React.createElement(
        Text,
        withCommonProps(arg1, {
            Text = arg1.text,
            tag = {
                ["size-full-0 auto-y text-caption-small text-align-x-left text-align-y-top text-wrap"] = true,
                ["content-action-alert"] = arg1.hasError,
                ["content-muted"] = arg1.isDisabled and not arg1.hasError,
                ["content-default"] = not (arg1.isDisabled or arg1.hasError)
            },
            ref = ref
        })
    )
end))
