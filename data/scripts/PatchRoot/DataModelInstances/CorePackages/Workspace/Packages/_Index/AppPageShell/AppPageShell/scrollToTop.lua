-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local AppPageShellParent = script:FindFirstAncestor("AppPageShell").Parent
local Responsive = require(AppPageShellParent.Responsive)

local function scrollToTop(arg1: Instance)
    if UserGameSettings.ReducedMotion then
        arg1.CanvasPosition = Vector2.new(0, 0)
        return
    end

    if Responsive.GetInputModeStore(false).getLastInputType(false) ~= Responsive.Input.Directional then
        arg1:ScrollToTop()
        return
    end

    local tween = TweenService:Create(arg1, TweenInfo.new(0.3), { CanvasPosition = Vector2.new(0, 0) })

    tween:Play()
    tween.Completed:Connect(function()
        GuiService:Select(arg1)

        task.defer(function()
            if arg1.Parent ~= nil then
                GuiService:Select(arg1)
            end
        end)
    end)
end

return scrollToTop
