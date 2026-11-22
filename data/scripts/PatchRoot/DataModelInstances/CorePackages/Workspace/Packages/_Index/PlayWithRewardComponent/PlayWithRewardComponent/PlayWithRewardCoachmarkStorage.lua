-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local PlayWithRewardComponentParent = script:FindFirstAncestor("PlayWithRewardComponent").Parent
local SharedFlags = require(PlayWithRewardComponentParent.SharedFlags)
local t = require(PlayWithRewardComponentParent.t)

local FFlagPlayWithRewardCoachmarkOverlayFix = SharedFlags.FFlagPlayWithRewardCoachmarkOverlayFix
local bool1 = game:DefineFastFlag("PlayWithRewardCoachmarkWindowResets", false)
local num1 = game:DefineFastInt("PlayWithRewardCoachmarkMaxImpressions", 3)
local num2 = game:DefineFastInt("PlayWithRewardCoachmarkMaxImpressions2", 3)
local num3 = game:DefineFastInt("PlayWithRewardCoachmarkWindowDays", 30)
local engineFeature = game:GetEngineFeature("PlayWithRewardCoachmarkStorageKey")

local num4 = num3 * 86400

local var1 = t.interface({ windowStartTime = t.number, impressionCount = t.number, isDismissed = t.boolean })

local function getDefaultState() -- Luacid: Inlined by compiler; 1 call site recovered
    return { windowStartTime = 0, impressionCount = 0, isDismissed = false }
end

local function parseState(arg1) -- Luacid: unused: defined but never referenced
    if not var1(arg1) then
        return getDefaultState()
    end

    return arg1
end

local function readStateLookup()
    if not engineFeature then
        return nil
    end

    local success, result = pcall(function(): string
        return AppStorageService:GetItem("PlayWithRewardCoachmark")
    end)
    if not success or type(result) ~= "string" then
        return nil
    end

    if result == "" then
        return {}
    end

    local success2, result2 = pcall(function()
        return HttpService:JSONDecode(result)
    end)
    return if success2 and type(result2) == "table" then result2 else {}
end

local function writeStateLookup(input): boolean
    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    if not success or type(result) ~= "string" then
        return false
    end

    return (pcall(function()
        AppStorageService:SetItem("PlayWithRewardCoachmark", result)
        AppStorageService:Flush()
    end))
end

local function mutateStateLookup(num5: number, func1: (...any) -> (...any)) -- Luacid: unused: defined but never referenced
    local var2 = readStateLookup()
    if var2 == nil then
        return false
    end

    local str1 = tostring(num5)
    local var3 = var2[str1]
    local var4 = func1(not var1(var3) and { windowStartTime = 0, impressionCount = 0, isDismissed = false } or var3)
    if var4 == nil then
        return false
    end

    var2[str1] = var4
    return (writeStateLookup(var2))
end

local function hasWindowExpired(tbl1, num5: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool2

    if tbl1.windowStartTime > 0 then
        local var2 = num5 - tbl1.windowStartTime
        bool2 = num4 <= var2
    else
        bool2 = false
    end

    return bool2
end

local module = {}

function module.consumeImpressionIfEligible(num5: number)
    local num6 = if FFlagPlayWithRewardCoachmarkOverlayFix then num2 else num1

    if not engineFeature or num6 <= 0 or num4 <= 0 then
        return false
    end

    local windowStartTime = os.time()
    local tbl1 = { windowStartTime = windowStartTime, impressionCount = 1, isDismissed = false }

    local function _(arg1) -- Luacid: unused: defined but never referenced
        if arg1.windowStartTime == 0 then
            return tbl1
        end

        if hasWindowExpired(arg1, windowStartTime) then
            return if bool1 then tbl1 else nil
        end

        if not (arg1.isDismissed or arg1.impressionCount >= num6) then
            arg1.impressionCount += 1
            return arg1
        end

        return nil
    end

    local var2 = readStateLookup()
    if var2 == nil then
        return false
    end

    local str1 = tostring(num5)
    local var3 = var2[str1]
    local var4 = not var1(var3) and {
        windowStartTime = 0,
        impressionCount = 0,
        isDismissed = false
    } or var3

    if var4.windowStartTime == 0 then
        var4 = tbl1
    elseif hasWindowExpired(var4, windowStartTime) then
        if bool1 then
            var4 = tbl1
        else
            var4 = nil
        end
    elseif var4.isDismissed or num6 <= var4.impressionCount then
        var4 = nil
    else
        var4.impressionCount += 1
    end

    if var4 == nil then
        return false
    end

    var2[str1] = var4
    return (writeStateLookup(var2))
end

function module.dismissCurrentWindow(num5: number)
    local function func1(nil1: nil) -- Luacid: Inlined by compiler; 1 call site recovered
        if nil1.windowStartTime == 0 or nil1.isDismissed then
            return nil
        end

        nil1.isDismissed = true
        return nil1
    end

    local var2 = readStateLookup()
    if var2 == nil then
        return
    end

    local str1 = tostring(num5)
    local var3 = var2[str1]
    local var4 = func1(not var1(var3) and { windowStartTime = 0, impressionCount = 0, isDismissed = false } or var3)

    if var4 == nil then
        return
    end

    var2[str1] = var4
    writeStateLookup(var2)
end

return module
