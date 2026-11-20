-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local _ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local ScrollbarOverlay = require(ViewRecyclerRoblox.RobloxAdapter.ScrollbarOverlay)

local module = {}

local function createFrame(frameName: string, parent): Frame -- Luacid: Inlined by compiler; 3 call sites recovered
    local frame = Instance.new("Frame")
    frame.Name = frameName
    frame.Active = false
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Selectable = false
    frame.Parent = parent
    return frame
end

function module.new(arg1, arg2)
    local viewRecyclerOverlayContainer = Instance.new("Folder")
    viewRecyclerOverlayContainer.Name = "ViewRecyclerOverlayContainer"
    local frame = createFrame("ViewRecyclerOverlayBounds", viewRecyclerOverlayContainer)
    frame.Size = UDim2.fromScale(1, 1)
    local frame2 = createFrame("ViewRecyclerOverlayWindow", frame)
    local frame3 = createFrame("ViewRecyclerOverlay", frame2)
    frame3.ClipsDescendants = true
    local var1 = ScrollbarOverlay.connect(arg1, frame3, arg2)
    local bool1 = false

    local function synchronize()
        if bool1 or viewRecyclerOverlayContainer.Parent == nil then
            return
        end
        frame2.Visible = arg1.Visible
        frame2.ZIndex = arg1.ZIndex + 1
        frame.ZIndex = frame2.ZIndex
        local absoluteSize = frame.AbsoluteSize
        if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
            return
        end
        local absoluteSize2 = arg1.AbsoluteSize
        local var2 = arg1.AbsolutePosition - frame.AbsolutePosition
        frame2.Size = UDim2.fromScale(absoluteSize2.X / absoluteSize.X, absoluteSize2.Y / absoluteSize.Y)
        local var3 = arg1.AbsolutePosition - frame2.AbsolutePosition
        if math.abs(var3.X) >= 0.5 or math.abs(var3.Y) >= 0.5 then
            frame2.Position = UDim2.fromScale(var2.X / absoluteSize.X, var2.Y / absoluteSize.Y)
        end
    end

    local function reparent() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool1 then
            return
        end
        viewRecyclerOverlayContainer.Parent = arg1.Parent
        synchronize()
    end

    local tbl1 = {
        arg1:GetPropertyChangedSignal("AbsolutePosition"):Connect(synchronize),
        arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(synchronize),
        arg1:GetPropertyChangedSignal("Visible"):Connect(synchronize),
        arg1:GetPropertyChangedSignal("ZIndex"):Connect(synchronize),
        arg1:GetPropertyChangedSignal("Parent"):Connect(reparent),
        frame2:GetPropertyChangedSignal("AbsolutePosition"):Connect(synchronize),
        frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(synchronize)
    }
    reparent()

    return table.freeze({
        overlay = frame3,
        destroy = function()
            if bool1 then
                return
            end
            bool1 = true
            for _, value in tbl1 do
                value:Disconnect()
            end
            var1()
            viewRecyclerOverlayContainer:Destroy()
        end
    })
end

return module
