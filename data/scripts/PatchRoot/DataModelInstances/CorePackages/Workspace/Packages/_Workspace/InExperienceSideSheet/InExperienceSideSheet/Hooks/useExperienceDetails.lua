-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local DataHydration = require(InExperienceSideSheetParent.DataHydration)
local React = require(InExperienceSideSheetParent.React)
local Signals = require(InExperienceSideSheetParent.Signals)
local SignalsReact = require(InExperienceSideSheetParent.SignalsReact)

local getUniverseId = require(InExperienceSideSheet.Utils.getUniverseId)

local function useExperienceDetails()
    local universeId = getUniverseId()

    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if not universeId then
                return { data = nil, isLoading = false }
            end

            local var1 = DataHydration.Game.getGameInfoStore(arg1).getAndFetchGameInfo(universeId)

            return {
                data = var1.data(arg1),
                isLoading = var1.status(arg1) == DataHydration.DataStatus.NotReady
            }
        end)
    end, { universeId })

    local var2 = SignalsReact.useSignalState(var1)
    local data = var2.data

    return if data then data.name else nil, if data then data.creator else nil, var2.isLoading
end

return useExperienceDetails
