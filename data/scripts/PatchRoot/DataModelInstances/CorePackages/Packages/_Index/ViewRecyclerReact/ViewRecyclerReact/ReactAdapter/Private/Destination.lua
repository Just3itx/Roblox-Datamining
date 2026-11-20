-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local _ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local ViewRecyclerRoblox = require(ViewRecyclerReact.Parent.ViewRecyclerRoblox)
local _Signals = require(ViewRecyclerReact.Parent.Signals)
local HostPresentationPhase = ViewRecyclerRoblox.HostPresentationPhase
local ReparentableHost = ViewRecyclerRoblox.ReparentableHost

local Kind = table.freeze({ List = "list", Composition = "composition", Rect = "rect" })

local resetReparented = FFlagViewRecyclerReact084 and function(arg1) -- name: resetReparented
    arg1.AnchorPoint = Vector2.zero

    arg1.ZIndex = 1
end or function(_, arg1, _) -- name: resetReparented
    ReparentableHost.detach(arg1)
    arg1.AnchorPoint = Vector2.zero
    arg1.Position = UDim2.new()
    arg1.Size = UDim2.new()
    arg1.AutomaticSize = Enum.AutomaticSize.None

    arg1.ZIndex = 1
end

local function attachNowhere(_, _) end

local function readValue<T>(arg1: T, _): T
    return arg1
end

local freeze = table.freeze
local tbl1

if FFlagViewRecyclerReact084 then
    tbl1 = {
        [Kind.List] = table.freeze({
            sameOwner = function(arg1, arg2): boolean
                return arg1.sink == arg2.sink
            end,
            attach = attachNowhere,
            present = function(arg1, host, tbl2, phase)
                tbl2.sink.apply(arg1, { host = host, phase = phase, state = tbl2.state })
            end,
            detach = function(arg1, _, tbl2)
                tbl2.sink.apply(arg1, nil)
            end,
            readItem = readValue
        }),
        [Kind.Composition] = table.freeze({
            sameOwner = function(arg1, arg2): boolean
                return arg1.placementId == arg2.placementId
            end,
            attach = attachNowhere,
            present = function(_, arg1, tbl2, hidden)
                if arg1.Parent ~= tbl2.placeholder or arg1.AutomaticSize ~= tbl2.automaticSize then
                    tbl2.vacantHosts.reclaim(arg1)
                    ReparentableHost.place(arg1, tbl2)
                end
                arg1.Visible = hidden ~= HostPresentationPhase.Hidden
            end,
            detach = function(_, arg1, tbl2)
                resetReparented(arg1)

                tbl2.vacantHosts.hold({ arg1 })
            end,
            readItem = function(arg1, arg2)
                return arg1(arg2)
            end
        }),
        [Kind.Rect] = table.freeze({
            sameOwner = function(arg1, arg2): boolean
                return arg1.rectPlacement == arg2.rectPlacement
            end,
            attach = function(arg1, tbl2)
                tbl2.vacantHosts.reclaim(arg1)
                if arg1.Parent ~= tbl2.container then
                    arg1.AutomaticSize = Enum.AutomaticSize.None
                    arg1.Parent = tbl2.container
                end
            end,
            present = function(_, arg1, _, hidden)
                arg1.Visible = hidden ~= HostPresentationPhase.Hidden
            end,
            detach = function(_, arg1, tbl2)
                resetReparented(arg1)
                tbl2.vacantHosts.leave(arg1)
            end,
            readItem = readValue
        })
    }
else
    tbl1 = {
        [Kind.List] = table.freeze({
            sameOwner = function(arg1, arg2): boolean
                return arg1.sink == arg2.sink
            end,
            attach = attachNowhere,
            present = function(arg1, host, tbl2, phase)
                tbl2.sink.apply(arg1, { host = host, phase = phase, state = tbl2.state })
            end,
            detach = function(arg1, _, tbl2)
                tbl2.sink.apply(arg1, nil)
            end,
            readItem = readValue
        }),
        [Kind.Composition] = table.freeze({
            sameOwner = function(arg1, arg2): boolean
                return arg1.placementId == arg2.placementId
            end,
            attach = attachNowhere,
            present = function(_, arg1, tbl2, hidden)
                if arg1.Parent ~= tbl2.placeholder or arg1.AutomaticSize ~= tbl2.automaticSize then
                    ReparentableHost.place(arg1, tbl2)
                end
                arg1.Visible = hidden ~= HostPresentationPhase.Hidden
            end,
            detach = resetReparented,
            readItem = function(arg1, arg2)
                return arg1(arg2)
            end
        }),
        [Kind.Rect] = table.freeze({
            sameOwner = function(arg1, arg2): boolean
                return arg1.rectPlacement == arg2.rectPlacement
            end,
            attach = function(arg1, tbl2)
                if arg1.Parent ~= tbl2.container then
                    arg1.AutomaticSize = Enum.AutomaticSize.None
                    arg1.Parent = tbl2.container
                end
            end,
            present = function(_, arg1, _, hidden)
                arg1.Visible = hidden ~= HostPresentationPhase.Hidden
            end,
            detach = resetReparented,
            readItem = readValue
        })
    }
end

local behaviors = freeze(tbl1)

return table.freeze({ Kind = Kind, behaviors = behaviors })
