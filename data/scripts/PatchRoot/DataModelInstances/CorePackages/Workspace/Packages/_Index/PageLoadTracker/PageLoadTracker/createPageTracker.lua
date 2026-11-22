-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local recordMilestone = require(script.Parent.recordMilestone)
local PageLoadConfig = require(script.Parent.PageLoadConfig)
local _PageLoadTypes = require(script.Parent.PageLoadTypes)
local Signal = require(script.Parent.Parent.AppCommonLib).Signal
local SharedFlags = require(script.Parent.Parent.SharedFlags)
local isElementContentful = require(script.Parent.isElementContentful)

local IDLE_TIMEOUT_SECONDS = PageLoadConfig.IDLE_TIMEOUT_SECONDS

local function getGuiObjectArea(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.AbsoluteSize.X * arg1.AbsoluteSize.Y
end

local function createPageTracker()
    local module = {
        pageName = "",
        startTime = 0,
        lastActivityTime = 0,
        timeoutThread = nil,
        isActive = false,
        numLoads = 0,
        onCompleteSignal = Signal.new(),
        sentMilestones = {}
    }

    function module.start(tbl1, pageName: string)
        if tbl1.isActive then
            return
        end

        tbl1.pageName = pageName or "UnknownPage"
        tbl1.startTime = os.clock()
        tbl1.lastActivityTime = tbl1.startTime
        tbl1.isActive = true
        tbl1.numLoads += 1
        tbl1.sentMilestones = {}
        if SharedFlags.FFlagLuaAppEnableContentfulPaintTracking then
            if SharedFlags.FFlagLuaAppLCPTimingFix then
                tbl1.LCPCandidate = {
                    guiArea = 0,
                    timestamp = tbl1.startTime
                }
            else
                tbl1.LCPCandidate = { guiArea = 0, timestamp = 0 }
            end
        end

        tbl1.timeoutThread = task.delay(IDLE_TIMEOUT_SECONDS, function()
            tbl1:complete()
        end)
    end

    function module.logMilestone(arg1)
        if not arg1.isActive then
            return
        end

        arg1.lastActivityTime = os.clock()

        if arg1.timeoutThread then
            task.cancel(arg1.timeoutThread)
        end

        arg1.timeoutThread = task.delay(IDLE_TIMEOUT_SECONDS, function()
            arg1:complete()
        end)
    end

    function module:sendMilestone(milestoneName: string, num1: number?)
        local timeFromStart = if SharedFlags.FFlagLuaAppEnableContentfulPaintTracking then ((num1 or os.clock()) - self.startTime) * 1000 else (os.clock() - self.startTime) * 1000

        if SharedFlags.FFlagLuaAppEnableMilestoneDeduplication then
            if self.sentMilestones[milestoneName] then
                return
            end

            self.sentMilestones[milestoneName] = true
        end

        local tbl1 = {
            app_page_name = self.pageName,
            milestone_name = milestoneName,
            time_from_start = timeFromStart,
            first_load = self.numLoads == 1
        }
        recordMilestone(tbl1)
    end

    function module.onComponentAdded(tbl1, arg1)
        if not tbl1.isActive then
            return
        end

        if SharedFlags.FFlagLuaAppEnableContentfulPaintTracking and isElementContentful(arg1) then
            local guiArea = getGuiObjectArea(arg1)

            if tbl1.LCPCandidate.guiArea < guiArea then
                tbl1:sendMilestone("first_contentful_paint")
                tbl1.LCPCandidate = {
                    guiArea = guiArea,
                    timestamp = os.clock()
                }
            end
        end

        tbl1:logMilestone()
    end

    function module.stop(arg1)
        if not arg1.isActive then
            return
        end

        if arg1.timeoutThread then
            task.cancel(arg1.timeoutThread)
            arg1.timeoutThread = nil
        end

        arg1.isActive = false
        if SharedFlags.FFlagPageLoadAllowImprovedDisconnectTiming then
            arg1.onCompleteSignal:fire()
        end
    end

    function module:complete()
        if not self.isActive then
            return
        end

        if not SharedFlags.FFlagLuaAppEnableContentfulPaintTracking then
            self.isActive = false
        end

        self.timeoutThread = nil

        if SharedFlags.FFlagLuaAppEnableContentfulPaintTracking then
            self:sendMilestone("initial_viewport_loaded", self.lastActivityTime)
            if not SharedFlags.FFlagLuaAppLCPTimingFix or self.LCPCandidate.guiArea > 0 then
                self:sendMilestone("largest_contentful_paint", self.LCPCandidate.timestamp)
            end
        else
            local timeFromStart = (self.lastActivityTime - self.startTime) * 1000
            local tbl1 = {
                app_page_name = self.pageName,
                milestone_name = "initial_viewport_loaded",
                time_from_start = timeFromStart,
                first_load = self.numLoads == 1
            }
            recordMilestone(tbl1)
        end

        if SharedFlags.FFlagPageLoadAllowImprovedDisconnectTiming then
            self.onCompleteSignal:fire()
        end
    end

    return module
end

return createPageTracker
