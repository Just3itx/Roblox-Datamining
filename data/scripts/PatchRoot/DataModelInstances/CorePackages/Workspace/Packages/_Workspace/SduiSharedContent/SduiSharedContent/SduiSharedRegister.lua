-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)

local registerSharedActions = require(script.Parent.Actions.registerSharedActions)
local registerSharedUiComponents = require(script.Parent.Components.registerSharedUiComponents)

return React.memo(function() -- name: SduiSharedRegister
    React.useEffect(function()
        registerSharedActions()
        registerSharedUiComponents()
    end, {})
    return nil
end)
