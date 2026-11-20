-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)
local Cryo = require(scriptParentParent.Cryo)

local Logger = require(script.Parent.Logger)
local AppPolicyContext = require(script.Parent.AppPolicyContext)

local function mergePolicies(arg1, presentationPolicy)
    local result = {}

    for _, value in ipairs(presentationPolicy) do
        result = Cryo.Dictionary.join(result, value(arg1))
    end

    return result
end

return function(arg1)
    assert(arg1, "expected getPolicyImpl")

    return function(arg2)
        assert(type(arg2) == "function", "connect expects mapper to be a function")

        return function(arg3)
            local str1 = ("AppPolicy(%s)"):format(tostring(arg3))
            local var1 = Logger:new(str1)
            var1:setContext({ prefix = string.format("%s: ", str1) })

            local str2 = string.format("%s: Not a descendent of PolicyProvider", str1)
            local var2 = Roact.PureComponent:extend(str1)

            var1:trace("Connected to component: {}", tostring(arg3))

            function var2.init(arg4, arg5)
                arg4.policyContext = arg5.policy
                assert(arg4.policyContext, str2)

                function arg4.setWithEmptyPolicy()
                    arg4.state = {
                        policy = mergePolicies({}, arg4.policyContext.presentationPolicy)
                    }
                end

                if arg4.policyContext.staticExternalPolicy then
                    arg4.state = {
                        policy = mergePolicies(arg4.policyContext.staticExternalPolicy, arg4.policyContext.presentationPolicy)
                    }
                    return
                end

                local var3 = arg1.read()
                if var3 then
                    arg4.state = {
                        policy = mergePolicies(var3, arg4.policyContext.presentationPolicy)
                    }
                else
                    arg4.setWithEmptyPolicy()
                    var1:trace("No app policy data available")
                end

                function arg4.onPolicyChanged(arg6)
                    arg4:setState({ policy = mergePolicies(arg6, arg4.policyContext.presentationPolicy) })
                end
            end

            function var2.didMount(arg4)
                if arg4.policyContext.staticExternalPolicy then
                    return
                end
                arg4.connection = arg1.onPolicyChanged(function(arg5)
                    var1:trace("Received policy update from MemStorageService")
                    arg4.onPolicyChanged(arg5)
                end)
            end

            function var2.render(arg4)
                local var3 = arg2(arg4.state.policy, arg4.props.innerProps)
                local var4 = Cryo.Dictionary.join(arg4.props.innerProps, var3)
                return Roact.createElement(arg3, var4)
            end

            function var2.willUnmount(arg4)
                if arg4.connection then
                    arg4.connection:Disconnect()
                end

                arg4.onPolicyChange = nil
            end

            return function(innerProps)
                return Roact.createElement(AppPolicyContext.Consumer, {
                    render = function(policy)
                        return Roact.createElement(var2, { innerProps = innerProps, policy = policy })
                    end
                })
            end
        end
    end
end
