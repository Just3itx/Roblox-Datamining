-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local React = require(scriptParentParent.React)

local warnOnce = require(script.Parent.warnOnce)

return function(arg1)
    if ReactGlobals.__DEV__ and ReactGlobals.__COMPAT_WARNINGS__ then
        warnOnce("createFragment", "Please instead use:\n\tReact.createElement(React.Fragment, ...)")
    end

    return React.createElement(React.Fragment, nil, arg1)
end
