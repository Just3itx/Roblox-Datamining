-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Platform = require(script.Parent.Platform)
local getInputPlatform = require(script.Parent.getInputPlatform)
local PlatformIconMap = require(script.Parent.PlatformIconMap)
local UserInputService = require(script.Parent.Parent.Services).UserInputService
local GuiService = require(script.Parent.Parent.Services).GuiService

local tbl1 = {
    [Platform.PS4] = Enum.Platform.PS4,
    [Platform.PS5] = Enum.Platform.PS5,
    [Platform.Xbox] = Enum.Platform.XBoxOne
}

local function getPlatform() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(UserInputService.GetPlatform, UserInputService)

    if success then
        return result
    end

    local isTenFootInterface = GuiService:IsTenFootInterface()
    local inputPlatform = getInputPlatform()

    return if isTenFootInterface then tbl1[inputPlatform] else nil
end

local function getBuilderIconForCurrentPlatform()
    local platform = getPlatform()
    return PlatformIconMap[platform]
end

return getBuilderIconForCurrentPlatform
