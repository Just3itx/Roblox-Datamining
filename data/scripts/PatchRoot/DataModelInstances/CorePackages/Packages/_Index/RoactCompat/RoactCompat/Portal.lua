-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local warnOnce = require(script.Parent.warnOnce)

local function PortalComponent(arg1)
    if ReactGlobals.__DEV__ and ReactGlobals.__COMPAT_WARNINGS__ then
        warnOnce("Roact.Portal", "Please use the createPortal API on ReactRoblox instead")
    end
    return ReactRoblox.createPortal(arg1.children, arg1.target)
end

return PortalComponent
