-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local GamePermissions = require(BuildExperienceParent.DataHydration.GamePermissions)
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local permissions = table.freeze({
    canEdit = true,
    canEditOnBuild = true,
    canPublish = true,
    canMonetize = true,
    canViewAnalytics = true,
    canPreview = true,
    canAdvertise = true,
    canViewOnCreatorHub = true
})

local var1 = table.freeze({
    canEdit = false,
    canEditOnBuild = false,
    canPublish = false,
    canMonetize = false,
    canViewAnalytics = false,
    canPreview = true,
    canAdvertise = false,
    canViewOnCreatorHub = true
})

local var3 = table.freeze({ permissions = permissions, isLoading = false })
local var4 = table.freeze({ permissions = var1, isLoading = false })
local var5 = table.freeze({ permissions = var1, isLoading = true })

local function useGamePermissions(tbl1)
    local gamePermissionsStore = tbl1.gamePermissionsStore or GamePermissions.getGamePermissionsStore()
    local universeId = tbl1.universeId
    local bool1 = tbl1.isNewGame == true

    local var6 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if bool1 or universeId == nil or universeId == 0 then
                return var3
            end

            local andFetchUniversePermissions = gamePermissionsStore.getAndFetchUniversePermissions(universeId)
            local var2 = andFetchUniversePermissions.data(arg1)

            if var2 == nil then
                if andFetchUniversePermissions.status(arg1) == "Failed" then
                    return var4
                end

                return var5
            end

            return { permissions = var2, isLoading = false }
        end)
    end, { gamePermissionsStore, universeId, bool1 })

    local var7 = SignalsReact.useSignalState(var6)
    return var7.permissions, var7.isLoading
end

return useGamePermissions
