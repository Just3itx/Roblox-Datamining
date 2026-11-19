-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:31Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local PopoverContext = require(script.Parent.Parent.PopoverContext)
local StudioUri = require(Foundation.Utility.Plugin.StudioUri)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local React = require(FoundationParent.React)

return React.forwardRef(function(arg1, arg2) -- name: PopoverAnchor
    local var1 = React.useContext(PopoverContext)

    local ref = React.useRef(nil)

    React.useImperativeHandle(arg2, function()
        return ref.current
    end, {})

    React.useLayoutEffect(function()
        if StudioUri.isStudioUri(arg1.anchorRef) then
            var1.setAnchorUri(arg1.anchorRef)
        elseif typeof(arg1.anchorRef) == "table" and arg1.anchorRef.current then
            var1.setAnchor(arg1.anchorRef.current)
        else
            var1.setAnchor(ref.current)
        end
    end)

    if arg1.anchorRef then
        return nil
    end

    arg1.testId = `{var1.testId}--anchor`

    return React.createElement(View, withCommonProps(arg1, { tag = "auto-xy", ref = ref }), arg1.children)
end)
