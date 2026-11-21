-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local Cryo = require(AvatarExperienceSlotBasedEditorParent.Cryo)
local Signals = require(AvatarExperienceSlotBasedEditorParent.Signals)

local function createStaleInventoryGrantStore()
    local getStaleSearchUuids, var2 = Signals.createSignal({})

    local tbl1 = ({})

    local function isSearchUuidStale(str1: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return getStaleSearchUuids(false)[str1] == true
    end

    return {
        getStaleSearchUuids = getStaleSearchUuids,
        getRemovedItemIds = function(str1: string)
            return tbl1[str1]
        end,
        isSearchUuidStale = isSearchUuidStale,
        markSearchUuidStale = function(str1: string, tbl2)
            if tbl2 then
                local var3 = tbl1[str1]
                if var3 then
                    for _, value in tbl2 do
                        if not Cryo.List.find(var3, value) then
                            var3[#var3 + 1] = value
                        end
                    end
                else
                    tbl1[str1] = table.clone(tbl2)
                end
            end

            if isSearchUuidStale(str1) then
                return
            end
            var2(Cryo.Dictionary.join(getStaleSearchUuids(false), { [str1] = true }))
        end,
        clearSearchUuidStale = function(str1: string)
            tbl1[str1] = nil

            if not isSearchUuidStale(str1) then
                return
            end
            var2(Cryo.Dictionary.join(getStaleSearchUuids(false), { [str1] = Cryo.None }))
        end
    }
end
return createStaleInventoryGrantStore
