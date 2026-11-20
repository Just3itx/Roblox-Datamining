-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings

local StyleWidgets = require(CoreGui.RobloxGui.Modules.StyleWidgets)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local _mutedError = require(CorePackages.Workspace.Packages.Loggers).mutedError

function LocalizeWithFallback(arg1, arg2)
    local success, result = pcall(function()
        return RobloxTranslator:FormatByKey(arg1)
    end)

    return success and result or arg2
end

local module = {
    SelectedBackgroundColor = Color3.new(0.4, 0.4, 0.4),
    FontColor = Color3.new(1, 1, 1),
    GraphBarGreenColor = Color3.new(42 / 85, 211 / 255, 11 / 85),
    GraphBarYellowColor = Color3.new(209 / 255, 211 / 255, 11 / 85),
    GraphBarRedColor = Color3.new(211 / 255, 88 / 255, 11 / 85),
    GraphAverageLineColor = Color3.new(208 / 255, 1 / 255, 9 / 85),
    GraphAverageLineBorderColor = Color3.new(1, 1, 1),
    NormalColor = Color3.fromRGB(31, 31, 31),
    Transparency = 0.5,
    MiniPanelTitleFontSize = Enum.FontSize.Size12,
    MiniPanelValueFontSize = Enum.FontSize.Size10,
    PanelTitleFontSize = Enum.FontSize.Size24,
    PanelValueFontSize = Enum.FontSize.Size14,
    PanelGraphFontSize = Enum.FontSize.Size10,
    ButtonHeight = 36 + StyleWidgets.TabSelectionHeight,
    ViewerTopMargin = 10,
    ViewerHeight = 144,
    ViewerWidth = 306,
    TextZIndex = 5,
    GraphZIndex = 2,
    GraphTargetLineInnerThickness = 2,
    GraphAverageLineInnerThickness = 2,
    GraphAverageLineBorderThickness = 1
}
module.GraphAverageLineTotalThickness = module.GraphAverageLineInnerThickness + 2 * module.GraphAverageLineBorderThickness

module.TextPanelTitleHeightY = 52
module.TextPanelLegendItemHeightY = 20

module.TextPanelLeftMarginPix = 10
module.TextPanelTopMarginPix = 10

module.DecorationSize = 12
module.OvalKeySize = 8
module.TargetKeyWidth = 11
module.TargetKeyHeight = 2
module.DecorationMargin = 6

module.StatType_Memory = "st_Memory"
module.StatType_CPU = "st_CPU"
module.StatType_GPU = "st_GPU"
module.StatType_NetworkSent = "st_NetworkSent"
module.StatType_NetworkReceived = "st_NetworkReceived"
module.StatType_Ping = "st_Ping"

module.AllStatTypes = {
    module.StatType_Memory,
    module.StatType_CPU,
    module.StatType_GPU,
    module.StatType_NetworkSent,
    module.StatType_NetworkReceived,
    module.StatType_Ping
}

module.StatNames = {
    [module.StatType_Memory] = "Memory",
    [module.StatType_CPU] = "CPU",
    [module.StatType_GPU] = "GPU",
    [module.StatType_NetworkSent] = "NetworkSent",
    [module.StatType_NetworkReceived] = "NetworkReceived",
    [module.StatType_Ping] = "Ping"
}

module.StatMaxNames = {
    [module.StatType_Memory] = "MaxMemory",
    [module.StatType_CPU] = "MaxCPU",
    [module.StatType_GPU] = "MaxGPU",
    [module.StatType_NetworkSent] = "MaxNetworkSent",
    [module.StatType_NetworkReceived] = "MaxNetworkReceived",
    [module.StatType_Ping] = "MaxPing"
}

module.NumButtonTypes = #module.AllStatTypes

local var1 = LocalizeWithFallback("InGame.UnknownNamespace.Network", "Network")
local var2 = LocalizeWithFallback("InGame.UnknownNamespace.Sent", "Sent") .. "\n" .. var1
local var3 = LocalizeWithFallback("InGame.UnknownNamespace.Received", "Received") .. "\n" .. var1

module.TypeToName = {
    [module.StatType_Memory] = "Memory",
    [module.StatType_CPU] = "CPU",
    [module.StatType_GPU] = "GPU",
    [module.StatType_NetworkSent] = var2,
    [module.StatType_NetworkReceived] = var3,
    [module.StatType_Ping] = "NetworkPing"
}

module.TypeToShortName = {
    [module.StatType_Memory] = "Mem",
    [module.StatType_CPU] = "CPU",
    [module.StatType_GPU] = "GPU",
    [module.StatType_NetworkSent] = "Sent",
    [module.StatType_NetworkReceived] = "Recv",
    [module.StatType_Ping] = "NetworkPing"
}

module.MemoryAnalyzerTypeToName = {
    HumanoidTexture = "Humanoid Textures",
    HumanoidTextureOrphan = "Humanoid Textures (Unused)",
    OtherTexture = "Other Textures",
    OtherTextureOrphan = "Other Textures (Unused)",
    CoreScript = "Core Scripts",
    UserScript = "User Scripts",
    Sounds = "Sounds",
    CSG = "Solid Models",
    Meshes = "Meshes"
}

function module.GetMemoryAnalyzerStatName(arg1)
    return if module.MemoryAnalyzerTypeToName[arg1] == nil then arg1 else module.MemoryAnalyzerTypeToName[arg1]
end

function module.StyleFrame(arg1)
    arg1.BackgroundColor3 = module.NormalColor
    arg1.BackgroundTransparency = module.Transparency
end

function module.StyleButton(arg1)
    arg1.BackgroundColor3 = module.NormalColor
    arg1.BackgroundTransparency = module.Transparency
end

function module.StyleTextWidget(arg1)
    arg1.BackgroundTransparency = 1
    arg1.TextColor3 = module.FontColor
    arg1.Font = Enum.Font.SourceSansBold
end

function module.StyleButtonSelected(arg1, arg2)
    module.StyleButton(arg1)
    if arg2 then
        arg1.BackgroundColor3 = module.SelectedBackgroundColor
    end
end

function module.FormatTypedValue(arg1, arg2)
    if arg2 == module.StatType_Memory then
        return string.format("%.2f MB", arg1)
    end

    if arg2 == module.StatType_CPU then
        return string.format("%.2f ms", arg1)
    end

    if arg2 == module.StatType_GPU then
        return string.format("%.2f ms", arg1)
    end

    if arg2 == module.StatType_NetworkSent then
        return string.format("%.2f KB/s", arg1)
    end

    if arg2 == module.StatType_NetworkReceived then
        return string.format("%.2f KB/s", arg1)
    end

    if arg2 == module.StatType_Ping then
        return string.format("%.0f ms", arg1)
    end
end

function module.StyleAverageLine(arg1)
    arg1.BackgroundColor3 = module.GraphAverageLineColor
    arg1.BorderSizePixel = module.GraphAverageLineBorderThickness
    arg1.BorderColor3 = module.GraphAverageLineBorderColor
end

function module.GetColorForValue(arg1, arg2)
    if arg1 < 0.666 * arg2 then
        return module.GraphBarGreenColor
    end

    if arg1 < 1.333 * arg2 then
        return module.GraphBarYellowColor
    end

    return module.GraphBarRedColor
end

function module.PerformanceStatsShouldBeVisible()
    local localPlayer = Players.LocalPlayer
    return GameSettings.PerformanceStatsVisible and localPlayer ~= nil
end

return module
