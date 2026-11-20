-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local CorePackages = game:GetService("CorePackages")
local var1 = require(CorePackages.Packages.Roact).Component:extend("ContextActionEvent")

function var1.render(_)
    return nil
end

function var1.didMount(arg1)
    if arg1.props.actionPriority then
        ContextActionService:BindCoreActionAtPriority(
            arg1.props.name,
            arg1.props.callback,
            false,
            2000 + arg1.props.actionPriority,
            unpack(arg1.props.binds)
        )
        return
    end
    ContextActionService:BindCoreAction(arg1.props.name, arg1.props.callback, false, unpack(arg1.props.binds))
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.callback == arg2.callback and arg1.props.name == arg2.name then
        return
    end

    ContextActionService:UnbindCoreAction(arg2.name)
    if arg1.props.actionPriority then
        ContextActionService:BindCoreActionAtPriority(
            arg1.props.name,
            arg1.props.callback,
            false,
            2000 + arg1.props.actionPriority,
            unpack(arg1.props.binds)
        )
        return
    end
    ContextActionService:BindCoreAction(arg1.props.name, arg1.props.callback, false, unpack(arg1.props.binds))
end

function var1.willUnmount(arg1)
    ContextActionService:UnbindCoreAction(arg1.props.name)
end

return var1
