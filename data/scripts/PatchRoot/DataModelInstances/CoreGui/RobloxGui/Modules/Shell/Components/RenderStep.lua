-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")
local var1 = require(CorePackages.Packages.Roact).Component:extend("RenderStep")

function var1.render(_)
    return nil
end

function var1.didMount(arg1)
    RunService:BindToRenderStep(arg1.props.name, arg1.props.priority, arg1.props.callback)
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.callback ~= arg2.callback or arg1.props.name ~= arg2.name then
        RunService:UnbindFromRenderStep(arg2.name)
        RunService:BindToRenderStep(arg1.props.name, arg1.props.priority, arg1.props.callback)
    end
end

function var1.willUnmount(arg1)
    RunService:UnbindFromRenderStep(arg1.props.name)
end

return var1
