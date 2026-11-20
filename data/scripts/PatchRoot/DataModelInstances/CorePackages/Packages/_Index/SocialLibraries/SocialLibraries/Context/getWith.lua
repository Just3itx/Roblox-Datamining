-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local Roact = require(SocialLibraries.dependencies).Roact

return function(arg1)
    return function(render)
        assert(type(render) == "function", "Expect renderCallback to be a function.")
        return Roact.createElement(arg1.Consumer, { render = render })
    end
end
