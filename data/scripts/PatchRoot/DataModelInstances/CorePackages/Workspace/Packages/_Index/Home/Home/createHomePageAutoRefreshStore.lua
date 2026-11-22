-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local Signals = require(HomeParent.Signals)
local getSduiApiStore = require(HomeParent.SduiSharedUtilities).getSduiApiStore
local HomeConstants = require(Home.HomeConstants)
local refreshHomePage = require(Home.refreshHomePage)

local num1 = game:DefineFastInt("SduiHomePageAutoRefreshIntervalSeconds", 10800)

local function defaultSchedule(num2: number, callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool1 = true
    local var1 = task.defer(function()
        local num3 = num2
        while num3 > 0 and bool1 do
            num3 -= task.wait(math.min(num3, 300))
        end
        if bool1 then
            bool1 = false
            callback()
        end
    end)
    return function()
        if bool1 then
            bool1 = false
            task.cancel(var1)
        end
    end
end

local function createHomePageAutoRefreshStore()
    local var1 = nil
    local effect = nil

    local function clearTimer() -- Luacid: Inlined by compiler; 3 call sites recovered
        if var1 then
            var1()
            var1 = nil
        end
    end

    local function stop() -- Luacid: Inlined by compiler; 1 call site recovered
        if effect then
            effect()
            effect = nil
        end

        clearTimer()
    end

    local function scheduleRefresh(num2: number)
        var1 = defaultSchedule(num2, function()
            var1 = nil
            local var2 = refreshHomePage(HomeConstants.RequestIntent.AutoRefresh, nil, false)
            if not var2 then
                return
            end

            var2:catch(function(arg1)
                warn("We failed to auto-refresh SDUI Home!", arg1)
                if num1 > 0 then
                    scheduleRefresh(num1)
                end
            end)
        end)
    end

    return {
        start = function()
            stop()

            effect = Signals.createEffect(function(arg1)
                local var2 = getSduiApiStore().getDataUpdatedTimestamp(HomeConstants.ConfigKey, arg1)
                clearTimer()

                if not var2 or not (num1 > 0) then
                    return
                end
                local var3 = var2 + num1 - os.clock()

                var1 = defaultSchedule(math.max(0, var3), function()
                    var1 = nil
                    local var4 = refreshHomePage(HomeConstants.RequestIntent.AutoRefresh, nil, false)
                    if not var4 then
                        return
                    end

                    var4:catch(function(arg2)
                        warn("We failed to auto-refresh SDUI Home!", arg2)
                        if num1 > 0 then
                            scheduleRefresh(num1)
                        end
                    end)
                end)
            end)

            return stop
        end
    }
end
return createHomePageAutoRefreshStore
