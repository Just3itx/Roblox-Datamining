-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local React = require(CorePackages.Packages.React)
local RoactUtils = require(CorePackages.Workspace.Packages.RoactUtils)
local Signals = require(CorePackages.Packages.Signals)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local Constants = require(ChromeShared.Unibar.Constants)

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeKeepOutAreas = CoreGuiCommon.Flags.FFlagTopBarSignalizeKeepOutAreas

local var1 = require(CorePackages.Workspace.Packages.SharedFlags).GetFIntLuaUIOcclusionMetricsReportingPeriodSeconds()

local engineFeature = game:GetEngineFeature("GuiServiceSendUIOcclusionMetricsForQueryRegion")

local function convertCoreUIPointToHardwareSafeAreaPoint(vector2: Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return vector2 + GuiService:GetGuiInset()
end

local function vector2ToUDim2(vector2: Vector2): UDim2 -- Luacid: Inlined by compiler; 4 call sites recovered
    return UDim2.fromOffset(vector2.X, vector2.Y)
end

local function reportOcclusionMetrics(current) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = convertCoreUIPointToHardwareSafeAreaPoint(current.position)
    GuiService:SendUIOcclusionMetricsForQueryRegion(vector2ToUDim2(var2), vector2ToUDim2(current.size), "currentSizeTR")
end

local function OcclusionMetricsManager()
    if not engineFeature then
        return
    end

    local effect = nil

    local var2 = React.useRef({ id = Constants.UNIBAR_KEEP_OUT_AREA_ID, position = Vector2.new(), size = Vector2.new() })

    if FFlagTopBarSignalizeKeepOutAreas then
        local keepOutAreasStore = CoreGuiCommon.Stores.GetKeepOutAreasStore(false)

        effect = Signals.createEffect(function(_)
            var2.current = keepOutAreasStore.getKeepOutAreas(false)[Constants.UNIBAR_KEEP_OUT_AREA_ID]
        end)
    else
        local current = useSelector(function(arg1)
            return arg1.displayOptions.keepOutAreas[Constants.UNIBAR_KEEP_OUT_AREA_ID]
        end)

        React.useEffect(function()
            var2.current = current
        end, { current })
    end

    React.useEffect(function()
        local var3 = task.spawn(function()
            while true do
                if var2.current then
                    reportOcclusionMetrics(var2.current)
                end

                task.wait(var1)
            end
        end)

        return function()
            task.cancel(var3)

            if FFlagTopBarSignalizeKeepOutAreas then
                effect()
            end
        end
    end, {})
end

return OcclusionMetricsManager
