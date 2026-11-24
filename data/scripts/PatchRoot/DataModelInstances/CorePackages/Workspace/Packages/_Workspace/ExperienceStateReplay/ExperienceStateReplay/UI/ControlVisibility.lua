-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local mouse = game:GetService("Players").LocalPlayer:GetMouse()

local TweenService = game:GetService("TweenService")

function module.setupControl(arg1)
    local num1 = os.time()
    local bool1 = false
    local bool2 = false

    mouse.Move:Connect(function()
        num1 = os.time()
    end)

    arg1.ControlBarContainer.MouseEnter:Connect(function()
        bool1 = true
    end)

    arg1.ControlBarContainer.MouseLeave:Connect(function()
        bool1 = false
    end)

    local var1 = nil
    local function createTween()
        var1 = TweenService:Create(
            arg1.ControlBarContainer,
            TweenInfo.new(2),
            {
                Position = arg1.ControlBarContainerNonVisiblePosition
            }
        )

        if var1 then
            var1.Completed:Connect(function()
                createTween()
            end)

            return
        end

        error("Failed to create tween for control visibility")
    end

    createTween()

    task.spawn(function()
        while true do
            if not var1 then
                error("No current tween for control visibility")
            end
            if not bool1 and os.time() - num1 > 2 then
                if not bool2 then
                    bool2 = true
                    var1:Play()
                end
            elseif bool2 then
                bool2 = false
                var1:Cancel()
                arg1.ControlBarContainer.Position = arg1.ControlBarContainerVisiblePosition
            end

            task.wait(0.1)
        end
    end)
end

return module
