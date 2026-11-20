-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local _React = require(ViewRecyclerReact.Parent.React)
local _RecyclableViewReadiness = require(ViewRecyclerReact.ReactAdapter.RecyclableViewReadiness)
local _Signals = require(ViewRecyclerReact.Parent.Signals)

local var1 = (setmetatable({}, { __mode = "k" }))

local module = {}

function module.register(func1: (...any) -> (...any), tbl1)
    var1[func1] = tbl1
end

function module.isRegistered(arg1): boolean
    return var1[arg1] ~= nil
end

function module.getMetadata(func1: (...any) -> (...any))
    return var1[func1]
end

return module
