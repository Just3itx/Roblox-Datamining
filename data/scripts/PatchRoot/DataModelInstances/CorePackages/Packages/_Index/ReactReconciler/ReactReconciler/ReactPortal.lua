-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local REACT_PORTAL_TYPE = require(scriptParentParent.Shared).ReactSymbols.REACT_PORTAL_TYPE

local _Shared = require(scriptParentParent.Shared)

return {
    createPortal = function(children, containerInfo, implementation, key: string?)
        if key ~= nil then
            key = tostring(key)
        end
        return {
            ["$$typeof"] = REACT_PORTAL_TYPE,
            key = key,
            children = children,
            containerInfo = containerInfo,
            implementation = implementation
        }
    end
}
