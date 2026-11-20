-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)

local WatermarkComponent = require(script.WatermarkComponent)

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new()
    local self = setmetatable({}, tbl1)

    self.root = Roact.createElement(WatermarkComponent)

    self.element = Roact.mount(self.root, CoreGui, "Watermark")

    return self
end

return tbl1.new()
