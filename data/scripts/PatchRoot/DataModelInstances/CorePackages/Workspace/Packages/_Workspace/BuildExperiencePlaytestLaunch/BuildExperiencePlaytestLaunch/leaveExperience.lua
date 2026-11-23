-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local function leaveExperience(callback: ((...any) -> (...any))?)
    GuiService.SelectedCoreObject = nil

    RunService.RenderStepped:Wait()
    RunService.RenderStepped:Wait()

    if callback then
        callback()
    end

    game:Shutdown()
end

return leaveExperience
