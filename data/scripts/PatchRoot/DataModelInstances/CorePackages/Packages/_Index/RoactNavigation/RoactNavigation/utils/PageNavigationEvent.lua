-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local invariant = require(script.Parent.invariant)

local module = {}
module.__index = module

function module.new(pageName, event)
    invariant(type(pageName) == "string", "pageName should be string")
    invariant(typeof(event) == "userdata", "event should be RoactNavigation.Event")
    local tbl1 = { event = event, pageName = pageName }

    setmetatable(tbl1, module)

    return tbl1
end

function module.isPageNavigationEvent(arg1): boolean
    return getmetatable(arg1).__index == module
end

function module:__tostring()
    return string.format("%-15s - %s", tostring(self.event), self.pageName)
end

function module:equalTo(arg1): boolean
    invariant(module.isPageNavigationEvent(arg1), "should be PageNavigationEvent")
    return self.pageName == arg1.pageName and self.event == arg1.event
end

return module
