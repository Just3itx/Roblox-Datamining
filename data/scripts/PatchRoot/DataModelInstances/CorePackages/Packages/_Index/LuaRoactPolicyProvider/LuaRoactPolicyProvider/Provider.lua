-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)

local AppPolicyContext = require(script.Parent.AppPolicyContext)

return function()
    local var1 = Roact.Component:extend("PolicyProvider")

    function var1.init(arg1, arg2)
        assert(type(arg2.policy) == "table", "Provider expects props.policy to be a table")

        arg1.policy = {
            presentationPolicy = arg2.policy,
            staticExternalPolicy = arg2.policyData
        }
    end

    function var1.render(arg1)
        return Roact.createElement(AppPolicyContext.Provider, { value = arg1.policy }, arg1.props[Roact.Children])
    end

    return var1
end
