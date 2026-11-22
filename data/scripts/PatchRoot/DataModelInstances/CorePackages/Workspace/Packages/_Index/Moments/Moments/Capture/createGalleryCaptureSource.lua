-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)

local FFlagMomentsCreationEntryOutcome = require(Moments.Flags.FFlagMomentsCreationEntryOutcome)

local FFlagMyStatsMediaSelector = SharedFlags.FFlagMyStatsMediaSelector

local function isCaptureEligible(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.CaptureType ~= Enum.CaptureType.Video or arg1.TimeLength == nil or not (arg1.TimeLength < 1) or false
end

local function createGalleryCaptureSource(tbl1, callback: ((...any) -> (...any))?, tbl2)
    local var1 = tbl1 or game:GetService("CaptureService")
    local tbl3 = tbl2 or {}

    local getCaptures, var3 = Signals.createSignal({})
    local getIsFinished, var5 = Signals.createSignal(false)

    local var6 = nil

    local function appendCurrentPage()
        local var7 = table.clone(getCaptures(false))
        for _, value in var6:GetCurrentPage() do
            if isCaptureEligible(value) then
                table.insert(var7, value)
            end
        end
        var3(var7)
        var5(var6.IsFinished == true)
    end

    local function fetchMore()
        if var6 == nil or var6.IsFinished == true then
            return
        end
        task.spawn(function()
            if not pcall(function()
                var6:AdvanceToNextPageAsync()
            end) then
                return
            end
            appendCurrentPage()
        end)
    end

    local function fetchInitial()
        task.spawn(function()
            local success, result = pcall(function()
                local var7, var8 = var1:ReadCapturesFromGalleryAsync(not FFlagMyStatsMediaSelector and {} or tbl3, true)
                var6 = var8
                return var7
            end)

            if not success or var6 == nil or result ~= Enum.ReadCapturesFromGalleryResult.Success then
                var6 = nil
                var5(true)
                if callback ~= nil then
                    callback(
                        {},
                        false,
                        if FFlagMomentsCreationEntryOutcome then if success and result == Enum.ReadCapturesFromGalleryResult.NeedPermission then "permission_denied" else "read_error" else nil
                    )
                end

                return
            end
            appendCurrentPage()
            if callback ~= nil then
                callback(getCaptures(false), true)
            end
        end)
    end

    fetchInitial()

    return { getCaptures = getCaptures, getIsFinished = getIsFinished, fetchMore = fetchMore }
end

return createGalleryCaptureSource
