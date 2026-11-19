-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local var1 = Roact.Component:extend("EventConnection")

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
