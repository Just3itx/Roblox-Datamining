-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local SessionService = game:GetService("SessionService")

local Logger = require(SquadsCore.Logger)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local SquadRootViewType = require(SquadsCore.Enums.SquadRootViewType)
local SquadViewFlags = require(SquadsCore.Components.SquadExternalContractProvider.SquadViewFlags)

local React = require(SquadsCoreParent.React)
local SessionType = require(SquadsCoreParent.RobloxAppSessionization).SessionType

local Context = React.createContext({
    updateMetadata = function() end
})

return {
    Context = Context,
    Provider = function(tbl1)
        local var1 = React.useContext(SquadExternalContractContext)

        local var2 = var1.useSquadViewFlags()
        local var3 = var1.useSquadRootView()
        local var4 = if var1.squadLocation == SquadLocationEnum.InExperience then SessionType.StructuralIdentifier.SquadLobbyPageInExpSessionInfo else SessionType.StructuralIdentifier.SquadLobbyPageUASessionInfo
        local bool1 = not (bit32.band(var2, SquadViewFlags.SquadLobby) == 0) and var3 ~= SquadRootViewType.None

        local var5 = React.useCallback(function()
            local level1 = SessionType.StructuralIdentifier.Level1
            if level1 and SessionService:SessionExists(level1) and not SessionService:SessionExists(var4) then
                SessionService:SetSession(level1, var4, var4)
            end
        end, { var4, var1.squadLocation })

        local var6 = React.useCallback(function()
            if SessionService:SessionExists(var4) then
                SessionService:RemoveSession(var4)
            end
        end, { var4 })

        local updateMetadata = React.useCallback(function(key: string, arg1)
            if SessionService:SessionExists(var4) then
                SessionService:SetMetadata(var4, key, arg1)
                return
            end
            Logger:warning("Squad {} session does not exist, cannot update metadata with key {}, value {}", var4, key, arg1)
        end, { var4 })

        React.useEffect(function()
            if not bool1 then
                return function() end
            end

            var5()

            return function()
                var6()
            end
        end, { bool1, var5, var6 })

        return React.createElement(Context.Provider, { value = { updateMetadata = updateMetadata } }, tbl1.children)
    end
}
