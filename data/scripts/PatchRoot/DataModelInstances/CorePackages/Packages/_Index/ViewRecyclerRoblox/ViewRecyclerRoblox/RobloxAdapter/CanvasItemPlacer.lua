-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local _ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local SlotGeometry = require(ViewRecyclerRoblox.RobloxAdapter.SlotGeometry)

local module = {}

function module.createState()
    return {
        unpinnedZIndex = nil,
        parent = nil,
        anchorPointInitialized = false,
        position = nil,
        size = nil,
        automaticSize = nil,
        visible = nil,
        zIndex = nil
    }
end

local function resetAppliedState(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    tbl1.anchorPointInitialized = false
    tbl1.position = nil
    tbl1.size = nil
    tbl1.automaticSize = nil
    tbl1.visible = nil
    tbl1.zIndex = nil
end

function module.getGeometry(arg1, arg2, arg3, bool1: boolean, num1: number, tbl1)
    if arg2.mainAxisOffset ~= nil then
        arg1 = {
            startOffset = arg2.mainAxisOffset,
            length = arg2.mainAxisLength or arg1.length
        }
        num1 = 0
    end

    local position, size = SlotGeometry.get(arg1, arg3, bool1, num1)
    local tbl2 = tbl1 or {}
    tbl2.position = position
    tbl2.size = size
    tbl2.automaticSize = SlotGeometry.getAutomaticSize(arg3, bool1)
    tbl2.zIndexOffset = arg2.zIndex
    return tbl2
end

function module.place(arg1, parent, tbl1, tbl2, visible: boolean)
    local num1 = 0
    if arg1.Parent ~= parent or tbl2.parent ~= parent then
        if arg1.Parent ~= parent then
            arg1.Parent = parent
            num1 += 1
        end
        tbl2.parent = parent
        resetAppliedState(tbl2)
    end

    if not tbl2.anchorPointInitialized then
        arg1.AnchorPoint = Vector2.zero
        tbl2.anchorPointInitialized = true
        num1 += 1
    end
    if tbl2.position ~= tbl1.position then
        arg1.Position = tbl1.position
        tbl2.position = tbl1.position
        num1 += 1
    end
    if tbl2.size ~= tbl1.size then
        arg1.Size = tbl1.size
        tbl2.size = tbl1.size
        num1 += 1
    end
    if tbl2.automaticSize ~= tbl1.automaticSize then
        arg1.AutomaticSize = tbl1.automaticSize
        tbl2.automaticSize = tbl1.automaticSize
        num1 += 1
    end
    if tbl2.visible ~= visible then
        arg1.Visible = visible
        tbl2.visible = visible
        num1 += 1
    end

    local unpinnedZIndex = nil
    local zIndexOffset = tbl1.zIndexOffset
    if zIndexOffset ~= nil then
        if tbl2.unpinnedZIndex == nil then
            tbl2.unpinnedZIndex = arg1.ZIndex
        end
        unpinnedZIndex = tbl2.unpinnedZIndex + zIndexOffset
    elseif tbl2.unpinnedZIndex ~= nil then
        unpinnedZIndex = tbl2.unpinnedZIndex
        tbl2.unpinnedZIndex = nil
    end
    if unpinnedZIndex == nil or tbl2.zIndex == unpinnedZIndex then
        if unpinnedZIndex == nil then
            tbl2.zIndex = arg1.ZIndex
        end
        return num1
    end

    arg1.ZIndex = unpinnedZIndex
    tbl2.zIndex = unpinnedZIndex
    return num1 + 1
end

function module.updatePosition(arg1, tbl1, tbl2): boolean
    if tbl2.position == tbl1.position then
        return false
    end
    arg1.Position = tbl1.position
    tbl2.position = tbl1.position
    return true
end

function module.hide(arg1, tbl1)
    if tbl1.visible ~= false then
        arg1.Visible = false
        tbl1.visible = false
    end
end

if FFlagViewRecyclerReact084 then
    function module.release(arg1, tbl1): number
        local num1 = 0
        if tbl1.unpinnedZIndex ~= nil then
            if arg1.ZIndex ~= tbl1.unpinnedZIndex then
                arg1.ZIndex = tbl1.unpinnedZIndex
                num1 += 1
            end
            tbl1.unpinnedZIndex = nil
        end
        if arg1.Visible then
            arg1.Visible = false
            num1 += 1
        end
        tbl1.parent = nil
        resetAppliedState(tbl1)
        return num1
    end
end

function module.detach(arg1, tbl1)
    local num1

    if FFlagViewRecyclerReact084 then
        num1 = module.release(arg1, tbl1)
    else
        num1 = 0
        if tbl1.unpinnedZIndex ~= nil then
            if arg1.ZIndex ~= tbl1.unpinnedZIndex then
                arg1.ZIndex = tbl1.unpinnedZIndex
                num1 += 1
            end
            tbl1.unpinnedZIndex = nil
        end
        if arg1.Visible then
            arg1.Visible = false
            num1 += 1
        end
    end
    if arg1.Parent ~= nil then
        arg1.Parent = nil
        num1 += 1
    end

    if not FFlagViewRecyclerReact084 then
        tbl1.parent = nil
        resetAppliedState(tbl1)
    end

    return num1
end

if not FFlagViewRecyclerReact084 then
    function module.detachForTransfer(arg1, tbl1)
        local var1 = module.detach(arg1, tbl1)
        if arg1.Position ~= UDim2.new() then
            arg1.Position = UDim2.new()
            var1 += 1
        end
        if arg1.Size ~= UDim2.new() then
            arg1.Size = UDim2.new()
            var1 += 1
        end
        if arg1.AutomaticSize ~= Enum.AutomaticSize.None then
            arg1.AutomaticSize = Enum.AutomaticSize.None
            var1 += 1
        end
        return var1
    end
end

return module
