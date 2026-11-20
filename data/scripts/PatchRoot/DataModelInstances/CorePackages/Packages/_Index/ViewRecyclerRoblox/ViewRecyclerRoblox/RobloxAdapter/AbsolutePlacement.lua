-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local _ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local CanvasItemPlacer = require(ViewRecyclerRoblox.RobloxAdapter.CanvasItemPlacer)
local EndLimitFrame = require(ViewRecyclerRoblox.RobloxAdapter.EndLimitFrame)
local HostPresentationPhase = require(ViewRecyclerRoblox.RobloxAdapter.HostPresentationPhase)

local module = {}

function module.new(arg1, bool1: boolean, func1: (...any) -> (...any))
    local tbl1 = ({})

    local function releaseEndLimitFrame(tbl2) -- Luacid: Inlined by compiler; 3 call sites recovered
        local endLimitFrame = tbl2.endLimitFrame
        if endLimitFrame ~= nil then
            tbl2.endLimitFrame = nil
            endLimitFrame.destroy()
        end
    end

    local function placeEndLimitFrame(tbl2, arg2, arg3, zIndex: number, originOffset: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
        local num1 = originOffset or 0
        tbl2.endLimitFrame.place(arg3, arg1, (arg2.mainAxisOffset or 0) + num1, arg2.mainAxisEndLimit + num1, zIndex)

        tbl2.originOffset = originOffset
    end

    local function getGeometry(tbl2, arg2, num1: number?) -- Luacid: Inlined by compiler; 3 call sites recovered
        local state = tbl2.state
        return CanvasItemPlacer.getGeometry(
            state.itemLayout,
            arg2,
            arg1,
            bool1 or state.index == nil,
            if num1 == nil then 0 else state.contentStartOffset + num1,
            tbl2.geometry
        )
    end

    return {
        place = function(arg2, placerState, arg3, state, arg4, hidden): boolean
            local var1 = if arg4 then state.canvasPlacement else state.viewportPlacement
            local tbl2 = tbl1[arg2]
            if tbl2 == nil then
                tbl2 = {
                    placerState = placerState,
                    state = state,
                    geometry = {},
                    originOffset = nil,
                    endLimitFrame = nil
                }

                tbl1[arg2] = tbl2
            end
            tbl2.placerState = placerState
            tbl2.state = state
            local bool2 = hidden ~= HostPresentationPhase.Hidden
            if var1.mainAxisEndLimit == nil then
                local originOffset = if arg4 then func1() else nil
                CanvasItemPlacer.place(arg2, arg3, getGeometry(tbl2, var1, originOffset), placerState, bool2)
                releaseEndLimitFrame(tbl2)
                tbl2.originOffset = originOffset

                return bool2
            end

            local geometry = getGeometry(tbl2, { mainAxisOffset = 0, mainAxisLength = var1.mainAxisLength, zIndex = var1.zIndex }, nil)

            local endLimitFrame = tbl2.endLimitFrame or EndLimitFrame.new()
            tbl2.endLimitFrame = endLimitFrame
            CanvasItemPlacer.place(arg2, endLimitFrame.instance, geometry, placerState, bool2)

            local zIndex = arg2.ZIndex
            local originOffset = if arg4 then func1() else nil
            placeEndLimitFrame(tbl2, var1, arg3, zIndex, originOffset)
            return bool2
        end,
        remove = function(arg2)
            local var1 = tbl1[arg2]
            if var1 == nil then
                return
            end

            tbl1[arg2] = nil

            if FFlagViewRecyclerReact084 then
                local endLimitFrame = var1.endLimitFrame
                if endLimitFrame ~= nil and arg2.Parent == endLimitFrame.instance then
                    arg2.Parent = endLimitFrame.instance.Parent
                end
            end

            releaseEndLimitFrame(var1)
        end,
        setConfiguration = function(arg2, arg3)
            arg1 = arg2
            bool1 = arg3
        end,
        setOriginOffset = function(originOffset)
            for value, value2 in tbl1 do
                if value2.originOffset == nil or value2.originOffset == originOffset then
                    continue
                end

                local endLimitFrame = value2.endLimitFrame
                if endLimitFrame ~= nil then
                    placeEndLimitFrame(value2, value2.state.canvasPlacement, endLimitFrame.instance.Parent, value.ZIndex, originOffset)
                else
                    local geometry = getGeometry(value2, value2.state.canvasPlacement, originOffset)
                    CanvasItemPlacer.updatePosition(value, geometry, value2.placerState)
                    value2.originOffset = originOffset
                end
            end
        end,
        destroy = function()
            for _, value in tbl1 do
                releaseEndLimitFrame(value)
            end

            table.clear(tbl1)
        end
    }
end

return module
