-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local Roact = require(AppBloxParent.Roact)

local rect = Rect.new(1, 0, 2, 3)

local var1 = Roact.Component:extend("LoadingBar")

function var1.init(arg1)
    arg1.barRef = Roact.createRef()
end

function var1.render(arg1)
    local zIndex = arg1.props.ZIndex

    return Roact.createElement("ImageLabel", {
        Image = "rbxasset://textures/ui/LuaApp/9-slice/gr-loading-indicator.png",
        ScaleType = "Slice",
        SliceCenter = rect,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = zIndex,
        [Roact.Ref] = arg1.barRef
    })
end

function var1.didMount(arg1)
    arg1.connection = RunService.RenderStepped:Connect(function()
        local distributedGameTime = Workspace.DistributedGameTime
        local current = arg1.barRef.current

        local num1 = (1 - math.cos(2 * distributedGameTime * math.rad(288))) * 7.5
        current.Size = UDim2.new(0, num1 + 4, 0, 4)

        local num2 = math.cos(distributedGameTime * math.rad(288)) * 40
        current.Position = UDim2.new(0.5, num2 - num1 / 2 - 2, 0.5, 0)
    end)
end

function var1.willUnmount(arg1)
    arg1.connection:Disconnect()
end

return var1
