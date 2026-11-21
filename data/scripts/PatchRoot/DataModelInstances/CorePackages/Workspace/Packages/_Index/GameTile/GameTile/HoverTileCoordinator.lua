-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local Signal = require(GameTileParent.AppCommonLib).Signal

local module = {}
module.__index = module

function module.new()
    local tbl1 = {
        changed = Signal.new(),
        hoveredKey = nil,
        waitingForHover = nil
    }

    setmetatable(tbl1, module)
    return tbl1
end

function module:requestHover(str1: string)
    if self.hoveredKey == str1 then
        return
    end

    if self.waitingForHover == str1 then
        return
    end

    if self.hoveredKey == nil or self.waitingForHover ~= nil then
        self.hoveredKey = str1
        self.waitingForHover = nil
        self.changed:fire(self.hoveredKey)
    else
        self.waitingForHover = str1
    end
end

function module:cancelHover(str1: string)
    if self.hoveredKey ~= str1 then
        if self.waitingForHover == str1 then
            self.waitingForHover = nil
        end
        return
    end

    if self.waitingForHover ~= nil then
        self.hoveredKey = self.waitingForHover
        self.waitingForHover = nil
    else
        self.hoveredKey = nil
    end
    self.changed:fire(self.hoveredKey)
end

function module:reset()
    local hoveredKey = self.hoveredKey
    self.waitingForHover = nil
    self.hoveredKey = nil
    if hoveredKey ~= nil then
        self.changed:fire(self.hoveredKey)
    end
end

module.default = module.new()

return module
