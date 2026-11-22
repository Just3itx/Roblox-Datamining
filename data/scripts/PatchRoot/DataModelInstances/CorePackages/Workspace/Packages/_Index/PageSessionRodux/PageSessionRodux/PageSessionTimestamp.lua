-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PageSessionRodux = script:FindFirstAncestor("PageSessionRodux")
local PageSessionRoduxParent = PageSessionRodux.Parent
local Cryo = require(PageSessionRoduxParent.Cryo)
local _DiscoveryTypes = require(PageSessionRoduxParent.DiscoveryTypes)

local SetPageSessionTimestamp = require(PageSessionRodux.SetPageSessionTimestamp)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == SetPageSessionTimestamp.name then
        arg1 = Cryo.Dictionary.join(arg1, { [arg2.page] = arg2.timestamp })
    end

    return arg1
end
