-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local React = require(scriptParentParentParent.React)
local ReactRoblox = require(scriptParentParentParent.Dev.ReactRoblox)
local NavigationEvents = require(scriptParentParent.views.NavigationEvents)
local Events = require(scriptParentParent.Events)
local invariant = require(script.Parent.invariant)
local PageNavigationEvent = require(script.Parent.PageNavigationEvent)

local module = {}
module.__index = module

function module.new()
    local tbl1 = {
        navigationEvents = {}
    }

    setmetatable(tbl1, module)

    return tbl1
end

function module:getNavigationEvents()
    return self.navigationEvents
end

function module:printNavigationEvents()
    print("Total Events: ", #self.navigationEvents)
    for _, navigationEvent in self.navigationEvents do
        print(navigationEvent)
    end
end

function module:waitForNumberEventsMaxWaitTime(arg1, arg2)
    local num1 = 0
    while #self.navigationEvents < arg1 and num1 <= arg2 do
        ReactRoblox.act(function()
            num1 += task.wait()
        end)
    end
end

function module:resetNavigationEvents()
    self.navigationEvents = {}
end

local tbl1 = {
    onWillFocus = Events.WillFocus,
    onDidFocus = Events.DidFocus,
    onWillBlur = Events.WillBlur,
    onDidBlur = Events.DidBlur
}

function module.createNavigationAdapter(arg1, arg2)
    local tbl2 = ({})
    for value, value2 in tbl1 do
        tbl2[value] = function()
            PageNavigationEvent.new(arg2, value2)
            table.insert(arg1.navigationEvents, PageNavigationEvent.new(arg2, value2))
        end
    end

    return React.createElement(NavigationEvents, tbl2)
end

function module:equalTo(arg1)
    invariant(type(arg1) == "table", "should be a list")
    local navigationEventsLen = #self.navigationEvents

    if navigationEventsLen ~= #arg1 then
        return false, "different amount of events"
    end

    for i = 1, navigationEventsLen do
        if not self.navigationEvents[i]:equalTo(arg1[i]) then
            return false, ("events at position %d do not match"):format(i)
        end
    end

    return true
end

function module:expect(arg1)
    local var1, var2 = self:equalTo(arg1)

    if not var1 then
        local str1 = if #self.navigationEvents > 0 then ("{\n  %s,\n}"):format(table.concat(Array.map(self.navigationEvents, tostring), ",\n  ")) else "{}"

        local str2 = if #arg1 > 0 then ("{\n  %s,\n}"):format(table.concat(Array.map(arg1, tostring), ",\n  ")) else "{}"

        error(("%s\nGot events: %s\n\nExpected events: %s"):format(var2, str1, str2))
    end
end

return module
