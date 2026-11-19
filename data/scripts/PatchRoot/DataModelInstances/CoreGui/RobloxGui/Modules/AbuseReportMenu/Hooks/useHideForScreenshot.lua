-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local React = require(CorePackages.Packages.React)

local num1 = game:DefineFastInt("AbuseReportMenuScreenshotReduceMotionWaitFrames", 20)
local num2 = game:DefineFastInt("AbuseReportMenuScreenshotWaitFrames", 10)
local FFlagIEMTabFocusNav = require(CorePackages.Workspace.Packages.SharedFlags).FFlagIEMTabFocusNav

local UserGameSettings = UserSettings():GetService("UserGameSettings")

local function func1(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if UserGameSettings.ReducedMotion then num1 else num2
end

local function func2(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if UserGameSettings.ReducedMotion then num1 / 60 else num2 / 60
end

return function(arg1, arg2, callback, callback2, callback3, callback4)
    local var1, var2 = React.useState(false)
    local var3 = if FFlagIEMTabFocusNav then React.useRef(nil) else nil

    React.useEffect(function()
        if not arg2 then
            if not var1 then
                callback4()
            end

            return
        end

        if var1 then
            if FFlagIEMTabFocusNav and var3.current and var3.current:IsDescendantOf(game) then
                GuiService.SelectedCoreObject = var3.current
                var3.current = nil
            end
            var2(false)
            return
        end

        if not arg1 then
            return
        end

        if FFlagIEMTabFocusNav then
            var3.current = GuiService.SelectedCoreObject
        end
        var2(true)
        callback()

        local connection = nil
        local num3 = 0
        local num4 = 0
        local connection2 = nil

        local startTime = os.clock()

        connection = RunService.Heartbeat:Connect(function()
            if num3 == 1 then
                callback3()
                connection:Disconnect()
                return
            end

            num3 += 1
        end)

        connection2 = RunService.Heartbeat:Connect(function()
            if os.clock() - startTime >= func2() and num4 >= func1() then
                connection2:Disconnect()
                callback2()
                return
            end

            num4 += 1
        end)
    end, { arg2 })
end
