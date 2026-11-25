-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local Signals = require(PeopleReactViewParent.Signals)

local FFlagFixVirtualizedGridNumItems = require(PeopleReactViewParent.PeopleService).getService("Flags").FFlagFixVirtualizedGridNumItems

local function createScrollingFrameStore()
    local getAbsolutePositionY, var2 = Signals.createSignal(0)
    local getAbsoluteSizeY, var4 = Signals.createSignal(0)
    local var5, var6 = Signals.createSignal(0)
    local var7 = nil
    local var8

    if FFlagFixVirtualizedGridNumItems then
        local var9
        var9, var8 = Signals.createSignal(0)
        var7 = var9
    else
        var8 = nil
    end

    local computed = if FFlagFixVirtualizedGridNumItems then Signals.createComputed(function(arg1)
        return var5(arg1) + var7(arg1)
    end) else nil

    local connection = nil
    local connection2 = nil
    local connection3 = nil

    local function setScrollingFrame(arg1)
        if connection then
            connection:Disconnect()
        end
        if connection2 then
            connection2:Disconnect()
        end
        if connection3 then
            connection3:Disconnect()
        end

        var2(arg1.AbsolutePosition.Y)
        var4(arg1.AbsoluteSize.Y)
        var6(arg1.CanvasPosition.Y)

        connection = arg1:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
            var2(arg1.AbsolutePosition.Y)
        end)

        connection2 = arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            var4(arg1.AbsoluteSize.Y)
        end)

        connection3 = arg1:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            var6(arg1.CanvasPosition.Y)
        end)
    end

    local function cleanUp()
        if connection then
            connection:Disconnect()
        end
        if connection2 then
            connection2:Disconnect()
        end
        if connection3 then
            connection3:Disconnect()
        end
    end

    local tbl1 = {
        getAbsolutePositionY = getAbsolutePositionY,
        getAbsoluteSizeY = getAbsoluteSizeY,
        getCanvasPositionY = 0,
        setScrollingFrame = 0,
        setCanvasPositionYOffset = 0,
        cleanUp = 0
    }

    if not FFlagFixVirtualizedGridNumItems then
        computed = var5
    end

    tbl1.getCanvasPositionY = computed

    tbl1.setScrollingFrame = setScrollingFrame
    if not FFlagFixVirtualizedGridNumItems then
        var8 = nil
    end

    tbl1.setCanvasPositionYOffset = var8
    tbl1.cleanUp = cleanUp
    return tbl1
end

return createScrollingFrameStore
