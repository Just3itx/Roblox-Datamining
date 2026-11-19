-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)

local LuobuWarningToastComponent = require(script.LuobuWarningToastComponent)
local tbl1 = {}

tbl1.__index = tbl1

function tbl1.new()
    local self = setmetatable({}, tbl1)

    self.element = Roact.createElement(LuobuWarningToastComponent)

    self.root = Roact.mount(self.element, CoreGui, "LuobuWarningToast")

    task.delay(10, function()
        Roact.unmount(self.root)
    end)

    return self
end

return tbl1.new()
