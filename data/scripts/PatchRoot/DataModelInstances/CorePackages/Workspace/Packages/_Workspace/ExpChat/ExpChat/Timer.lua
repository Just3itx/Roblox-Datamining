-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Promise = require(ExpChatParent.Promise)

local module = {}
module.__index = module

function module.new(goalTime)
    return (setmetatable({ goalTime = goalTime }, module))
end

function module:start()
    self:stop()

    self.promise = Promise.delay(self.goalTime)
    return self.promise
end

function module:stop()
    if self.promise then
        self.promise:cancel()
    end
end

return module
