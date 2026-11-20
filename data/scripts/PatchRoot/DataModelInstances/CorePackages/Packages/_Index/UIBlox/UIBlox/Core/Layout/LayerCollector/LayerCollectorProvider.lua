-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)

local LayerCollectorContext = require(script.Parent.LayerCollectorContext)
local GuiService = game:GetService("GuiService")
local var1 = Roact.PureComponent:extend("LayerCollectorProvider")

function var1.init(arg1)
    arg1.rootRef = Roact.createRef()
    arg1.state = {
        absoluteSize = Vector2.new(0, 0),
        insets = { top = 0, left = 0, bottom = 0, right = 0 }
    }
end

function var1.watchLayerCollector(tbl1, arg1)
    local absoluteSize = arg1.AbsoluteSize
    local vector2 = Vector2.new(0, 0)
    local vector2_2 = Vector2.new(0, 0)

    if arg1:IsA("ScreenGui") then
        local success, result = pcall(function(): boolean
            return arg1.IgnoreGuiInset
        end)
        if success and result then
            vector2, vector2_2 = GuiService:GetGuiInset()
        end
    end

    tbl1:setState({
        absoluteSize = absoluteSize,
        insets = {
            top = vector2.Y,
            left = vector2.X,
            bottom = vector2_2.Y,
            right = vector2_2.X
        }
    })

    tbl1.absoluteSizeConnection = arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        absoluteSize = arg1.AbsoluteSize
        tbl1:setState({
            absoluteSize = absoluteSize,
            insets = {
                top = vector2.Y,
                left = vector2.X,
                bottom = vector2_2.Y,
                right = vector2_2.X
            }
        })
    end)
end

function var1.didMount(arg1)
    local current = arg1.rootRef.current
    local layerCollector = current:FindFirstAncestorWhichIsA("LayerCollector")

    if layerCollector ~= nil then
        arg1:watchLayerCollector(layerCollector)
        return
    end

    arg1.ancestryConnection = current.AncestryChanged:Connect(function()
        layerCollector = current:FindFirstAncestorWhichIsA("LayerCollector")
        if layerCollector ~= nil then
            arg1.ancestryConnection:Disconnect()
            arg1.ancestryConnection = nil
            arg1:watchLayerCollector(layerCollector)
        end
    end)
end

function var1.render(arg1)
    local createElement = Roact.createElement
    local provider = LayerCollectorContext.Provider
    local tbl1 = {
        value = {
            absoluteSize = arg1.state.absoluteSize,
            insets = arg1.state.insets
        }
    }
    local tbl2 = {
        LayerCollectorChildRef = Roact.createElement("Frame", { Visible = false, [Roact.Ref] = arg1.rootRef }),
        Children = Roact.createFragment(arg1.props[Roact.Children])
    }
    return createElement(provider, tbl1, tbl2)
end

return var1
