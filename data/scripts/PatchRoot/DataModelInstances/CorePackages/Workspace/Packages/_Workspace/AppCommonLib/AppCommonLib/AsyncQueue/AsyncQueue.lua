-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:05:37Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local AppCommonLibParent = script:FindFirstAncestor("AppCommonLib").Parent
local Promise = require(AppCommonLibParent.Promise)

local _AsyncQueueTypes = require(script.Parent.AsyncQueueTypes)

local module = ({})

module.__index = module

function module.new()
    local tbl1 = {
        head = Promise.resolve()
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:request(callback: (...any) -> (...any))
    local bindableEvent = Instance.new("BindableEvent")
    local bool1 = false
    local bool2 = false

    self.head = self.head:andThen(function()
        return Promise.new(function(callback2)
            if not bool1 then
                pcall(callback)
            end
            if not bool1 then
                bool2 = true
                bindableEvent.Event:Wait()
            end
            bindableEvent:Destroy()
            callback2()
        end)
    end)

    local function release()
        if bool2 then
            bindableEvent:Fire()
            return
        end
        bool1 = true
    end

    return release
end

return module
