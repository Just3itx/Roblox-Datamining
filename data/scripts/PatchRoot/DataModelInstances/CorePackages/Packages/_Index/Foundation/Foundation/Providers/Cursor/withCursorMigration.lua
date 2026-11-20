-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local CursorContext = require(script.Parent.CursorContext)

local function withCursorMigration(arg1)
    return React.createElement(CursorContext.Consumer, {
        render = function(arg2)
            return arg1(arg2.getCursor)
        end
    })
end

return withCursorMigration
