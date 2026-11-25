-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local var1 = Roact.Component:extend("ExternalEventConnection")

function var1.init(arg1)
    arg1.connection = nil
end

function var1.render(arg1)
    return Roact.oneChild(arg1.props[Roact.Children])
end

function var1.didMount(arg1)
    arg1.connection = arg1.props.event:Connect(arg1.props.callback)
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.event ~= arg2.event or arg1.props.callback ~= arg2.callback then
        arg1.connection:Disconnect()

        arg1.connection = arg1.props.event:Connect(arg1.props.callback)
    end
end

function var1.willUnmount(arg1)
    if arg1.connection then
        arg1.connection:Disconnect()
        arg1.connection = nil
    end
end

return var1
