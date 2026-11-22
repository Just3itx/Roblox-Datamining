-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactRoblox = require(MomentsParent.ReactRoblox)

local View = Foundation.View

local function ScrollingFrameCover(tbl1)
    local scrollingFrame = tbl1.scrollingFrame
    local var1, var2 = React.useState(nil)
    React.useLayoutEffect(function()
        var2(scrollingFrame.Parent)
        local connection = scrollingFrame:GetPropertyChangedSignal("Parent"):Connect(function()
            var2(scrollingFrame.Parent)
        end)
        return function()
            connection:Disconnect()
        end
    end, { scrollingFrame })

    local ref = React.useRef(nil)
    local zIndex, var5 = React.useBinding(1)
    local var6, var7 = React.useBinding(UDim2.new())
    local var8, var9 = React.useBinding(UDim2.new())
    React.useLayoutEffect(function()
        local current = ref.current
        if current == nil then
            return nil
        end
        local function synchronize()
            var5(scrollingFrame.ZIndex + 1)
            local var10 = scrollingFrame.AbsolutePosition - current.AbsolutePosition
            local absoluteSize = scrollingFrame.AbsoluteSize
            var7(UDim2.fromOffset(var10.X, var10.Y))
            var9(UDim2.fromOffset(absoluteSize.X, absoluteSize.Y))
        end
        synchronize()
        local tbl2 = {
            scrollingFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(synchronize),
            scrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(synchronize),
            scrollingFrame:GetPropertyChangedSignal("ZIndex"):Connect(synchronize),
            current:GetPropertyChangedSignal("AbsolutePosition"):Connect(synchronize)
        }

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { scrollingFrame, var1 })

    if var1 == nil then
        return nil
    end
    return ReactRoblox.createPortal({
        ScrollingFrameCover = React.createElement("Folder", nil, {
            Bounds = React.createElement("ScrollingFrame", {
                Active = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                CanvasSize = UDim2.new(),
                ScrollBarThickness = 0,
                ScrollingEnabled = false,
                Selectable = false,
                Size = UDim2.fromScale(1, 1),
                ZIndex = zIndex,
                ref = ref
            }, {
                Cover = React.createElement(
                    View,
                    {
                        Position = var6,
                        Size = var8,
                        Visible = tbl1.Visible,
                        tag = "bg-surface-100",
                        testId = tbl1.testId
                    },
                    tbl1.children
                )
            })
        })
    }, var1)
end

return ScrollingFrameCover
