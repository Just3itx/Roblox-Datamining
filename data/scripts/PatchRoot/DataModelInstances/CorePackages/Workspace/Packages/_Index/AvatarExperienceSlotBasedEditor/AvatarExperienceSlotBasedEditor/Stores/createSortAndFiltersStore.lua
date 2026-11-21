-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local AvatarExperienceFlags = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags)

local Signals = require(AvatarExperienceSlotBasedEditorParent.Signals)

local InventoryFilters = require(script.Parent.Parent.Enums.InventoryFilters)
local InventorySorts = require(script.Parent.Parent.Enums.InventorySorts)

local FFlagAXInventoryDurablesExpiredFilter = AvatarExperienceFlags.FFlagAXInventoryDurablesExpiredFilter

local function createSortAndFiltersStore()
    local getSortAndFilters, var2 = Signals.createSignal(
        FFlagAXInventoryDurablesExpiredFilter and {
            filter = InventoryFilters.Active,
            sort = InventorySorts.Newest
        }
            or {
                sort = InventorySorts.Newest
            }
    )

    return {
        getSortAndFilters = getSortAndFilters,
        getFiltersCount = Signals.createComputed(function(arg1)
            if not FFlagAXInventoryDurablesExpiredFilter then
                return if getSortAndFilters(arg1).sort == InventorySorts.Newest then 0 else 1
            end

            local var3 = getSortAndFilters(arg1)
            local num1 = 0
            if var3.sort ~= InventorySorts.Newest then
                num1 += 1
            end
            if var3.filter ~= InventoryFilters.Active then
                num1 += 1
            end
            return num1
        end),
        applySortAndFilters = function(tbl1)
            var2(tbl1)
        end
    }
end
return createSortAndFiltersStore
