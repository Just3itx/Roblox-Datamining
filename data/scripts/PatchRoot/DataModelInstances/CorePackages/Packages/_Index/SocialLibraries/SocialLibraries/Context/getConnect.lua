-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local llama = dependencies.llama

return function(arg1)
    return function(arg2)
        return function(arg3)
            local var1 = Roact.Component:extend("Connected-" .. tostring(arg3))

            function var1.render(arg4)
                return Roact.createElement(arg1.Consumer, {
                    render = function(arg5)
                        return Roact.createElement(arg3, llama.Dictionary.join(arg4.props, arg2(arg5)))
                    end
                })
            end

            return var1
        end
    end
end
