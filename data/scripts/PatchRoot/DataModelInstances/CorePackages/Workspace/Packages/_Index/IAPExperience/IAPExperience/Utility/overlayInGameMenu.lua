-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local AppCommonLib = require(scriptParentParentParent.AppCommonLib)

return function(component)
    if AppCommonLib.IsVRAppBuild() or AppCommonLib.isTenFootInterface() then
        return component
    end

    return React.createElement(
        "ScreenGui",
        {
            Enabled = true,
            ZIndexBehavior = Enum.ZIndexBehavior.Global,
            DisplayOrder = 10,
            IgnoreGuiInset = true
        },
        { Component = component }
    )
end
